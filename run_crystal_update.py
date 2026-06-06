import json, pathlib, datetime
base=pathlib.Path(r'C:\Users\DidierChan\.openclaw\workspace')
db_path=base/'reports/crystal/database_checked_tokens.json'
contracts_path=base/'reports/crystal/checked_contracts.txt'
session_path=base/'reports/crystal/search_results/session_20260525_0300.json'
now='2026-05-25T03:00:00+07:00'
db=json.loads(db_path.read_text(encoding='utf-8-sig'))
known={}
for t in db:
    addr=(t.get('contract_address') or t.get('contract') or '').lower()
    if addr: known[addr]=t
new_tokens=[
  {
    'name':'CRYSTAL','symbol':'CRYSTAL','contract':'0x21d624c846725ABe1e1e7d662E9fB274999009Aa','contract_address':'0x21d624c846725ABe1e1e7d662E9fB274999009Aa','blockchain':'Linea','price':0.000003081,'market_cap':2,'volume_24h':0,'liquidity':2.83,'holders':None,'website':None,'twitter':None,'telegram':None,'score':12,'rating':'DEAD TOKEN','dead_token':True,'risks':['DexScreener API shows 24h volume = 0 on Nile pair and dust liquidity (~$2.83)','Market cap/FDV around $2 in DexScreener result; other search snippets inconsistent','No official website/social found; only Frog Wars/GitHub reference says CRYSTAL used for payment','No holder distribution, audit, ownership, or honeypot verification completed in quick cycle'],'community_score':0,'security_score':3,'discovered_at':now,'sources':['dexscreener_api','web_search','geckoterminal_snippet','lineascan_snippet'],'notes':'New-to-database Linea CRYSTAL candidate. Search snippets also show older/alternate liquidity values, but live DexScreener query in this cycle returned volume 0 and dust liquidity; classify dead/high risk until reverified. Pair: https://dexscreener.com/linea/0xf0dbfc461a79f9f3343d7d5b2b24d264fd1514be','url':'https://dexscreener.com/linea/0xf0dbfc461a79f9f3343d7d5b2b24d264fd1514be','pair_address':'0xf0dbFC461a79F9f3343D7D5B2b24D264fd1514BE','txns_24h':{'buys':0,'sells':1}
  },
  {
    'name':'Kyber Network Crystal v2','symbol':'KNC','contract':'7vMt5N12gEs5ABmraoRNLepaGY1v6mCGvPBx5yBuXXJY','contract_address':'7vMt5N12gEs5ABmraoRNLepaGY1v6mCGvPBx5yBuXXJY','blockchain':'Solana','price':0.2929,'market_cap':55811275,'volume_24h':3.99,'liquidity':54801655.25,'holders':None,'website':'https://kyber.network/','twitter':'https://twitter.com/kybernetwork','telegram':'https://t.me/kybernetwork','score':54,'rating':'WATCHLIST','dead_token':False,'risks':['Solana KNC candidate with extremely low 24h volume (~$3.99) despite very high reported liquidity; data may be stale or wrapper-specific','No direct web-search confirmation found for this exact mint in this cycle','Legacy Kyber asset, not a new crystal launch','Holder concentration and bridge/wrapper legitimacy not verified'],'community_score':20,'security_score':7,'discovered_at':now,'sources':['dexscreener_api','web_search'],'notes':'New-to-database Solana KNC/Kyber Network Crystal v2 mint from DexScreener crystal query. Established Kyber social context exists, but exact mint needs verification. Pair: https://dexscreener.com/solana/3wehgcdmdxi8ne8d5gsamebjklxhjpgrvpf6djpuugzq','url':'https://dexscreener.com/solana/3wehgcdmdxi8ne8d5gsamebjklxhjpgrvpf6djpuugzq','pair_address':'3WeHgCdmdXi8Ne8D5gSAmebJkLXHJpgRvPf6dJpuUgzq','txns_24h':{'buys':1,'sells':1}
  },
  {
    'name':'Kyber Network Crystal v2','symbol':'KNC','contract':'EDUZJRoAtXgxRmuqPj9Es1eox49f7VSSWfKWJLc2GnjD','contract_address':'EDUZJRoAtXgxRmuqPj9Es1eox49f7VSSWfKWJLc2GnjD','blockchain':'Solana','price':0.5785,'market_cap':108445592,'volume_24h':3.99,'liquidity':107445583.28,'holders':None,'website':'https://kyber.network/','twitter':'https://twitter.com/kybernetwork','telegram':'https://t.me/kybernetwork','score':59,'rating':'WATCHLIST','dead_token':False,'risks':['Very low observed 24h volume (~$3.99) despite very high reported liquidity','Legacy Kyber asset, not a new launch','Holder concentration and Solana wrapper/official mapping not fully verified','No deep audit/ownership check in quick cycle'],'community_score':20,'security_score':8,'discovered_at':now,'sources':['dexscreener_api','web_search','solflare_snippet'],'notes':'Solflare snippet identifies this as official Solana contract address for Kyber Network Crystal v2. Still watchlist due to thin trading activity in DexScreener result. Pair: https://dexscreener.com/solana/bco2ugh4vuigoovaywhfkt83z5tq3hri11z1cduabj5f','url':'https://dexscreener.com/solana/bco2ugh4vuigoovaywhfkt83z5tq3hri11z1cduabj5f','pair_address':'BCo2UgH4vuigooVaywhFkT83z5tq3HRi11z1cduabJ5F','txns_24h':{'buys':1,'sells':1}
  },
  {
    'name':'CRYSTALMOON','symbol':'CMON','contract':'0x5BD983576b0eC8AC882e0581E5635c65a912C22a','contract_address':'0x5BD983576b0eC8AC882e0581E5635c65a912C22a','blockchain':'BSC','price':0.00002880,'market_cap':28802,'volume_24h':0,'liquidity':54049.47,'holders':None,'website':None,'twitter':None,'telegram':None,'score':31,'rating':'HIGH RISK','dead_token':False,'risks':['DexScreener shows 24h volume = 0 and only one sell transaction','Old BSC token/pair from 2021, not a new launch','BscScan snippet says contract source verified but compiler is old v0.6.12 and optimization disabled','Skelty snippet shows Global Rating 0 / related risky similar source-code ranks','No official website/social found; holder concentration not verified'],'community_score':0,'security_score':5,'discovered_at':now,'sources':['dexscreener_api','web_search','bscscan_snippet','whattofarm_snippet','skelty_snippet'],'notes':'New-to-database BSC CRYSTALMOON/CMON. Liquidity appears non-zero (~$54K on DexScreener) but trading is effectively inactive and risk tooling snippets are poor; high risk. Pair: https://dexscreener.com/bsc/0x64369876bf112c2f2f637bdae281e3ee9062b6d6','url':'https://dexscreener.com/bsc/0x64369876bf112c2f2f637bdae281e3ee9062b6d6','pair_address':'0x64369876Bf112c2F2f637BDAe281e3EE9062B6d6','txns_24h':{'buys':0,'sells':1}
  }
]
added=[]; skipped=[]
for t in new_tokens:
    if t['contract_address'].lower() in known:
        skipped.append(t)
    else:
        db.append(t); known[t['contract_address'].lower()]=t; added.append(t)
db_path.write_text(json.dumps(db, ensure_ascii=False, indent=2), encoding='utf-8')
existing=contracts_path.read_text(encoding='utf-8', errors='ignore')
with contracts_path.open('a', encoding='utf-8') as f:
    if not existing.endswith('\n'): f.write('\n')
    for t in added:
        f.write(f"{t['contract_address']}|{t['symbol']}|{t['blockchain']}|{now}\n")
session={'session':'session_20260525_0300','timestamp':now,'sources_checked':['DexScreener web_fetch blocked by anti-bot; DexScreener API used successfully','CoinGecko web_fetch blocked by challenge','CoinMarketCap web_fetch returned error page','Twitter/X via web_search','Reddit web_fetch verification page','DEXTools web_fetch minimal JS page','Google/web_search mandatory keywords'],'search_queries':['crystal token crypto new launch','crystal token crypto','crystal coin new launch 2026','crystal token presale OR airdrop','crystal defi token BSC Solana','crystal ecosystem token crypto','new crystal token blockchain','crystal token crypto new crystal token site:twitter.com OR #crystalcoin'],'found_candidates_total':17,'skipped_existing_or_duplicate':13,'new_tokens_added':len(added),'tokens':added,'skipped_new_already_known':skipped,'notable_tokens':[t for t in added if t['rating'] in ('WATCHLIST','GOOD','STRONG')],'notes':'No wallet interaction, purchase, or signing. Several sources were blocked/challenged; cycle continued with DexScreener API and web_search snippets.'}
session_path.parent.mkdir(parents=True, exist_ok=True)
session_path.write_text(json.dumps(session, ensure_ascii=False, indent=2), encoding='utf-8')
print(json.dumps({'added':len(added),'session':str(session_path)}, indent=2))
