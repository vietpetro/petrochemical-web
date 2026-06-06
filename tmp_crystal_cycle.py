import json, urllib.request, pathlib
base=pathlib.Path(r'C:\Users\DidierChan\.openclaw\workspace')
db_path=base/'reports/crystal/database_checked_tokens.json'
contracts_path=base/'reports/crystal/checked_contracts.txt'
db=json.loads(db_path.read_text(encoding='utf-8-sig'))
known=set()
for t in db:
    for k in ('contract_address','contract'):
        v=t.get(k)
        if v and v!='N/A': known.add(v.lower())
for line in contracts_path.read_text(encoding='utf-8', errors='ignore').splitlines():
    if '|' in line: known.add(line.split('|')[0].lower())
req=urllib.request.Request('https://api.dexscreener.com/latest/dex/search?q=crystal', headers={'User-Agent':'Mozilla/5.0','Accept':'application/json'})
data=json.load(urllib.request.urlopen(req, timeout=20))
new=[]; skipped=[]; seen=set()
for p in data.get('pairs') or []:
    for token,side in [((p.get('baseToken') or {}),'base'),((p.get('quoteToken') or {}),'quote')]:
        s=((token.get('name') or '')+' '+(token.get('symbol') or '')).lower()
        if 'crystal' not in s and 'cryst' not in s: continue
        addr=token.get('address')
        if not addr or addr.lower() in seen: continue
        seen.add(addr.lower())
        rec={'addr':addr,'name':token.get('name'),'symbol':token.get('symbol'),'chain':p.get('chainId'),'price':p.get('priceUsd'),'vol':(p.get('volume') or {}).get('h24'),'liq':(p.get('liquidity') or {}).get('usd'),'mcap':p.get('marketCap') or p.get('fdv'),'url':p.get('url'),'pair':p.get('pairAddress'),'txns':(p.get('txns') or {}).get('h24'), 'info':p.get('info')}
        (skipped if addr.lower() in known else new).append(rec)
print('NEW', len(new))
print(json.dumps(new[:50], indent=2))
print('SKIPPED', len(skipped))
