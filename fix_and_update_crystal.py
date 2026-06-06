import json, re, pathlib

workspace = pathlib.Path(r'C:/Users/DidierChan/.openclaw/workspace')
dirp = workspace / 'reports' / 'crystal'
db_path = dirp / 'database_checked_tokens.json'
contracts_path = dirp / 'checked_contracts.txt'
session_path = dirp / 'search_results' / 'session_20260517_0000.json'

raw = db_path.read_text(encoding='utf-8-sig')
raw = re.sub(r'(\n\s*\}\s*\n\s*)\],(\s*\n\s*\{\s*\n\s*"name"\s*:\s*"Ascension Crystals")', r'\1,\2', raw, count=1)
raw = re.sub(r'\n\s*}\s*$', '\n    ]\n}', raw)
obj = json.loads(raw)

timestamp = '2026-05-17T00:00:00+07:00'
new_tokens = [
    {
        'name': 'Crysta Coin', 'symbol': 'CRST', 'contract_address': '0xf38b7bc8ad0dc1dd4963fc3b9358e1fc0a4863e7', 'blockchain': 'BSC',
        'price': 0.01698688914515502, 'market_cap': 1698688.9, 'volume_24h': None, 'liquidity': None, 'holders': None,
        'website': 'https://crystacoin.com', 'twitter': None, 'telegram': 'https://telegram.me/crysta_coin',
        'score': 38, 'rating': 'HIGH RISK', 'dead_token': False,
        'risks': ['old launch date (2022-08-12, not new)', 'no current volume/liquidity data found in this cycle', 'ambitious roadmap claims with limited independent verification', 'not found on major sources in current cycle', 'no audit/KYC data found'],
        'community_score': 8, 'security_score': 3, 'liquidity_score': 0, 'onchain_score': 5, 'holder_score': 7, 'website_social_score': 15,
        'discovered_at': timestamp, 'sources': ['web_search', 'coinmooner', 'coinsniper', 'coinboom'],
        'notes': 'Found via search result for Crysta Coin (CRST), BSC contract. CoinMooner lists launch 2022-08-12, price about $0.01699, market cap about $1.70M. Social links from CoinSniper: website crystacoin.com and Telegram crysta_coin. HIGH RISK due to age, weak verifiable market data and broad unverified claims.'
    },
    {
        'name': 'Crystal', 'symbol': 'CRYSTAL', 'contract_address': 'HaCLa4ik9xuVQuEMLyL3joZiP8hp9ZZyEJuXv85FUMfL', 'blockchain': 'Solana',
        'price': None, 'market_cap': None, 'volume_24h': None, 'liquidity': None, 'holders': None,
        'website': None, 'twitter': None, 'telegram': None,
        'score': 6, 'rating': 'HIGH RISK', 'dead_token': True,
        'risks': ['Solflare result shows risk warning/no price data', 'no active website/social found', 'no market cap/volume/liquidity available', 'likely inactive or dust token', 'not discovered on DexScreener/CoinGecko current cycle'],
        'community_score': 0, 'security_score': 2, 'liquidity_score': 0, 'onchain_score': 0, 'holder_score': 4, 'website_social_score': 0,
        'discovered_at': timestamp, 'sources': ['web_search', 'solflare'],
        'notes': 'Found via web_search result for Solflare CRYSTAL token address. Search snippet indicated risk warning and no price information. No corroborating market or social data found; marked dead/high risk.'
    }
]

existing = {str(t.get('contract_address','')).lower() for t in obj['tokens'] if t.get('contract_address')}
added = []
for t in new_tokens:
    if t['contract_address'].lower() not in existing:
        obj['tokens'].append(t)
        existing.add(t['contract_address'].lower())
        added.append(t)

obj['last_updated'] = timestamp
obj['total_tokens'] = len(obj['tokens'])
db_path.write_text(json.dumps(obj, ensure_ascii=False, indent=4), encoding='utf-8')

contracts_text = contracts_path.read_text(encoding='utf-8-sig')
with contracts_path.open('a', encoding='utf-8') as f:
    for t in added:
        if t['contract_address'] not in contracts_text:
            f.write(f"{t['contract_address']}|{t['symbol']}|{t['blockchain']}|{timestamp}\n")

session = {
    'session_id': 'session_20260517_0000',
    'timestamp': timestamp,
    'cycle': 'crystal-search-cycle',
    'total_candidates_found': 12,
    'skipped_existing': 10,
    'new_tokens_found': len(added),
    'tokens_added': added,
    'sources_checked': ['DexScreener fetch', 'CoinGecko fetch', 'CoinMarketCap fetch', 'Reddit fetch', 'DEXTools fetch', 'web_search keywords', 'CoinMooner fetch', 'Solflare search'],
    'skipped': ['Crystal Token CYL', 'Crystal ERC404 Arbitrum', 'Crystals CRYS', 'DeFi Kingdoms Crystal', 'Crystal Wallet CRT', 'Solana CRYSTAL Ha1N...', 'Kyber Network Crystal', 'Aster Crystal airdrop phase', 'Crystal Moonshot old presale', 'programming-language crystal coin irrelevant'],
    'errors': ['DexScreener blocked by Cloudflare/403', 'CoinGecko challenge/403', 'CoinMarketCap app error/404', 'Reddit verification page', 'DEXTools app shell no extractable token data'],
    'notable': ['No STRONG/GOOD new crystal token discovered', 'Crysta Coin CRST added but HIGH RISK'],
    'safety': 'No wallet connected, no trade/signature attempted.'
}
session_path.write_text(json.dumps(session, ensure_ascii=False, indent=2), encoding='utf-8')
print(f'added={len(added)} total={obj["total_tokens"]}')
