# NhanGianDieuKy - Auto Post Script
# Usage: powershell -File post_nhangiandieuky.ps1 -Message "content here"
param([string]$Message)

$pageId = "460822140448646"
$pageToken = "$nhangianToken"

if ([string]::IsNullOrEmpty($Message)) {
    Write-Host "Error: No message provided."
    exit 1
}

$body = @{message=$Message; access_token=$pageToken}
Write-Host "Posting to Nhân Gian Diệu Kỳ..."
$result = Invoke-RestMethod -Uri "https://graph.facebook.com/v25.0/$pageId/feed" -Method Post -Body $body
Write-Host "SUCCESS! Post ID: $($result.id)"
