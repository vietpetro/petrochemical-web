$pageToken = "EAAWyTvHLkaABRf5uSfk1BRF6de4XBdfs5ampwcZALuEhmFgdGXul0k0R5Bp4vwxDjdIBiDuBGTGzQho7ReZCn3uQQmbniiPW6EZAWj2MUSSxCf6BAmZAkelMLxEO5jugYYSPuG925JejKpyJ4Rp7yJlK9zPY0Cl5I2OIO4vXZBZCrZBL5YSfOvMlUyEQYQdsY3dUq3u0xjtSKMgz5fTkkB5GPzciOZC1WTSY9uxirZAsZD"
$pageId = "1158980210638306"
$msg = "Tra la thuc uong cua su tinh lang. Moi ngay, hay danh ra 10 phut, pha mot am tra, ngoi yen va lang nghe hoi tho cua chinh minh. Tra khong chi la mot thuc uong - tra la mot loi song."
$body = @{message=$msg; access_token=$pageToken}
Write-Host "Posting to page $pageId ..."
$result = Invoke-RestMethod -Uri "https://graph.facebook.com/v25.0/$pageId/feed" -Method Post -Body $body
$result | ConvertTo-Json
