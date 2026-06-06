import json, pathlib
base=pathlib.Path('reports/crystal')
db_path=base/'database_checked_tokens.json'
contracts_path=base/'checked_contracts.txt'
res_dir=base/'search_results'; res_dir.mkdir(parents=True, exist_ok=True)
with db_path.open(encoding='utf-8') as f: db=json.load(f)
if isinstance(db, dict): tokens=db.setdefault('tokens',[])
else: tokens=db
existing={str(t.get('contract_address') or t.get('contract') or '').lower() for t in tokens}
now='2026-05-22T00:40:00+07:00'
new_tokens=[
{
 "name":"Crystalbit","symbol":"Cbit","contract":"0xd50151A8BFAb84f7fe5552382F7e604F3Ead1eF2","contract_address":"0xd50151A8BFAb84f7fe5552382F7e604F3Ead1eF2","blockchain":"BSC","price":0.0002042,"market_cap":6433,"volume_24h":0.32,"liquidity":264.25,"holders":None,"website":None,"twitter":None,"telegram":None,"score":20,"rating":"HIGH RISK","dead_token":False,"risks":["Extremely low liquidity (~$264 on best observed pair)","Very low 24h volume (<$1 across visible pairs)","No official website/social/audit/holder distribution found in this cycle","Likely legacy or microcap BSC token; pair timestamps from 2024-2025, not a fresh launch"],"community_score":0,"security_score":4,"discovered_at":now,"sources":["dexscreener_api"],"notes":"Found via DexScreener 'crystal token/coin' query. Multiple PancakeSwap pairs exist against BTCB/CAKE/ETH; all have dust-level volume/liquidity. No wallet interaction performed."
},
{
 "name":"Ascension Crystals","symbol":"ACS","contract":"0x18fC6360E83FE91404d47Ea4400A221dfbBACF06","contract_address":"0x18fC6360E83FE91404d47Ea4400A221dfbBACF06","blockchain":"Avalanche","price":0.00006793,"market_cap":67920,"volume_24h":0.06,"liquidity":5.36,"holders":None,"website":None,"twitter":None,"telegram":None,"score":15,"rating":"DEAD TOKEN","dead_token":True,"risks":["DexScreener visible pairs show near-zero 24h volume", "Liquidity is effectively dust (~$5 on USDC.e pair; ~$1 on USDt pair)","No official website/social/audit/holder distribution found in this cycle","Likely inactive GameFi/resource-style token"],"community_score":0,"security_score":4,"discovered_at":now,"sources":["dexscreener_api"],"notes":"Found via DexScreener 'crystal coin' query. Market activity appears effectively dead/illiquid."
}
]
added=[]; skipped=[]
for t in new_tokens:
    if t['contract_address'].lower() in existing:
        skipped.append(t['contract_address']); continue
    tokens.append(t); existing.add(t['contract_address'].lower()); added.append(t)
with db_path.open('w',encoding='utf-8') as f: json.dump(db,f,ensure_ascii=False,indent=2)
with contracts_path.open('a',encoding='utf-8') as f:
    for t in added:
        f.write(f"{t['contract_address']}|{t['symbol']}|{t['blockchain']}|{now}\n")
report={"session":"session_20260522_0040","timestamp":now,"sources_checked":["DexScreener API: crystal, crystal token, crystal coin, new crystal, crystal defi","CoinGecko API search: crystal","CoinMarketCap search fetch (404/blocked)","web_search mandatory keywords (provider/config errors; skipped after retries)"],"found_candidates":12,"new_tokens_count":len(added),"skipped_existing_count":10,"new_tokens":added,"skipped_notes":["Existing contracts skipped: Crystaleum, DarkEnergyCrystals/DEC, Kyber Network Crystal variants, DeFi Kingdoms Crystal, CrystalNew Trade, CrystalToken/CRYSTL and other already-tracked crystal results.","Several DexScreener results were false positives caused by pair address/name containing 'new' or quote token KNC/CRYSTAL rather than a new crystal-themed base token."],"notable_tokens":[],"errors":["web_search failed due unsupported country/freshness then SearXNG base URL not configured","CoinMarketCap search page returned 404/blocked content"],"safety":"No wallet connection, purchase, or transaction signing performed."}
path=res_dir/'session_20260522_0040.json'
with path.open('w',encoding='utf-8') as f: json.dump(report,f,ensure_ascii=False,indent=2)
print(json.dumps({"added":len(added),"skipped":len(skipped),"report":str(path)},ensure_ascii=False))
