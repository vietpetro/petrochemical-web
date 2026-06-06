import json, urllib.request, pathlib
base=pathlib.Path('.')
db_path=base/'reports/crystal/database_checked_tokens.json'
cc_path=base/'reports/crystal/checked_contracts.txt'
text=db_path.read_text(encoding='utf-8-sig')
db=json.loads(text)
if isinstance(db, list) and db and 'value' in db[0]: tokens=db[0]['value']
elif isinstance(db, dict): tokens=db.setdefault('tokens', [])
else: tokens=db
checked=set()
for t in tokens:
    if isinstance(t,dict):
        for k in ('contract_address','contract'):
            v=t.get(k)
            if v and not str(v).startswith('N/A'): checked.add(str(v).lower())
if cc_path.exists():
    for line in cc_path.read_text(encoding='utf-8-sig').splitlines():
        if '|' in line: checked.add(line.split('|')[0].strip().lower())
req=urllib.request.Request('https://api.dexscreener.com/latest/dex/search?q=crystal', headers={'User-Agent':'Mozilla/5.0 crystal-scout'})
with urllib.request.urlopen(req, timeout=20) as r:
    data=json.load(r)
pairs=data.get('pairs') or []
seen={}
for p in pairs:
    for side in ('baseToken','quoteToken'):
        tok=p.get(side) or {}
        name=tok.get('name',''); sym=tok.get('symbol',''); addr=tok.get('address','')
        if not addr or addr.lower() in checked: continue
        if 'crystal' not in (name+' '+sym).lower(): continue
        key=(p.get('chainId',''), addr.lower())
        vol=float((p.get('volume') or {}).get('h24') or 0)
        liq=float((p.get('liquidity') or {}).get('usd') or 0)
        cur=seen.get(key)
        if not cur or (vol+liq) > cur['_rank']:
            seen[key]={'name':name,'symbol':sym,'contract':addr,'contract_address':addr,'blockchain':p.get('chainId'),'price':float(p['priceUsd']) if p.get('priceUsd') else None,'market_cap':p.get('marketCap'),'volume_24h':vol,'liquidity':liq,'holders':None,'website':None,'twitter':None,'telegram':None,'pair_address':p.get('pairAddress'),'pair_url':p.get('url'),'pair_created_at':p.get('pairCreatedAt'),'sources':['dexscreener_api'],'_rank':vol+liq}
new=list(seen.values())
for t in new:
    liq=t['liquidity'] or 0; vol=t['volume_24h'] or 0
    liq_score=20 if liq>=50000 else 15 if liq>=10000 else 10 if liq>=1000 else 5 if liq>0 else 0
    onchain=20 if vol>=50000 else 12 if vol>=1000 else 5 if vol>0 else 0
    sec=7; score=liq_score+onchain+sec
    dead=(vol==0 and liq==0)
    rating='DEAD TOKEN' if dead else 'STRONG' if score>=80 else 'GOOD' if score>=60 else 'WATCHLIST' if score>=40 else 'HIGH RISK'
    risks=[]
    if liq<1000: risks.append(f'Very low liquidity (${liq:.2f})')
    if vol<100: risks.append(f'Very low 24h volume (${vol:.2f})')
    if not t['website']: risks.append('Website/social not resolved in automated cycle')
    if t.get('pair_created_at') and t['pair_created_at']<1700000000000: risks.append('Older pair; not a new launch')
    risks.append('No holder distribution/audit verification in this cycle')
    t.update(score=score,rating=rating,dead_token=dead,risks=risks,community_score=0,security_score=sec,discovered_at='2026-05-22T04:40:00+07:00',notes='Discovered from DexScreener search API; requires manual/social/security verification before any action.')
    t.pop('_rank',None)
# save
for t in new: tokens.append(t)
if isinstance(db, list) and db and 'value' in db[0]: db[0]['value']=tokens
db_path.write_text(json.dumps(db, ensure_ascii=False, indent=2), encoding='utf-8')
with cc_path.open('a', encoding='utf-8') as f:
    for t in new: f.write(f"{t['contract_address']}|{t['symbol']}|{t['blockchain']}|2026-05-22T04:40:00+07:00\n")
session={'session_time':'2026-05-22T04:40:00+07:00','sources_checked':['dexscreener_search_page_failed_403','coingecko_failed_challenge','coinmarketcap_failed_404','reddit_verification','dextools_minimal','dexscreener_api','geckoterminal_api'],'pairs_found':len(pairs),'new_tokens_count':len(new),'new_tokens':new,'skipped_reason':'existing contract/name/symbol already in database or checked_contracts'}
out=base/'reports/crystal/search_results/session_20260522_0440.json'
out.parent.mkdir(parents=True, exist_ok=True)
out.write_text(json.dumps(session, ensure_ascii=False, indent=2), encoding='utf-8')
print(json.dumps({'pairs_found':len(pairs),'new_tokens_count':len(new),'new_tokens':new}, ensure_ascii=False, indent=2))