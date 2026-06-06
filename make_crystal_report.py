import json, glob
from collections import Counter
base='reports/crystal'; today='2026-05-22'; yday='2026-05-21'

def load_json(p):
    try:
        with open(p,encoding='utf-8') as f: return json.load(f)
    except Exception: return None

def extract_tokens(obj):
    out=[]
    if isinstance(obj, list):
        for x in obj:
            if isinstance(x, dict) and isinstance(x.get('value'), list): out += [t for t in x['value'] if isinstance(t,dict)]
            elif isinstance(x, dict) and ('name'in x or 'symbol'in x): out.append(x)
            else: out += extract_tokens(x)
    elif isinstance(obj, dict):
        for k in ('tokens','new_tokens','all_tokens','results','found_tokens'):
            if isinstance(obj.get(k), list): out += extract_tokens(obj[k])
        if ('name' in obj or 'symbol' in obj) and ('contract' in obj or 'contract_address' in obj): out.append(obj)
    return out

def num(x):
    try:
        if x is None: return None
        return float(x)
    except Exception: return None

def fmt_money(x):
    x=num(x)
    if x is None: return 'N/A'
    if abs(x)>=1_000_000: return f'${x/1_000_000:.2f}M'
    if abs(x)>=1_000: return f'${x/1_000:.2f}K'
    if abs(x)>=1: return f'${x:.2f}'
    return f'${x:.6g}'

def fmt_price(x):
    x=num(x)
    if x is None: return 'N/A'
    return f'${x:.6g}'

def label(t): return f"{t.get('name','?')} ({t.get('symbol','?')})"

db=load_json(f'{base}/database_checked_tokens.json')
tokens=extract_tokens(db)
seen=set(); ded=[]
for t in tokens:
    key=((t.get('contract_address') or t.get('contract') or t.get('name','')).lower(), (t.get('blockchain') or '').lower())
    if key in seen: continue
    seen.add(key); ded.append(t)
tokens=ded
skipped=0
for p in glob.glob(f'{base}/search_results/session_*.json'):
    obj=load_json(p)
    try: skipped += json.dumps(obj,ensure_ascii=False).lower().count('skipped')
    except Exception: pass
new_today=[t for t in tokens if str(t.get('discovered_at','')).startswith(today)]
yobj=load_json(f'{base}/crystal_report_20260521.json')
y_new=yobj.get('summary',{}).get('new_tokens_today',0) if isinstance(yobj,dict) else sum(1 for t in tokens if str(t.get('discovered_at','')).startswith(yday))
ratings=Counter(); dead=[]
for t in tokens:
    r=(t.get('rating') or '').upper().replace('_',' ')
    if t.get('dead_token') or r=='DEAD TOKEN': ratings['DEAD TOKEN']+=1; dead.append(t)
    elif r in ('STRONG','GOOD','WATCHLIST','HIGH RISK'): ratings[r]+=1

top=sorted([t for t in tokens if not t.get('dead_token') and num(t.get('score')) is not None], key=lambda t:num(t.get('score')) or -1, reverse=True)[:5]
high=sorted([t for t in tokens if (t.get('dead_token') or (num(t.get('score')) is not None and num(t.get('score'))<40) or 'HIGH' in str(t.get('rating','')).upper())], key=lambda t:num(t.get('score')) if num(t.get('score')) is not None else 999)[:10]
vol=sorted([t for t in new_today if (num(t.get('volume_24h')) or 0)>0 or (isinstance(t.get('txns_24h'),dict) and sum(t.get('txns_24h',{}).values())>0)], key=lambda t:(num(t.get('volume_24h')) or 0), reverse=True)[:8]
chains=Counter((t.get('blockchain') or 'Unknown') for t in new_today)
alerts=[]
if ratings['DEAD TOKEN'] or any(t.get('dead_token') for t in new_today): alerts.append('Nhiều token có thanh khoản/volume bằng 0 hoặc gần như bằng 0; tuyệt đối không tương tác ví.')
if sum(1 for t in new_today if 'pump' in str(t.get('contract','')).lower())>=3: alerts.append('Xuất hiện cụm token Solana pump.fun/very small cap, rủi ro rug/illiquidity cao.')
if len([t for t in new_today if 'KNC'==str(t.get('symbol')).upper()])>=3: alerts.append('Nhiều bản triển khai Kyber/KNC multi-chain được phát hiện; cần tránh nhầm lẫn contract/chain.')
summary={'total_tokens_found':len(tokens),'new_tokens_today':len(new_today),'skipped_tokens':skipped,'dead_tokens':len(dead),'ratings':{'STRONG':ratings['STRONG'],'GOOD':ratings['GOOD'],'WATCHLIST':ratings['WATCHLIST'],'HIGH_RISK':ratings['HIGH RISK']}}
report={'report_date':today,'generated_at':'2026-05-22T05:15:00+07:00','summary':summary,'top_tokens':top,'high_risk_tokens':high,'dead_tokens':dead,'trend_analysis':{'new_tokens_count':len(new_today),'popular_blockchains':chains.most_common(),'market_sentiment':'Thận trọng/rủi ro cao: phần lớn phát hiện mới là legacy deployment, microcap hoặc thanh khoản rất mỏng; chỉ vài token có nền tảng dự án rõ.','alerts':alerts},'all_tokens':[{k:t.get(k) for k in ['name','symbol','contract_address','contract','blockchain','price','market_cap','volume_24h','liquidity','holders','score','rating','dead_token','risks','discovered_at','sources','notes']} for t in tokens]}
with open(f'{base}/crystal_report_20260522.json','w',encoding='utf-8') as f: json.dump(report,f,ensure_ascii=False,indent=2)
lines=['# Crystal Token Scout Report - 2026-05-22\n','## Tổng Quan',f"- Tổng số token tìm được: {summary['total_tokens_found']}",f"- Token mới phát hiện: {summary['new_tokens_today']}",f"- Token đã bỏ qua (trùng): {summary['skipped_tokens']}",f"- DEAD TOKEN: {summary['dead_tokens']}",f"- Token STRONG: {ratings['STRONG']}",f"- Token GOOD: {ratings['GOOD']}",f"- Token WATCHLIST: {ratings['WATCHLIST']}",f"- Token HIGH RISK: {ratings['HIGH RISK']}\n",'## Top Token Đáng Chú Ý']
for t in top: lines.append(f"- **{label(t)}** — {t.get('blockchain','N/A')}, điểm {t.get('score','N/A')}, {t.get('rating','N/A')}; giá {fmt_price(t.get('price'))}, volume {fmt_money(t.get('volume_24h'))}, liquidity {fmt_money(t.get('liquidity'))}. Ghi chú: {t.get('notes','')}")
lines.append('\n## Token Volume Tăng Mạnh')
for t in vol: lines.append(f"- **{label(t)}** — volume 24h {fmt_money(t.get('volume_24h'))}, txns {t.get('txns_24h','N/A')}, chain {t.get('blockchain','N/A')}, điểm {t.get('score','N/A')}.")
lines.append('\n## Token Rủi Ro Cao')
for t in high[:8]: lines.append(f"- **{label(t)}** — điểm {t.get('score','N/A')}, {t.get('rating','N/A')}; lý do: {'; '.join((t.get('risks') or [])[:3])}")
lines.append('\n## Danh Sách DEAD TOKEN')
for t in dead: lines.append(f"- **{label(t)}** — {t.get('blockchain','N/A')}; volume {fmt_money(t.get('volume_24h'))}, liquidity {fmt_money(t.get('liquidity'))}; {t.get('notes','')}")
lines.append('\n## Phân Tích Xu Hướng Crystal Ecosystem')
lines.append(f"- Số lượng token mới so với hôm qua: {len(new_today)} hôm nay vs {y_new} hôm qua ({len(new_today)-int(y_new):+d}).")
lines.append('- Blockchain phổ biến: ' + ', '.join(f'{c}: {n}' for c,n in chains.most_common()) + '.')
lines.append('- Đặc điểm chung của token mới: nhiều contract legacy/multi-chain KNC, nhiều microcap Solana pump.fun và token có liquidity/volume rất thấp; số token có website/social xác thực còn ít.')
lines.append('- Cảnh báo: ' + (' '.join(alerts) if alerts else 'Không có cảnh báo đặc biệt ngoài rủi ro crypto thông thường.'))
lines.append('\n## Chi Tiết Token (Bảng)')
lines.append('|#|Tên|Symbol|Chain|Giá|Volume|Liquidity|Holders|Điểm|Xếp loại|')
lines.append('|---|---|---|---|---|---|---|---|---|---|')
for i,t in enumerate(tokens,1): lines.append(f"|{i}|{str(t.get('name','N/A')).replace('|','/')}|{str(t.get('symbol','N/A')).replace('|','/')}|{str(t.get('blockchain','N/A')).replace('|','/')}|{fmt_price(t.get('price'))}|{fmt_money(t.get('volume_24h'))}|{fmt_money(t.get('liquidity'))}|{t.get('holders','N/A') if t.get('holders') is not None else 'N/A'}|{t.get('score','N/A')}|{t.get('rating','N/A')}|")
with open(f'{base}/crystal_report_20260522.md','w',encoding='utf-8',newline='\n') as f: f.write('\n'.join(lines)+'\n')
print(json.dumps({'summary':summary,'top':[label(t) for t in top[:3]],'files':[f'{base}/crystal_report_20260522.md',f'{base}/crystal_report_20260522.json']},ensure_ascii=False))
