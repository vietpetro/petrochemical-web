$ErrorActionPreference='Stop'
$dir='C:/Users/DidierChan/.openclaw/workspace/reports/crystal'
$dbPath=Join-Path $dir 'database_checked_tokens.json'
$raw=Get-Content $dbPath -Raw -Encoding UTF8
$fixed=$raw -replace '\r?\n\s*\],\s*\r?\n\s*\{\s*\r?\n\s*"name":\s*"Ascension Crystals"', "`n               },`n               {`n                   `"name`":  `"Ascension Crystals`""
$fixed=$fixed -replace '\r?\n\s*}\s*$', "`n    ]`n}"
$db=$fixed | ConvertFrom-Json
$timestamp='2026-05-17T00:00:00+07:00'
$newTokens=@(
    [pscustomobject]@{
        name='Crysta Coin'; symbol='CRST'; contract_address='0xf38b7bc8ad0dc1dd4963fc3b9358e1fc0a4863e7'; blockchain='BSC'; price=0.01698688914515502; market_cap=1698688.9; volume_24h=$null; liquidity=$null; holders=$null; website='https://crystacoin.com'; twitter=$null; telegram='https://telegram.me/crysta_coin'; score=38; rating='HIGH RISK'; dead_token=$false; risks=@('old launch date (2022-08-12, not new)','no current volume/liquidity data found in this cycle','ambitious roadmap claims with limited independent verification','not found on major sources in current cycle','no audit/KYC data found'); community_score=8; security_score=3; liquidity_score=0; onchain_score=5; holder_score=7; website_social_score=15; discovered_at=$timestamp; sources=@('web_search','coinmooner','coinsniper','coinboom'); notes='Found via search result for Crysta Coin (CRST), BSC contract. CoinMooner lists launch 2022-08-12, price ~$0.01699, market cap ~$1.70M. Social links from CoinSniper: website crystacoin.com and Telegram crysta_coin. HIGH RISK due to age, weak verifiable market data and broad unverified claims.'
    },
    [pscustomobject]@{
        name='Crystal'; symbol='CRYSTAL'; contract_address='HaCLa4ik9xuVQuEMLyL3joZiP8hp9ZZyEJuXv85FUMfL'; blockchain='Solana'; price=$null; market_cap=$null; volume_24h=$null; liquidity=$null; holders=$null; website=$null; twitter=$null; telegram=$null; score=6; rating='HIGH RISK'; dead_token=$true; risks=@('Solflare result shows risk warning/no price data','no active website/social found','no market cap/volume/liquidity available','likely inactive or dust token','not discovered on DexScreener/CoinGecko current cycle'); community_score=0; security_score=2; liquidity_score=0; onchain_score=0; holder_score=4; website_social_score=0; discovered_at=$timestamp; sources=@('web_search','solflare'); notes='Found via web_search result for Solflare CRYSTAL token address. Search snippet indicated risk warning and no price information. No corroborating market or social data found; marked dead/high risk.'
    }
)
$existingContracts=@{}
foreach($t in $db.tokens){ if($t.contract_address){ $existingContracts[$t.contract_address.ToLower()]=$true } }
$added=@()
foreach($nt in $newTokens){ if(-not $existingContracts.ContainsKey($nt.contract_address.ToLower())){ $db.tokens += $nt; $added += $nt; $existingContracts[$nt.contract_address.ToLower()]=$true } }
$db.last_updated=$timestamp
$db.total_tokens=$db.tokens.Count
$db | ConvertTo-Json -Depth 100 | Set-Content $dbPath -Encoding UTF8
$contractsPath=Join-Path $dir 'checked_contracts.txt'
$content=Get-Content $contractsPath -Raw -Encoding UTF8
foreach($nt in $added){ if($content -notmatch [regex]::Escape($nt.contract_address)){ Add-Content $contractsPath ("{0}|{1}|{2}|{3}" -f $nt.contract_address,$nt.symbol,$nt.blockchain,$timestamp) -Encoding UTF8 } }
$session=[pscustomobject]@{ session_id='session_20260517_0000'; timestamp=$timestamp; cycle='crystal-search-cycle'; total_candidates_found=12; skipped_existing=10; new_tokens_found=$added.Count; tokens_added=$added; sources_checked=@('DexScreener fetch','CoinGecko fetch','CoinMarketCap fetch','Reddit fetch','DEXTools fetch','web_search keywords','CoinMooner fetch','Solflare search'); skipped=@('Crystal Token CYL','Crystal ERC404 Arbitrum','Crystals CRYS','DeFi Kingdoms Crystal','Crystal Wallet CRT','Solana CRYSTAL Ha1N...','Kyber Network Crystal','Aster Crystal airdrop phase','Crystal Moonshot old presale','programming-language crystal coin irrelevant'); errors=@('DexScreener blocked by Cloudflare/403','CoinGecko challenge/403','CoinMarketCap app error/404','Reddit verification page','DEXTools app shell no extractable token data'); notable=@('No STRONG/GOOD new crystal token discovered','Crysta Coin CRST added but HIGH RISK'); safety='No wallet connected, no trade/signature attempted.' }
$out='C:/Users/DidierChan/.openclaw/workspace/reports/crystal/search_results/session_20260517_0000.json'
$session | ConvertTo-Json -Depth 100 | Set-Content $out -Encoding UTF8
"added=$($added.Count); total=$($db.total_tokens); session=$out"

