import json, glob, os, re
from pathlib import Path
from datetime import datetime, timezone, timedelta
from collections import Counter

TZ=timezone(timedelta(hours=7))
now=datetime.now(TZ)
today=now.date().isoformat()
ymd=now.strftime('%Y%m%d')
base=Path.cwd()/ 'reports'/'crystal'
search=base/'search_results'
base.mkdir(parents=True, exist_ok=True)

def load_json(p, default):
    try:
        with open(p,'r',encoding='utf-8') as f: return json.load(f)
    except Exception: return default

db=load_json(base/'database_checked_tokens.json', [])
if isinstance(db, dict): tokens=db.get('tokens',[])
elif isinstance(db, list): tokens=db
else: tokens=[]

sessions=[]
skipped=0
for fp in sorted(search.glob('session_*.json')) if search.exists() else []:
    data=load_json(fp, None)
    if data is None: continue
    sessions.append({'file':fp.name,'data':data})
    def walk(x):
        global skipped
        if isinstance(x, dict):
            msg=str(x.get('message','')).lower()
            status=str(x.get('status','')).lower()
            if msg=='skipped' or status=='skipped' or 'skipped' in msg: skipped+=1
            for v in x.values(): walk(v)
        elif isinstance(x, list):
            for v in x: walk(v)
    walk(data)

def norm_rating(t):
    if t.get('dead_token') or str(t.get('rating','')).upper().replace(' ','_') in ('DEAD_TOKEN','DEAD'): return 'DEAD TOKEN'
    r=str(t.get('rating') or '').upper().replace('-',' ').replace('_',' ')
    if 'STRONG' in r: return 'STRONG'
    if 'GOOD' in r: return 'GOOD'
    if 'WATCH' in r: return 'WATCHLIST'
    if 'HIGH' in r or 'RISK' in r: return 'HIGH RISK'
    sc=t.get('score')
    try: sc=float(sc)
    except Exception: return 'WATCHLIST'
    if sc>=80: return 'STRONG'
    if sc>=60: return 'GOOD'
    if sc>=40: return 'WATCHLIST'
    return 'HIGH RISK'

def num(x):
    if x is None or x=='': return None
    try: return float(str(x).replace('$','').replace(',',''))
    except Exception: return None

def fmt_money(x):
    x=num(x)
    if x is None: return 'N/A'
    if x==0: return '$0'
    if abs(x)<0.01: return f'${x:.8g}'
    return f'${x:,.2f}'
def fmt_int(x):
    x=num(x)
    return 'N/A' if x is None else f'{int(x):,}'

def name(t): return t.get('name') or t.get('token_name') or 'Unknown'
def sym(t): return t.get('symbol') or 'N/A'
def chain(t): return t.get('blockchain') or t.get('chain') or 'N/A'
def contract(t): return t.get('contract_address') or t.get('contract') or ''
def score(t):
    try: return float(t.get('score') or 0)
    except Exception: return 0

def discovered_today(t):
    d=str(t.get('discovered_at') or '')
    return d.startswith(today)

ratings=Counter(norm_rating(t) for t in tokens)
dead=[t for t in tokens if norm_rating(t)=='DEAD TOKEN' or t.get('dead_token')]
high=[t for t in tokens if norm_rating(t)=='HIGH RISK']
new=[t for t in tokens if discovered_today(t)]
top=sorted([t for t in tokens if norm_rating(t)!='DEAD TOKEN'], key=score, reverse=True)[:5]
# Volume movers: prefer today's tokens / any volume >0, sorted by volume then notes containing change
y_vol=[t for t in tokens if num(t.get('volume_24h')) not in (None,0)]
vol=sorted(y_vol, key=lambda t: num(t.get('volume_24h')) or 0, reverse=True)[:5]
low=sorted(high, key=score)[:5]
chains=Counter(chain(t) for t in new if chain(t)!='N/A')
if not chains: chains=Counter(chain(t) for t in tokens if chain(t)!='N/A')
# yesterday report compare
yesterday=(now-timedelta(days=1)).strftime('%Y%m%d')
yj=load_json(base/f'crystal_report_{yesterday}.json', {})
ynew=(yj.get('summary') or {}).get('new_tokens_today') if isinstance(yj,dict) else None
alerts=[]
if dead: alerts.append(f'{len(dead)} DEAD TOKEN cần tránh/không có dấu hiệu hoạt động.')
if high: alerts.append(f'{len(high)} token HIGH RISK; không kết nối ví hoặc giao dịch khi chưa kiểm chứng độc lập.')
if not new: alerts.append('Không ghi nhận token mới theo trường discovered_at của ngày báo cáo.')

def token_brief(t):
    return {
        'name':name(t),'symbol':sym(t),'chain':chain(t),'contract_address':contract(t),
        'price':t.get('price'),'market_cap':t.get('market_cap'),'volume_24h':t.get('volume_24h'),
        'liquidity':t.get('liquidity'),'holders':t.get('holders'),'score':t.get('score'),
        'rating':norm_rating(t),'dead_token':bool(t.get('dead_token') or norm_rating(t)=='DEAD TOKEN'),
        'risks':t.get('risks') or [],'notes':t.get('notes') or '', 'discovered_at':t.get('discovered_at')
    }

json_report={
 'report_date':today,'generated_at':now.isoformat(),
 'summary':{'total_tokens_found':len(tokens),'new_tokens_today':len(new),'skipped_tokens':skipped,'dead_tokens':len(dead),'ratings':{'STRONG':ratings['STRONG'],'GOOD':ratings['GOOD'],'WATCHLIST':ratings['WATCHLIST'],'HIGH_RISK':ratings['HIGH RISK']}},
 'top_tokens':[token_brief(t) for t in top], 'high_risk_tokens':[token_brief(t) for t in low], 'dead_tokens':[token_brief(t) for t in dead],
 'trend_analysis':{'new_tokens_count':len(new),'popular_blockchains':[{'chain':c,'count':n} for c,n in chains.most_common()], 'market_sentiment':('Thận trọng' if high or dead else 'Trung lập'), 'alerts':alerts, 'yesterday_new_tokens':ynew},
 'all_tokens':[token_brief(t) for t in tokens]
}
(base/f'crystal_report_{ymd}.json').write_text(json.dumps(json_report,ensure_ascii=False,indent=2),encoding='utf-8')

def bullet(t):
    risks='; '.join((t.get('risks') or [])[:2]) or (t.get('notes') or 'Không có ghi chú')
    return f"- **{name(t)} ({sym(t)})** — {chain(t)}, điểm {score(t):.0f}, {norm_rating(t)}; volume {fmt_money(t.get('volume_24h'))}, liquidity {fmt_money(t.get('liquidity'))}. {risks}"
rows=[]
for i,t in enumerate(sorted(tokens,key=lambda x:(norm_rating(x)=='DEAD TOKEN', -score(x))),1):
    rows.append(f"|{i}|{name(t)}|{sym(t)}|{chain(t)}|{fmt_money(t.get('price'))}|{fmt_money(t.get('volume_24h'))}|{fmt_money(t.get('liquidity'))}|{fmt_int(t.get('holders'))}|{score(t):.0f}|{norm_rating(t)}|")
compare='N/A'
if isinstance(ynew,(int,float)):
    diff=len(new)-ynew; compare=f"{len(new)} hôm nay so với {ynew} hôm qua ({diff:+})"
md=f"""# Crystal Token Scout Report - {today}

## Tổng Quan
- Tổng số token tìm được: {len(tokens)}
- Token mới phát hiện: {len(new)}
- Token đã bỏ qua (trùng): {skipped}
- DEAD TOKEN: {len(dead)}
- Token STRONG: {ratings['STRONG']}
- Token GOOD: {ratings['GOOD']}
- Token WATCHLIST: {ratings['WATCHLIST']}
- Token HIGH RISK: {ratings['HIGH RISK']}

## Top Token Đáng Chú Ý
{chr(10).join(bullet(t) for t in top) if top else '- Không có dữ liệu.'}

## Token Volume Tăng Mạnh
{chr(10).join(bullet(t) for t in vol) if vol else '- Không có token nào có dữ liệu volume 24h đáng tin cậy trong database.'}

## Token Rủi Ro Cao
{chr(10).join(bullet(t) for t in low) if low else '- Không có token HIGH RISK.'}

## Danh Sách DEAD TOKEN
{chr(10).join(bullet(t) for t in dead) if dead else '- Không ghi nhận DEAD TOKEN.'}

## Phân Tích Xu Hướng Crystal Ecosystem
- Số lượng token mới so với hôm qua: {compare}
- Blockchain phổ biến: {', '.join(f'{c} ({n})' for c,n in chains.most_common()) or 'N/A'}
- Đặc điểm chung của token mới: {('chưa có token mới trong ngày; dữ liệu chủ yếu là các token đã biết/cần theo dõi.' if not new else 'đa số cần xác minh thêm liquidity, volume, cộng đồng và bảo mật contract.')}
- Cảnh báo: {' '.join(alerts) if alerts else 'Không có cảnh báo nổi bật.'}

## Chi Tiết Token (Bảng)
|#|Tên|Symbol|Chain|Giá|Volume|Liquidity|Holders|Điểm|Xếp loại|
|---|---|---|---|---|---|---|---|---|---|
{chr(10).join(rows)}
"""
(base/f'crystal_report_{ymd}.md').write_text(md,encoding='utf-8')
print(json.dumps({'md':str(base/f'crystal_report_{ymd}.md'),'json':str(base/f'crystal_report_{ymd}.json'),'summary':json_report['summary'],'top':[f"{name(t)}({sym(t)}) {score(t):.0f}" for t in top[:3]],'alerts':alerts},ensure_ascii=False,indent=2))
