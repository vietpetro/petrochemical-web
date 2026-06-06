import json, os
base='reports/crystal'
os.makedirs(base+'/search_results', exist_ok=True)
db_path=base+'/database_checked_tokens.json'
contracts_path=base+'/checked_contracts.txt'
with open(db_path,'r',encoding='utf-8') as f: raw=json.load(f)
if isinstance(raw, dict): tokens=raw.setdefault('tokens',[])
elif isinstance(raw, list) and raw and isinstance(raw[0],dict) and isinstance(raw[0].get('value'),list): tokens=raw[0]['value']
elif isinstance(raw, list): tokens=raw
else: tokens=[]
existing=set()
for t in tokens:
    existing.add((str(t.get('symbol','')).upper(), str(t.get('name','')).lower()))
    ca=t.get('contract_address') or t.get('contract')
    if ca: existing.add(str(ca).lower())
now='2026-05-22T02:40:00+07:00'
new_tokens=[]
def add(tok):
    ca=(tok.get('contract_address') or tok.get('contract') or '').lower()
    key=(tok.get('symbol','').upper(), tok.get('name','').lower())
    if ca in existing or key in existing:
        return False
    tokens.append(tok); new_tokens.append(tok); existing.add(ca); existing.add(key); return True
add({'name':'DeFi Kingdoms Crystal','symbol':'CRYSTAL','contract_address':'0x04b9da42306b023f3572e106b11d82aad9d32ebb','pair_contract_address':'0x04dec678825b8dfd2d0d9bd83b538be3fbda2926','blockchain':'DFK Chain / Crystalvale','price':0.0028684,'market_cap':None,'fdv':717100,'volume_24h':221.9,'liquidity':135600,'holders':None,'website':'https://defikingdoms.com/crystalvale/','twitter':None,'telegram':None,'score':55,'rating':'WATCHLIST','dead_token':False,'risks':['Low 24h volume (~$222 on Holder.io; GeckoTerminal snippet showed ~$809 in another source)','Holder distribution and contract ownership not verified in this cycle','Niche game/DEX ecosystem token; liquidity exists but activity is thin'],'community_score':8,'security_score':7,'discovered_at':now,'sources':['holder.io','geckoterminal search snippet','coinmarketcap search snippet','coingecko search snippet','defikingdoms docs search snippet'],'notes':'Existing DeFi Kingdoms Crystalvale token. Liquidity pool reported ~$135.6k, FDV ~$717k, but 24h volume low; not a new launch. Treat as watchlist, not purchase signal.'})
# CRT already present in db; do not duplicate. Record skipped in report.
with open(db_path,'w',encoding='utf-8') as f: json.dump(raw,f,ensure_ascii=False,indent=2)
existing_lines=open(contracts_path,'r',encoding='utf-8').read() if os.path.exists(contracts_path) else ''
with open(contracts_path,'a',encoding='utf-8') as f:
    for tok in new_tokens:
        line=f"{tok['contract_address']}|{tok['symbol']}|{tok['blockchain']}|{now}"
        if tok['contract_address'] not in existing_lines: f.write('\n'+line)
report={'session':'session_20260522_0240','timestamp':now,'sources_checked':['DexScreener(fetch blocked 403)','CoinGecko(fetch blocked challenge)','CoinMarketCap(fetch 404/search snippets used)','Reddit(fetch verification page)','DEXTools(fetch minimal)','web_search required keywords','Bitget dapp','Holder.io','search snippets for GeckoTerminal/BscScan/CMC/CoinGecko'],'database_tokens_before':len(tokens)-len(new_tokens),'tokens_found_candidates':3,'new_tokens_added':len(new_tokens),'skipped':[{'name':'Crystal Token','symbol':'CYL','reason':'already in database/known from prior cycle'},{'name':'Crystal Token / Crystal Wallet','symbol':'CRT','contract_address':'0x84817f5b8523c063d9574b36c5b670a046bb5810','reason':'already in database'}],'new_tokens':new_tokens,'notable':[{'symbol':'CRYSTAL','reason':'Liquidity pool reported ~$135.6k but low volume; watchlist only'}] if new_tokens else [],'errors':['Several JS/challenge-protected sources could not be fully fetched; cycle continued using search snippets and accessible pages.'],'safety':'No wallet connection, no purchase, no transaction signing.'}
with open(base+'/search_results/session_20260522_0240.json','w',encoding='utf-8') as f: json.dump(report,f,ensure_ascii=False,indent=2)
print(json.dumps({'new_tokens_added':len(new_tokens),'symbols':[t['symbol'] for t in new_tokens]},ensure_ascii=False))
