import json, pathlib, datetime
base=pathlib.Path(r'C:\Users\DidierChan\.openclaw\workspace')
db_path=base/'reports/crystal/database_checked_tokens.json'
contracts_path=base/'reports/crystal/checked_contracts.txt'
search_dir=base/'reports/crystal/search_results'
now='2026-05-23T00:20:00+07:00'
# load
with open(db_path,encoding='utf-8-sig') as f: db=json.load(f)
known=set()
for t in db:
    for k in ('contract_address','contract'):
        v=t.get(k)
        if v: known.add(str(v).lower())
contracts=contracts_path.read_text(encoding='utf-8-sig')
for line in contracts.splitlines():
    if '|' in line: known.add(line.split('|')[0].lower())
with open(base/'dex.json',encoding='utf-8-sig') as f: dex=json.load(f)
# consolidate by base token only where crystal-ish in name/symbol and not known
cands=[]; seen=set(); skipped=[]
for p in dex.get('pairs',[]):
    bt=p.get('baseToken',{}); name=bt.get('name',''); sym=bt.get('symbol',''); addr=bt.get('address','')
    if 'crystal' not in (name+' '+sym).lower(): continue
    key=addr.lower()
    if key in known or key in seen:
        skipped.append({'name':name,'symbol':sym,'contract_address':addr,'blockchain':p.get('chainId'),'reason':'already in database/contracts'})
        continue
    seen.add(key); cands.append(p)
new=[]
for p in cands:
    bt=p['baseToken']; info=p.get('info',{})
    websites=info.get('websites') or []
    socials=info.get('socials') or []
    website=websites[0].get('url') if websites else None
    twitter=next((s.get('url') for s in socials if s.get('type')=='twitter'),None)
    telegram=next((s.get('url') for s in socials if s.get('type')=='telegram'),None)
    liq=(p.get('liquidity') or {}).get('usd')
    vol=(p.get('volume') or {}).get('h24')
    tx24=(p.get('txns') or {}).get('h24') or {}
    # scoring
    liquidity_score=20 if (liq or 0)>=50000 else 15 if (liq or 0)>=10000 else 10 if (liq or 0)>=1000 else 5 if (liq or 0)>0 else 0
    community_score=15 if twitter and telegram else 8 if (twitter or telegram) else 0
    web_social_score=15 if website and (twitter or telegram) else 8 if website else 0
    onchain_score=12 if (vol or 0)>=100 and (tx24.get('buys',0)+tx24.get('sells',0))>=5 else 5 if (vol or 0)>0 else 0
    holder_score=8 # not verified
    security_score=7 # no direct rug flag, no audit verified
    score=liquidity_score+community_score+web_social_score+onchain_score+holder_score+security_score
    dead=(vol or 0)==0 and (liq or 0)==0 and not website and not twitter and not telegram
    rating='DEAD TOKEN' if dead else 'STRONG' if score>=80 else 'GOOD' if score>=60 else 'WATCHLIST' if score>=40 else 'HIGH RISK'
    risks=['Holder concentration not verified','Contract audit/ownership not verified']
    if not website: risks.append('No official website resolved from DexScreener info')
    elif 'crystalmine.app' in website: risks.append('Website returned 404 during web_fetch verification')
    if not (twitter or telegram): risks.append('No social links resolved from DexScreener info')
    if (vol or 0)<10: risks.append('Very low 24h volume on observed pair')
    if (liq or 0)<1000: risks.append('Very low liquidity on observed pair')
    token={'name':bt.get('name'),'symbol':bt.get('symbol'),'contract_address':bt.get('address'),'contract':bt.get('address'),'blockchain':p.get('chainId'),'price':float(p['priceUsd']) if p.get('priceUsd') else None,'market_cap':p.get('marketCap'),'volume_24h':vol,'liquidity':liq,'holders':None,'url':p.get('url'),'pair_address':p.get('pairAddress'),'pair_created_at':p.get('pairCreatedAt'),'txns_24h':tx24,'website':website,'twitter':twitter,'telegram':telegram,'score':score,'rating':rating,'dead_token':dead,'risks':risks,'community_score':community_score,'security_score':security_score,'discovered_at':now,'sources':['dexscreener_api','web_search','web_fetch'],'notes':'Automated 00:20 cycle. DexScreener API surfaced this as new relative to local database; required web searches/fetches were attempted, with several sites blocked by challenge/403. No wallet interaction performed.'}
    new.append(token)
# append
db.extend(new)
db_path.write_text(json.dumps(db,ensure_ascii=False,indent=2),encoding='utf-8')
with open(contracts_path,'a',encoding='utf-8') as f:
    for t in new: f.write(f"{t['contract_address']}|{t['symbol']}|{t['blockchain']}|{now}\n")
report={'session':'session_20260523_0020','timestamp':now,'sources_attempted':['DexScreener web/API','CoinGecko search/fetch','CoinMarketCap fetch','Twitter/X web_search','Reddit fetch','DEXTools fetch','Google/web_search keyword set','Bitget dapp result','Yahoo finance result'], 'tokens_found_total':len([p for p in dex.get('pairs',[]) if 'crystal' in (p.get('baseToken',{}).get('name','')+' '+p.get('baseToken',{}).get('symbol','')).lower()]), 'new_tokens_count':len(new),'skipped_count':len(skipped),'new_tokens':new,'skipped_sample':skipped[:20], 'errors':['DexScreener web page 403, API succeeded','CoinGecko challenge/403','CoinMarketCap search fetch 404','Reddit verification page','Yahoo fetch failed','Twitter query returned no direct results']}
search_dir.mkdir(parents=True,exist_ok=True)
(search_dir/'session_20260523_0020.json').write_text(json.dumps(report,ensure_ascii=False,indent=2),encoding='utf-8')
print(json.dumps({'new':len(new),'skipped':len(skipped),'new_symbols':[t['symbol'] for t in new]},ensure_ascii=False))
