$pageToken = "EAAWyTvHLkaABRf5uSfk1BRF6de4XBdfs5ampwcZALuEhmFgdGXul0k0R5Bp4vwxDjdIBiDuBGTGzQho7ReZCn3uQQmbniiPW6EZAWj2MUSSxCf6BAmZAkelMLxEO5jugYYSPuG925JejKpyJ4Rp7yJlK9zPY0Cl5I2OIO4vXZBZCrZBL5YSfOvMlUyEQYQdsY3dUq3u0xjtSKMgz5fTkkB5GPzciOZC1WTSY9uxirZAsZD"
$pageId = "1158980210638306"

$msg = "☕ Trà là thức uống của sự tĩnh lặng.
 
Mỗi ngày, hãy dành ra 10 phút, pha một ấm trà, ngồi yên và lắng nghe hơi thở của chính mình.
 
Trà không chỉ là một thức uống – trà là một lối sống.
 
#TraVaNguoi #TinhLang #ChuaLanh #TraDao #SongCham"

$body = @{message=$msg; access_token=$pageToken}
$result = Invoke-RestMethod -Uri "https://graph.facebook.com/v25.0/$pageId/feed" -Method Post -Body $body
Write-Host "=== POST RESULT ==="
$result | ConvertTo-Json
