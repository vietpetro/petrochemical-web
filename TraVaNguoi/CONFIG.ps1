# Cấu hình tự động Fanpage "Trà và Người"
# Được tạo bởi Gia nô - Cập nhật: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')

# Page ID
$pageId = "1158980210638306"

# Page Access Token (quyền: CREATE_CONTENT, MANAGE, MODERATE, ANALYZE, ADVERTISE)
$pageToken = "EAAWyTvHLkaABRf5uSfk1BRF6de4XBdfs5ampwcZALuEhmFgdGXul0k0R5Bp4vwxDjdIBiDuBGTGzQho7ReZCn3uQQmbniiPW6EZAWj2MUSSxCf6BAmZAkelMLxEO5jugYYSPuG925JejKpyJ4Rp7yJlK9zPY0Cl5I2OIO4vXZBZCrZBL5YSfOvMlUyEQYQdsY3dUq3u0xjtSKMgz5fTkkB5GPzciOZC1WTSY9uxirZAsZD"

# App Token dùng để refresh
$appId = "1603427017396640"
$appSecret = "sewXN6zUTwJwsgMvG1z5fxgCWKc"

# Content directory
$contentDir = "C:\Users\DidierChan\.openclaw\workspace\TraVaNguoi\content"

# Export
Write-Host "Page: Trà và Người (ID: $pageId)"
Write-Host "Token scopes: pages_show_list, pages_manage_posts, pages_read_engagement, business_management"
Write-Host "Status: ACTIVE"
