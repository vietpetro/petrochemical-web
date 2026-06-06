import csv
import hashlib
import json
import os
import re
import sys
from datetime import datetime, timedelta, timezone
from pathlib import Path
from urllib.parse import urlparse

DATA_DIR = Path.home() / '.openclaw' / 'data'
SEEN_PATH = DATA_DIR / 'real_estate_seen.json'
OUT_JSON = DATA_DIR / 'real_estate_latest.json'
OUT_CSV = DATA_DIR / 'real_estate_latest.csv'
TZ = timezone(timedelta(hours=7))
NOW = datetime.now(TZ)

SITES = [
    'batdongsan.com.vn', 'muaban.net', 'chotot.com', 'alonhadat.com.vn', 'mogi.vn'
]
QUERIES = [
    'site:{site} Hà Nội bán nhà chính chủ 2 tỷ 5 tỷ số điện thoại',
    'site:{site} Hà Nội cần bán nhà phố chính chủ 2 tỷ 5 tỷ',
    'site:{site} Hà Nội bán nhà mặt tiền chính chủ 2 tỷ 5 tỷ',
]

PHONE_RE = re.compile(r'(?:\+?84|0)(?:[\s.\-]?\d){9,10}')
PRICE_RE = re.compile(r'(?:(\d+(?:[\.,]\d+)?)\s*(tỷ|ty|tỉ|ti|triệu|trieu))', re.I)
AREA_RE = re.compile(r'(\d+(?:[\.,]\d+)?)\s*(?:m2|m²|m\^2|㎡)', re.I)

BLOCKED_WORDS = ['chung cư', 'can ho', 'căn hộ', 'nhà tập thể', 'tap the']
TYPE_WORDS = ['nhà phố', 'nha pho', 'nhà mặt tiền', 'mặt tiền', 'mat tien', 'bán nhà', 'ban nha']
OWNER_WORDS = ['chính chủ', 'chinh chu', 'cần bán', 'can ban', 'không qua môi giới', 'khong qua moi gioi']


def load_seen():
    DATA_DIR.mkdir(parents=True, exist_ok=True)
    if not SEEN_PATH.exists():
        SEEN_PATH.write_text('[]', encoding='utf-8')
    try:
        data = json.loads(SEEN_PATH.read_text(encoding='utf-8'))
        return set(data if isinstance(data, list) else data.get('urls', []))
    except Exception:
        return set()


def save_seen(seen):
    SEEN_PATH.write_text(json.dumps(sorted(seen), ensure_ascii=False, indent=2), encoding='utf-8')


def clean_html(s):
    s = re.sub(r'<script.*?</script>|<style.*?</style>', ' ', s, flags=re.I|re.S)
    s = re.sub(r'<[^>]+>', ' ', s)
    s = re.sub(r'&nbsp;', ' ', s)
    s = re.sub(r'&amp;', '&', s)
    s = re.sub(r'\s+', ' ', s).strip()
    return s


def normalize_phone(s):
    m = PHONE_RE.search(s or '')
    if not m:
        return None
    digits = re.sub(r'\D', '', m.group(0))
    if digits.startswith('84') and len(digits) == 11:
        digits = '0' + digits[2:]
    return digits if len(digits) == 10 and digits.startswith('0') else None


def parse_price(text):
    if re.search(r'thương lượng|thuong luong|thoả thuận|thỏa thuận', text, re.I):
        return None
    vals = []
    for num, unit in PRICE_RE.findall(text):
        v = float(num.replace(',', '.'))
        u = unit.lower()
        if u in ['tỷ', 'ty', 'tỉ', 'ti']:
            vals.append(int(v * 1_000_000_000))
        else:
            vals.append(int(v * 1_000_000))
    # prefer values in target range
    for v in vals:
        if 2_000_000_000 <= v <= 5_000_000_000:
            return v
    return vals[0] if vals else None


def parse_area(text):
    m = AREA_RE.search(text or '')
    return float(m.group(1).replace(',', '.')) if m else None


def parse_posted(text):
    low = (text or '').lower()
    m = re.search(r'(\d+)\s*(phút|phut|giờ|gio|h|ngày|ngay)\s*(trước|truoc)?', low)
    if m:
        n = int(m.group(1)); unit = m.group(2)
        if unit in ['phút', 'phut']:
            return NOW - timedelta(minutes=n)
        if unit in ['giờ', 'gio', 'h']:
            return NOW - timedelta(hours=n)
        if unit in ['ngày', 'ngay']:
            return NOW - timedelta(days=n)
    # if page doesn't expose date, must not invent
    return None


def parse_location(text):
    # conservative snippets containing Hà Nội; null if no useful detail
    m = re.search(r'((?:Phường|Xã|Quận|Huyện|Thị xã|TP\.?|Thành phố)[^\n\.;,]{0,80}Hà Nội|Hà Nội[^\n\.;]{0,80})', text, re.I)
    return m.group(1).strip() if m else None


def score_item(price, area, is_owner, posted):
    if price is None or area is None:
        return None
    score = 100 - (price / 30_000_000) + (area / 5)
    if is_owner: score += 20
    if posted and (NOW - posted) <= timedelta(hours=12): score += 15
    return round(max(0, min(100, score)), 2)


def item_from(title, url, text):
    full = f'{title} {text}'
    low = full.lower()
    if 'hà nội' not in low and 'ha noi' not in low:
        return None
    if any(w in low for w in BLOCKED_WORDS):
        return None
    if not any(w in low for w in TYPE_WORDS):
        return None
    is_owner = any(w in low for w in OWNER_WORDS)
    if not is_owner:
        return None
    price = parse_price(full)
    if price is None or not (2_000_000_000 <= price <= 5_000_000_000):
        return None
    phone = normalize_phone(full)
    if not phone:
        return None
    area = parse_area(full)
    posted = parse_posted(full)
    if posted is None or (NOW - posted) > timedelta(hours=24):
        return None
    reasons = []
    if is_owner: reasons.append('chính chủ')
    if area and area >= 60: reasons.append('diện tích rộng')
    age = NOW - posted
    if age <= timedelta(hours=12): reasons.append(f'tin mới {max(1, int(age.total_seconds()//3600))} giờ')
    # price median requires reliable district comps; only assert when heuristic unit price is low
    if area and price / area < 60_000_000:
        reasons.append('giá rẻ')
    return {
        'title': title or None,
        'price': price,
        'area': area,
        'location': parse_location(full),
        'phone': phone,
        'posted_time': posted.isoformat() if posted else None,
        'url': url,
        'score': score_item(price, area, is_owner, posted),
        'hot_reason': reasons,
    }


def run_real_estate_monitor():

    seen = load_seen()
    found = []
    urls_checked = set()
    for site in SITES:
        for tmpl in QUERIES:
            q = tmpl.format(site=site)
            try:
                search_res = default_api.web_search(query=q, count=6, date_after=(NOW - timedelta(days=1)).strftime('%Y-%m-%d'), date_before=NOW.strftime('%Y-%m-%d'), language='vi', ui_lang='vi-VN')
                if search_res.get("web_search_response") and search_res["web_search_response"].get("results"):
                    results = [(r["title"], r["link"]) for r in search_res["web_search_response"]["results"]]
                else:
                    results = []
            except Exception as e:
                print(f'search failed {q}: {e}', file=sys.stderr)
                continue
            for title, url in results:
                if url in seen or url in urls_checked:
                    continue
                if site not in urlparse(url).netloc:
                    continue
                urls_checked.add(url)
                try:
                    fetch_res = default_api.web_fetch(url=url, extractMode='markdown')
                    if fetch_res.get("web_fetch_response") and fetch_res["web_fetch_response"].get("text"):
                        text = fetch_res["web_fetch_response"]["text"]
                    else:
                        if fetch_res.get("web_fetch_response") and fetch_res["web_fetch_response"].get("error") and "403" in fetch_res["web_fetch_response"]["error"]:
                            print(f'fetch for {url} returned 403, skipping.', file=sys.stderr)
                            continue
                        text = ''
                    text = clean_html(text)
                except Exception as e:
                    print(f'fetch failed {url}: {e}', file=sys.stderr)
                    text = ''
                item = item_from(title, url, text[:50000])
                if item:
                    found.append(item)
                    seen.add(url)
    found.sort(key=lambda x: (x.get('score') is not None, x.get('score') or 0), reverse=True)
    OUT_JSON.write_text(json.dumps(found, ensure_ascii=False, indent=2), encoding='utf-8')
    with OUT_CSV.open('w', newline='', encoding='utf-8-sig') as f:
        writer = csv.DictWriter(f, fieldnames=['title','price','area','location','phone','posted_time','url','score','hot_reason'])
        writer.writeheader()
        for row in found:
            r = dict(row); r['hot_reason'] = json.dumps(r['hot_reason'], ensure_ascii=False)
            writer.writerow(r)
    save_seen(seen)
    print(json.dumps(found, ensure_ascii=False, indent=2))
    print(str(OUT_CSV))

run_real_estate_monitor()
