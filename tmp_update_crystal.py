import json, pathlib
base=pathlib.Path(r'C:\Users\DidierChan\.openclaw\workspace\reports\crystal')
db_path=base/'database_checked_tokens.json'
contracts_path=base/'checked_contracts.txt'
with open(db_path,'r',encoding='utf-8-sig') as f: db=json.load(f)
now='2026-05-19T00:40:00+07:00'
new=[
{
 "name":"Crypton Crystal","symbol":"CPC","contract":"0x3db041CD692135F1f39aDB2B02B59E6678814F51","contract_address":"0x3db041CD692135F1f39aDB2B02B59E6678814F51","blockchain":"BSC","price":None,"market_cap":None,"volume_24h":None,"liquidity":None,"holders":None,"website":None,"twitter":None,"telegram":None,"score":24,"rating":"HIGH RISK","dead_token":False,
 "risks":["Launched 2022-06-26; not a new launch","CoinMooner/web page gives narrative but no reliable current liquidity/volume in fetched content","NFT-backed/social-currency claims require off-chain verification","No official website/social links resolved in this cycle","No audit, holder distribution, ownership, or honeypot verification found"],
 "community_score":5,"security_score":4,"discovered_at":now,"sources":["web_search","coinmooner","web_fetch"],"notes":"New-to-database BSC result from CoinMooner. Contract visible in search snippet; fetched page describes NFT-backed social currency but lacks current market quality data. Treat as high risk until BscScan/DEX liquidity verified."
},
{
 "name":"CrystalToken / Crystl Finance","symbol":"CRYSTL","contract":"0x76bf0c28e604cc3fe9967c83b3c3f31c213cfe64","contract_address":"0x76bf0c28e604cc3fe9967c83b3c3f31c213cfe64","blockchain":"Polygon","price":0.000145,"market_cap":1800,"volume_24h":2.32,"liquidity":0,"holders":6168,"website":"https://crystl.finance","twitter":None,"telegram":None,"score":26,"rating":"HIGH RISK","dead_token":False,
 "risks":["Token flagged unverified by Phantom","Extremely low market cap (~$1.8K) and 24h volume (~$2.32)","LiveCoinWatch reports liquidity ±2% as $0.0000","Old DeFi/yield farm project, not a new launch","No current active socials verified in this cycle"],
 "community_score":5,"security_score":4,"discovered_at":now,"sources":["web_search","livecoinwatch","phantom"],"notes":"Crystl Finance / CrystalToken on Polygon. Has many holders but effectively negligible current trading activity; likely dormant/high-risk."
}
]
existing={(x.get('contract_address') or x.get('contract') or '').lower() for x in db}
added=[]; skipped=[]
for t in new:
    if t['contract_address'].lower() in existing:
        skipped.append(t['symbol'])
    else:
        db.append(t); added.append(t)
with open(db_path,'w',encoding='utf-8') as f: json.dump(db,f,ensure_ascii=False,indent=2)
lines=contracts_path.read_text(encoding='utf-8').splitlines()
clower='\n'.join(lines).lower()
for t in added:
    line=f"{t['contract_address']}|{t['symbol']}|{t['blockchain']}|{now}"
    if t['contract_address'].lower() not in clower: lines.append(line)
contracts_path.write_text('\n'.join(lines)+'\n',encoding='utf-8')
report={"session_id":"session_20260519_0040","timestamp":now,"sources_checked":["DexScreener search (403 blocked)","CoinGecko search (challenge blocked)","CoinMarketCap search/page snippets","Twitter/X via web_search","Reddit (verification blocked)","DEXTools fetch","Google/web_search keyword set","CoinMooner","LiveCoinWatch","Phantom","CoinPaprika","Krystal docs"],"tokens_found_total":18,"new_tokens_count":len(added),"skipped_existing_count":9,"added_tokens":added,"skipped_notes":["Existing/known: CRYS BSC, CYL Ethereum, CRST BSC, Crystal Stones BSC, CRT BSC, Solana Crystal Ha1..., Help Crystal, CrystalFinance Polygon, Crystal Diamond Ethereum.","Not added: Krystal Token docs because tokenomics/TGE still TBD and no contract/address found.","Not added: Crystaleum because no contract address/explorer found in fetched CoinPaprika content and volume is near-zero; candidate logged only."],"notable_tokens":[{"symbol":"CRYSTL","reason":"new to DB but high-risk/dormant; many holders yet near-zero volume/liquidity"},{"symbol":"CPC","reason":"new to DB but old and unverifiable market data"}],"errors":["DexScreener 403 challenge","CoinGecko challenge verification","CoinMarketCap search returned 404/oops via web_fetch","Reddit verification page","Some search providers returned zero results or unsupported filters"]}
out=base/'search_results'/'session_20260519_0040.json'
out.parent.mkdir(parents=True,exist_ok=True)
out.write_text(json.dumps(report,ensure_ascii=False,indent=2),encoding='utf-8')
print('added',len(added),'skipped',skipped,'report',out)
