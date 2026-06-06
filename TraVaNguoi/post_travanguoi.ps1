# TraVaNguoi - Auto Post Script with Image Support
# Usage: powershell -File post_travanguoi.ps1 -PostTime "0630" [-ImageUrl "https://..."]
param([string]$PostTime, [string]$ImageUrl = "")

$pageId = "1158980210638306"
$pageToken = "EAAWyTvHLkaABRTNE0gvIZCk3GL2lcmPcnKI2ApO8wTRUZBXpYWwDORgmtRxBPUvbJzpvEa6AKjmbZCXV4CAxolZC1NykJDoZBHuKmyNyztA4aMnMhcH2HVXqEfLAjd4H5MQ5LZBzYlaIcrHdz3tmoQ0kV843gfp5PnCz1MPX4rv0mIpaXWNUunwsS5rZBMjPdBB238d"
$contentDir = "C:\Users\DidierChan\.openclaw\workspace\TraVaNguoi\content"

# === IMAGE LIBRARY ===
# Sử dụng thư viện ảnh tập trung từ IMAGE_LIBRARY.json
$imageLibraryScript = "C:\Users\DidierChan\.openclaw\workspace\IMAGE_LIBRARY.ps1"

# === Lấy ảnh từ thư viện tập trung ===
$imageUrl = ""
try {
    $libResult = & powershell -NoProfile -File $imageLibraryScript -Action get -Count 1 -TimeSlot $PostTime 2>&1 | Where-Object { $_ -match '^https?://' }
    if ($libResult) {
        $imageUrl = $libResult | Select-Object -First 1
    }
} catch {}

if ([string]::IsNullOrEmpty($imageUrl)) {
    # Fallback nếu thư viện không có ảnh
    $fallbackImages = @(
        "https://images.unsplash.com/photo-1556679343-c7306c1976bc?w=800"
    )
    $dayOfYear = [DateTime]::UtcNow.AddHours(7).DayOfYear
    $imageUrl = $fallbackImages[$dayOfYear % $fallbackImages.Count]
}

# Calculate current day number (Day 1 = 2026-05-14)
$startDate = [DateTime]"2026-05-14"
$today = [DateTime]::UtcNow.AddHours(7)
$dayNum = [Math]::Floor(($today - $startDate).TotalDays) + 1
if ($dayNum -lt 1) { $dayNum = 1 }

$dayFolder = "Ngay$dayNum"
$dayPath = Join-Path $contentDir $dayFolder

# Map PostTime -> file pattern
$fileMap = @{
    "0630" = "*_0630_*"
    "1130" = "*_1130_*"
    "1530" = "*_1530_*"
    "2030" = "*_2030_*"
}

if (-not $fileMap.ContainsKey($PostTime)) {
    Write-Host "Invalid PostTime. Use 0630, 1130, 1530, or 2030."
    exit 1
}

$pattern = $fileMap[$PostTime]
$files = @(Get-ChildItem -Path $dayPath -Filter $pattern -File -ErrorAction SilentlyContinue)

if ($files.Count -eq 0) {
    Write-Host "No content file found for $PostTime (Day $dayNum)"
    $msg = "Tra va Nguoi - Ngay $dayNum. Cam on ban da dong hanh."
    if ([string]::IsNullOrEmpty($ImageUrl)) { $ImageUrl = $imageUrl }
    
    # Download + upload via multipart
    $tempImg = [System.IO.Path]::GetTempFileName() + ".jpg"
    try {
        Invoke-WebRequest -Uri $ImageUrl -OutFile $tempImg -TimeoutSec 15 -ErrorAction Stop | Out-Null
        $result = & curl.exe -s -X POST "https://graph.facebook.com/v25.0/$pageId/photos" -F "message=$msg" -F "source=@$tempImg" -F "access_token=$pageToken" 2>&1 | Out-String
        $resultObj = $result | ConvertFrom-Json -ErrorAction SilentlyContinue
        if ($resultObj -and $resultObj.id) {
            Write-Host "Posted generic with image: $($resultObj.id)"
            Remove-Item $tempImg -Force
            exit 0
        }
    } catch {}
    if (Test-Path $tempImg) { Remove-Item $tempImg -Force }
    
    # Fallback: text-only
    $body = @{message=$msg; access_token=$pageToken}
    $result = Invoke-RestMethod -Uri "https://graph.facebook.com/v25.0/$pageId/feed" -Method Post -Body $body
    Write-Host "Posted generic (text fallback): $($result.id)"
    exit 0
}

$file = $files[0]
$content = Get-Content $file.FullName -Raw -Encoding UTF8

# Parse content: skip Day header line, stop at photo prompt section
$cameraHi = [char]0xD83D
$cameraLo = [char]0xDCF8

$lines = $content -split "`n"
$postLines = @()
$firstLine = $true
$inFooter = $false

foreach ($line in $lines) {
    $trimmed = $line.Trim()
    if ($firstLine -and $line -match "^\s*# ") { $firstLine = $false; continue }
    $firstLine = $false
    if ($postLines.Count -eq 0 -and $trimmed -eq "---") { continue }
    if ($inFooter) { continue }
    if ($trimmed -match "^Prompt:") { $inFooter = $true; continue }
    if ($trimmed.Length -ge 2 -and $trimmed[0] -eq $cameraHi -and $trimmed[1] -eq $cameraLo) { $inFooter = $true; continue }
    $postLines += $line
}

$postMsg = $postLines -join "`n"
$postMsg = $postMsg.Trim()
if ($postMsg.Length -gt 60000) { $postMsg = $postMsg.Substring(0, 60000) }

# Determine image URL: user-provided > library
if ([string]::IsNullOrEmpty($ImageUrl)) { $ImageUrl = $imageUrl }

Write-Host "Posting Day $dayNum - $PostTime from $($file.Name)..."
Write-Host "Image: $ImageUrl"

# Download image to temp file, then upload via multipart (curl)
$tempImg = [System.IO.Path]::GetTempFileName() + ".jpg"
$uploadSuccess = $false
try {
    Invoke-WebRequest -Uri $ImageUrl -OutFile $tempImg -TimeoutSec 15 -ErrorAction Stop | Out-Null
    Write-Host "Downloaded $((Get-Item $tempImg).Length) bytes"
    
    # Upload via curl.exe multipart (PowerShell's Invoke-RestMethod -Form broken on PS5)
    $msgFile = [System.IO.Path]::GetTempFileName() + ".txt"
    [System.IO.File]::WriteAllText($msgFile, $postMsg, [System.Text.Encoding]::UTF8)
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
    $body = @{message=$postMsg; access_token=$pageToken}
    $result = Invoke-RestMethod -Uri "https://graph.facebook.com/v25.0/$pageId/feed" -Method Post -Body $body
    Write-Host "SUCCESS (text fallback)! Post ID: $($result.id)"
}

# Cleanup
if (Test-Path $tempImg) { Remove-Item $tempImg -Force }
