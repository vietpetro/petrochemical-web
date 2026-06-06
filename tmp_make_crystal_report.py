import json, pathlib, datetime
now='2026-05-22T04:20:00+07:00'
out=pathlib.Path('reports/crystal/search_results/session_20260522_0420.json')
out.parent.mkdir(parents=True, exist_ok=True)
# Load existing counts robustly
text=pathlib.Path('reports/crystal/database_checked_tokens.json').read_text(encoding='utf-8-sig')
db=json.loads(text)
if isinstance(db, list) and db and isinstance(db[0], dict) and 'value' in db[0]:
    tokens=db[0]['value']
elif isinstance(db, dict):
    tokens=db.get('tokens', [])
elif isinstance(db, list):
    tokens=db
else:
    tokens=[]
checked=pathlib.Path('reports/crystal/checked_contracts.txt').read_text(encoding='utf-8-sig').splitlines()
found_candidates=[
 {'name':'Crystaleum','symbol':'CRYSTAL','contract_address':'0x4ca6B6b8F10EB17DbD1f8c3F313Eca2F779C6e0B','blockchain':'BSC','source':'dexscreener_api','status':'skipped_existing','evidence':'DexScreener search: liquidity ~$53/$16/$6 across pairs; very low 24h volume; contract already checked 2026-05-21.'},
 {'name':'Crystal Ball','symbol':'Crystal','contract_address':'Gt7KEPHDrt9aXcET3xGxhqLp2bULGkZaD3fbduF1pump','blockchain':'Solana','source':'dexscreener_api','status':'skipped_existing','evidence':'DexScreener search: pumpfun pair, 24h volume ~$52, FDV ~$2.4K; already checked 2026-05-22 00:05.'},
 {'name':'Crystal','symbol':'CRYSTAL','contract_address':'0x16d921c514dFcA9eC47bA57892b6Dbdd17285284','blockchain':'BSC','source':'dexscreener_api','status':'skipped_existing','evidence':'DexScreener search: old PancakeSwap pairs, negligible volume/liquidity; already checked 2026-05-21.'},
 {'name':'Crystals','symbol':'CRYSTAL','contract_address':'0x04b9dA42306B023f3572e106B11D82aAd9D32EBb','blockchain':'DFK Chain / Avalanche DFK','source':'dexscreener_api/geckoterminal_api','status':'skipped_existing','evidence':'DexScreener/GeckoTerminal: DFK CRYSTAL pools with >$50K liquidity but low 24h volume; already checked 2026-05-21.'},
 {'name':'DarkEnergyCrystals','symbol':'DEC','contract_address':'0xE9D7023f2132D55cbd4Ee1f78273CB7a3e74F10A','blockchain':'BSC / Ethereum','source':'dexscreener_api','status':'skipped_existing','evidence':'DexScreener: DEC/USDC BSC pools, active volume; already checked 2026-05-22 00:05.'},
 {'name':'CrystalPowder','symbol':'CP','contract_address':'0xe9C133D3D94263C7aC7B848168138D7cF2cEbA14','blockchain':'BSC','source':'dexscreener_api','status':'skipped_existing','evidence':'DexScreener search result; contract already checked 2026-05-22 01:00.'},
 {'name':'Kyber Network Crystal','symbol':'KNC','contract_address':'0xdefa4e8a7bcba345f687a2f1456f5edd9ce97202','blockchain':'Ethereum / multi-chain','source':'geckoterminal_api','status':'skipped_existing','evidence':'GeckoTerminal search returned KNC pools on Polygon/Arbitrum/Optimism/Ethereum; core KNC contracts already checked.'}
]
report={
 'session':'session_20260522_0420',
 'timestamp':now,
 'cycle_window':'00:00-05:00 Asia/Saigon',
 'database_tokens_before':len(tokens),
 'contracts_before':len([l for l in checked if l.strip() and not l.startswith('#')]),
 'sources_checked':[
   {'source':'DexScreener API/search','status':'ok','notes':'UI web_fetch blocked by 403, API returned JSON pairs.'},
   {'source':'GeckoTerminal API search','status':'ok','notes':'Used as CoinGecko-adjacent DEX data fallback.'},
   {'source':'CoinGecko web','status':'blocked','notes':'Cloudflare/challenge verification.'},
   {'source':'CoinMarketCap web','status':'error','notes':'Search page returned error/404 via fetch.'},
   {'source':'Reddit web','status':'blocked','notes':'Verification page only.'},
   {'source':'DEXTools web','status':'partial','notes':'Static shell only, no usable token rows.'},
   {'source':'web_search','status':'unavailable','notes':'Configured providers rejected country/freshness, then SearXNG base URL missing.'}
 ],
 'keywords_attempted':['crystal token','crystal coin','crystal crypto','crystal defi','crystal ecosystem','new crystal token','crystal token crypto new launch','crystal coin new launch 2026','crystal token presale airdrop','crystal defi token BSC Solana'],
 'found_candidates_count':len(found_candidates),
 'new_tokens_count':0,
 'skipped_existing_count':len(found_candidates),
 'new_tokens':[],
 'skipped':found_candidates,
 'notable_tokens':[],
 'summary':'Không phát hiện token crystal mới chưa có trong database ở chu kỳ 04:20. Các kết quả hữu ích đều là contract đã kiểm tra trước đó.',
 'safety':'No wallet connections, purchases, signatures, or external transactions performed.'
}
out.write_text(json.dumps(report, ensure_ascii=False, indent=2), encoding='utf-8')
print(out)
print(json.dumps({'found':len(found_candidates),'new':0,'skipped':len(found_candidates)}, ensure_ascii=False))
