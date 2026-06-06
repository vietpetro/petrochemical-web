# post_fb.ps1 - Post message to any Facebook Page via Graph API, with optional image
# Usage: powershell -File post_fb.ps1 -Page "travanguoi|nhangiandieuky" -Message "text" [-ImageUrl "https://..."]
param([string]$Page, [string]$Message, [string]$ImageUrl = "")

$pages = @{
    "travanguoi" = @{
        id = "1158980210638306"
        token = "EAAWyTvHLkaABRTNE0gvIZCk3GL2lcmPcnKI2ApO8wTRUZBXpYWwDORgmtRxBPUvbJzpvEa6AKjmbZCXV4CAxolZC1NykJDoZBHuKmyNyztA4aMnMhcH2HVXqEfLAjd4H5MQ5LZBzYlaIcrHdz3tmoQ0kV843gfp5PnCz1MPX4rv0mIpaXWNUunwsS5rZBMjPdBB238d"
        images = @(
            "https://images.unsplash.com/photo-1556679343-c7306c1976bc?w=800",
            "https://images.unsplash.com/photo-1563822249366-3efb23b8e0c9?w=800",
            "https://images.unsplash.com/photo-1544787219-7f47ccb76574?w=800",
            "https://images.unsplash.com/photo-1571934811356-5cc061b6821f?w=800",
            "https://images.unsplash.com/photo-1558160074-4d7d8bdf4256?w=800",
            "https://images.unsplash.com/photo-1498804103079-a6351b050096?w=800"
        )
    }
    "nhangiandieuky" = @{
        id = "460822140448646"
        token = "EAAWyTvHLkaABRSlcDJv98E02bs7BPJzv2HNdrR6LaCMvRrwA0cf78EW0nlhl0xvgasvl7ZA7SKyIbNC8V9eZA254HlSGd3ZBafDLJtvimn6KtHZA5AMzWZA5FWZCnkUPg39URvaP7SQek22WFcSZC3oqGqZBPLE70KApCoD2645aIpZAB3QXKci76ujg7hZBN7COvZCnZBgm"
        images = @(
            "https://images.unsplash.com/photo-1506126613408-eca07ce68773?w=800",
            "https://images.unsplash.com/photo-1499209974431-9dddcece7f88?w=800",
            "https://images.unsplash.com/photo-1518241353330-0f7941c2d9b5?w=800",
            "https://images.unsplash.com/photo-1563822249366-3efb23b8e0c9?w=800",
            "https://images.unsplash.com/photo-1498804103079-a6351b050096?w=800",
            "https://images.unsplash.com/photo-1536256263959-770b48d82b0a?w=800"
        )
    }
}

if (-not $pages.ContainsKey($Page)) {
    Write-Host "Invalid page. Use: travanguoi or nhangiandieuky"
    exit 1
}

$pageInfo = $pages[$Page]
$pageId = $pageInfo.id
$token = $pageInfo.token

# Auto-select image from library if none provided
if ([string]::IsNullOrEmpty($ImageUrl)) {
    $dayOfYear = [DateTime]::UtcNow.AddHours(7).DayOfYear
    $idx = $dayOfYear % $pageInfo.images.Count
    $ImageUrl = $pageInfo.images[$idx]
}

Write-Host "Posting to $Page..."
Write-Host "Image: $ImageUrl"

# Download image to temp file, then upload via curl multipart (url param deprecated/bloked)
$tempImg = [System.IO.Path]::GetTempFileName() + ".jpg"
$uploadSuccess = $false
try {
    Invoke-WebRequest -Uri $ImageUrl -OutFile $tempImg -TimeoutSec 15 -ErrorAction Stop | Out-Null
    Write-Host "Downloaded $((Get-Item $tempImg).Length) bytes"
    
    $msgFile = [System.IO.Path]::GetTempFileName() + ".txt"
    [System.IO.File]::WriteAllText($msgFile, $Message, [System.Text.Encoding]::UTF8)
    $result = & curl.exe -s -X POST "https://graph.facebook.com/v25.0/$pageId/photos" `
        -F "message=<$msgFile" `
        -F "source=@$tempImg" `
        -F "access_token=$token" 2>&1 | Out-String
    Remove-Item $msgFile -Force
    
    $resultObj = $result | ConvertFrom-Json -ErrorAction SilentlyContinue
    if ($resultObj -and $resultObj.id) {
        Write-Host "SUCCESS! Post ID: $($resultObj.id)"
        $uploadSuccess = $true
    } else {
        Write-Host "Image upload failed. curl result: $result"
    }
} catch {
    Write-Host "Image processing failed: $($_.Exception.Message)"
}

# Cleanup
if (Test-Path $tempImg) { Remove-Item $tempImg -Force }

if (-not $uploadSuccess) {
    Write-Host "Retrying text-only..."
    $body = @{message=$Message; access_token=$token}
    $result = Invoke-RestMethod -Uri "https://graph.facebook.com/v25.0/$pageId/feed" -Method Post -Body $body
    Write-Host "SUCCESS (text fallback)! Post ID: $($result.id)"
}
