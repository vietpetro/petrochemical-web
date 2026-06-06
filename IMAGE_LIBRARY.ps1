# IMAGE_LIBRARY.ps1 - Quản lý thư viện hình ảnh cho Trà và Người & Nhân Gian Diệu Kỳ
# Usage:
#   .\IMAGE_LIBRARY.ps1 -Action get -Count 1 -Category tea
#   .\IMAGE_LIBRARY.ps1 -Action get -Count 5 -TimeSlot 0630
#   .\IMAGE_LIBRARY.ps1 -Action stats
#   .\IMAGE_LIBRARY.ps1 -Action add -Count 20

param(
    [ValidateSet("get","stats","add","verify")]
    [string]$Action = "stats",
    [int]$Count = 1,
    [string]$Category = "",
    [string]$TimeSlot = "",
    [ValidateSet("tea","matcha","green-tea","tea-plantation","meditation","sunrise","zen","forest","lake","sunset","candle","lotus","starry-night","waterfall","bamboo","all")]
    [string]$FilterCategory = "all",
    [string]$PhotoIdsFile = ""  # Path to file containing new photo IDs for 'add' action
)

$libPath = "C:\Users\DidierChan\.openclaw\workspace\IMAGE_LIBRARY.json"

# Time-based category mapping
$timeCategoryMap = @{
    "0630" = @("sunrise", "meditation", "zen", "forest", "green-tea")
    "1130" = @("tea", "matcha", "meditation", "zen", "lotus")
    "1530" = @("tea", "tea-plantation", "lake", "sunset", "zen")
    "2030" = @("sunset", "candle", "starry-night", "meditation", "bamboo")
    "2000" = @("sunset", "candle", "starry-night", "meditation", "zen")
    "2300" = @("starry-night", "candle", "meditation", "zen", "lake")
    "0530" = @("sunrise", "meditation", "zen", "forest", "lake")
}

# Load library
$lib = Get-Content $libPath -Raw | ConvertFrom-Json
$images = $lib.images

function Show-Stats {
    $total = $images.Count
    $target = $lib.metadata.target
    $cats = $images | Group-Object category
    Write-Host "=== THƯ VIỆN HÌNH ẢNH ==="
    Write-Host "Tổng số: $total / $target ảnh"
    Write-Host "Cần thêm: $($target - $total) ảnh"
    Write-Host ""
    Write-Host "Phân bố theo thể loại:"
    foreach ($c in $cats) {
        $pct = [math]::Round(($c.Count / $total) * 100, 1)
        Write-Host "  $($c.Name): $($c.Count) ảnh ($pct%)"
    }
    Write-Host ""
    Write-Host "Ngày cập nhật: $($lib.metadata.created)"
}

function Get-Image {
    param([int]$count, [string]$category, [string]$timeSlot)

    $pool = @($images)
    
    if ($category -and $category -ne "all" -and $category -ne "") {
        $pool = $pool | Where-Object { $_.category -eq $category }
    }
    
    if ($timeSlot -and $timeSlot -ne "") {
        if ($timeCategoryMap.ContainsKey($timeSlot)) {
            $cats = $timeCategoryMap[$timeSlot]
            $pool = $pool | Where-Object { $_.category -in $cats }
        }
    }
    
    if ($pool.Count -eq 0) {
        # Fallback to all images
        $pool = @($images)
    }
    
    # Use deterministic rotation by day + hour to avoid repeating
    $today = [DateTime]::UtcNow.AddHours(7)
    $seed = $today.DayOfYear * 100 + ($today.Hour % 24)
    $rng = [Random]::new($seed)
    
    $result = @()
    $poolCopy = @($pool | Sort-Object { $rng.Next() })
    
    for ($i = 0; $i -lt [Math]::Min($count, $poolCopy.Count); $i++) {
        $result += $poolCopy[$i]
    }
    
    return $result
}

function Add-Images {
    param([int]$count, [string]$photoIdsFile)
    
    Write-Host "Chức năng thêm ảnh cần được thực hiện thủ công qua browser."
    Write-Host "Ảnh mới cần được crawl từ Unsplash và thêm vào IMAGE_LIBRARY.json"
    Write-Host ""
    Write-Host "Hướng dẫn:"
    Write-Host "1. Mở browser và search: https://unsplash.com/s/photos/KEYWORD"
    Write-Host "2. Dùng browser tool snapshot extract photo IDs"
    Write-Host "3. Thêm vào IMAGE_LIBRARY.json với id, photoId, category, url, added"
}

switch ($Action) {
    "stats" { Show-Stats }
    "get" {
        $result = Get-Image -count $Count -category $FilterCategory -timeSlot $TimeSlot
        if ($result.Count -eq 0) {
            Write-Host "NO_IMAGE"
            exit 1
        }
        foreach ($img in $result) {
            Write-Host "$($img.url)"
        }
    }
    "verify" {
        Write-Host "Đang kiểm tra ảnh (sample 10 ảnh đầu tiên)..."
        $testImages = $images | Select-Object -First 10
        $working = 0
        $failed = 0
        foreach ($img in $testImages) {
            try {
                $req = [System.Net.WebRequest]::Create($img.url)
                $req.Method = "HEAD"
                $req.Timeout = 5000
                $resp = $req.GetResponse()
                if ($resp.StatusCode -eq 200) { $working++ }
                else { $failed++ }
                $resp.Close()
            } catch {
                $failed++
                Write-Host "  FAIL: $($img.id) - $($img.url)" -ForegroundColor Red
            }
        }
        Write-Host "Kết quả: $working working, $failed failed (trong 10 ảnh)"
    }
}
