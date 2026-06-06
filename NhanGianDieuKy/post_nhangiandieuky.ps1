# post_nhangiandieuky.ps1
# Posts a pre-written message to Nhân Gian Diệu Kỳ Facebook page
param([string]$PostTime)

$pageId = "460822140448646"
$pageToken = "EAAWyTvHLkaABRAPXbZAYEx3qJ05CZBZCEmCftZCjP2ZBZC6efZAlqZABZBsCISvGCecOQHCtxSB0XemvKskZCZCl2NYvNqZAWYU9cEhXZCqR3ISZAsZCdTWZALZB4W0Nwl3MZBHi33nJXaRzIYyX8XOMN2FP3BY0CxO2Nbgj2OQ4ebCXwjZAr1JA2s4hFEpHCm16jGhMOBBsaxR15k0KlyoV"

$contentDir = "C:\Users\DidierChan\.openclaw\workspace\nhandiankydieu-content"
$imageLibraryScript = "C:\Users\DidierChan\.openclaw\workspace\IMAGE_LIBRARY.ps1"

# Determine content file pattern
$filePatterns = @{
    "0530" = "Day*_0530*"
    "1130" = "Day*_1130*"
    "1530" = "Day*_1530*"
    "2000" = "Day*_2000*"
    "2300" = "Day*_2300*"
}

if (-not $filePatterns.ContainsKey($PostTime)) {
    Write-Host "Invalid PostTime. Use 0530, 1130, 1530, 2000, or 2300."
    exit 1
}

# Find content file for today
$startDate = [DateTime]"2026-05-14"
$today = [DateTime]::UtcNow.AddHours(7)
$dayNum = [Math]::Floor(($today - $startDate).TotalDays) + 1
if ($dayNum -lt 1) { $dayNum = 1 }

$pattern = $filePatterns[$PostTime]
$files = @(Get-ChildItem -Path $contentDir -Filter $pattern -File -ErrorAction SilentlyContinue)

if ($files.Count -eq 0) {
    Write-Host "No content file found for $PostTime (Day $dayNum)"
    exit 1
}

$file = $files[0]
$message = Get-Content $file.FullName -Raw -Encoding UTF8
$message = $message.Trim()

# === Lấy ảnh từ thư viện tập trung ===
$imageUrl = ""
try {
    $libResult = & powershell -NoProfile -File $imageLibraryScript -Action get -Count 1 -TimeSlot $PostTime 2>&1 | Where-Object { $_ -match '^https?://' }
    if ($libResult) {
        $imageUrl = $libResult | Select-Object -First 1
    }
} catch {}

if ([string]::IsNullOrEmpty($imageUrl)) {
    # Fallback
    $retryImages = @(
        "https://images.unsplash.com/photo-1506126613408-eca07ce68773?w=800"
    )
    $imageUrl = $retryImages[0]
}

Write-Host "Posting Nhan Gian Dieu Ky - $PostTime (Day $dayNum)..."
Write-Host "Image: $imageUrl"

# Download image and upload with text
$tempImg = [System.IO.Path]::GetTempFileName() + ".jpg"
$uploadSuccess = $false
try {
    Invoke-WebRequest -Uri $imageUrl -OutFile $tempImg -TimeoutSec 15 -ErrorAction Stop | Out-Null
    Write-Host "Downloaded $((Get-Item $tempImg).Length) bytes"

    $msgFile = [System.IO.Path]::GetTempFileName() + ".txt"
    [System.IO.File]::WriteAllText($msgFile, $message, [System.Text.Encoding]::UTF8)
    $result = & curl.exe -s -X POST "https://graph.facebook.com/v25.0/$pageId/photos" `
        -F "message=<$msgFile" `
        -F "source=@$tempImg" `
        -F "access_token=$pageToken" 2>&1 | Out-String
    Remove-Item $msgFile -Force

    $resultObj = $result | ConvertFrom-Json -ErrorAction SilentlyContinue
    if ($resultObj -and $resultObj.id) {
        Write-Host "SUCCESS! Post ID: $($resultObj.id)"
        $uploadSuccess = $true
    } else {
        Write-Host "Image upload failed, retrying text-only..."
        Write-Host "curl result: $result"
    }
} catch {
    Write-Host "Image download/upload failed, retrying text-only..."
}

if (-not $uploadSuccess) {
    $body = @{message=$message; access_token=$pageToken}
    $result = Invoke-RestMethod -Uri "https://graph.facebook.com/v25.0/$pageId/feed" -Method Post -Body $body
    Write-Host "SUCCESS (text fallback)! Post ID: $($result.id)"
}

# Cleanup
if (Test-Path $tempImg) { Remove-Item $tempImg -Force }
