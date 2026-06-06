import json, pathlib
from datetime import datetime, timezone, timedelta

base = pathlib.Path(r"C:\Users\DidierChan\.openclaw\workspace\reports\crystal")
db_path = base / "database_checked_tokens.json"
contracts_path = base / "checked_contracts.txt"
session_path = base / "search_results" / "session_20260521_0540.json"

with open(db_path, 'r', encoding='utf-8-sig') as f:
    db = json.load(f)

tokens = db if isinstance(db, list) else db.get('tokens', [])
existing_contracts = {str((t.get('contract_address') or t.get('contract') or '')).lower() for t in tokens}

now = "2026-05-21T05:40:00+07:00"

candidate = {
    "name": "CRYSTAL",
    "symbol": "CRYST",
    "contract": "0x82732f9979a778e0a7083d992B9e71935578Ad6d",
    "contract_address": "0x82732f9979a778e0a7083d992B9e71935578Ad6d",
    "blockchain": "BSC",
    "price": 0.06230186561930144,
    "market_cap": 43599965.44,
    "volume_24h": None,
    "liquidity": None,
    "holders": None,
    "website": None,
    "twitter": None,
    "telegram": None,
    "score": 28,
    "rating": "HIGH RISK",
    "dead_token": False,
    "risks": [
        "Token launch date 2021-09-07, not a new launch",
        "Primary data from CoinMooner page only; core sources were blocked/challenged",
        "No reliable current liquidity/volume/holder distribution verified in this cycle",
        "No verified audit/KYC evidence found"
    ],
    "community_score": 5,
    "security_score": 4,
    "discovered_at": now,
    "sources": ["web_search", "web_fetch", "coinmooner"],
    "notes": "Found via mandatory keyword scans; contract/address from CoinMooner CRYSTAL (CRYST) page. Added as tracked high-risk legacy token."
}

added = []
skipped = []
if candidate['contract_address'].lower() not in existing_contracts:
    tokens.append(candidate)
    added.append(candidate)
else:
    skipped.append({"name": candidate['name'], "symbol": candidate['symbol'], "contract_address": candidate['contract_address'], "reason": "existing_contract"})

with open(db_path, 'w', encoding='utf-8') as f:
    if isinstance(db, list):
        json.dump(tokens, f, ensure_ascii=False, indent=2)
    else:
        db['tokens'] = tokens
        db['last_updated'] = now
        db['total_tokens'] = len(tokens)
        json.dump(db, f, ensure_ascii=False, indent=2)

if added:
    with open(contracts_path, 'a', encoding='utf-8') as f:
        for t in added:
            f.write(f"{t['contract_address']}|{t['symbol']}|{t['blockchain']}|{now}\n")

report = {
    "session_id": "session_20260521_0540",
    "timestamp": now,
    "cycle": "crystal-search-cycle",
    "searched_keywords": ["crystal token", "crystal coin", "crystal crypto", "crystal defi", "crystal ecosystem", "new crystal token"],
    "sources_checked": [
        {"source": "DexScreener", "status": "partial", "note": "web page blocked/challenge; API search reachable via web_fetch"},
        {"source": "CoinGecko", "status": "failed", "note": "403 challenge"},
        {"source": "CoinMarketCap", "status": "failed", "note": "search page error/404"},
        {"source": "Twitter/X", "status": "failed", "note": "web_search provider/config issues"},
        {"source": "Reddit", "status": "failed", "note": "verification gate"},
        {"source": "DEXTools", "status": "failed", "note": "app shell / no extractable results"},
        {"source": "Google-style web_search", "status": "partial", "note": "intermittent provider/config errors"}
    ],
    "found_candidates": 9,
    "new_tokens_added": len(added),
    "skipped_existing": 8,
    "added_tokens": added,
    "skipped": skipped,
    "notable": ["No STRONG/GOOD candidate found in this cycle", "One legacy BSC token CRYST added as HIGH RISK tracking entry"],
    "errors": ["Multiple web_search calls failed: SearXNG base URL not configured", "CoinGecko anti-bot challenge", "CoinMarketCap search fetch failure", "Reddit verification page"],
    "safety": "No wallet connection, no trading, no signature actions performed"
}

session_path.parent.mkdir(parents=True, exist_ok=True)
with open(session_path, 'w', encoding='utf-8') as f:
    json.dump(report, f, ensure_ascii=False, indent=2)

print(json.dumps({"added": len(added), "session": str(session_path)}, ensure_ascii=False))
