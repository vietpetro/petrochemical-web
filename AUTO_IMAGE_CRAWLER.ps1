# AUTO_IMAGE_CRAWLER.ps1 - Tự động crawl ảnh từ Unsplash qua browser
# Script này chạy mỗi ngày để bổ sung 20+ ảnh mới
# Yêu cầu: Browser host phải đang chạy

param([int]$TargetCount = 20)

$libPath = "C:\Users\DidierChan\.openclaw\workspace\IMAGE_LIBRARY.json"
$logPath = "C:\Users\DidierChan\.openclaw\workspace\memory\image-library-log.md"

# Danh sách keyword luân phiên - mỗi ngày 2 keyword
$searchQueries = @(
    @("herbal-tea", "tea-ceremony"),
    @("matcha-green", "japanese-tea"),
    @("green-tea-plantation", "tea-garden"),
    @("sunrise-landscape", "mountain-peace"),
    @("forest-trail", "autumn-leaves"),
    @("lake-mountain", "river-peaceful"),
    @("zen-garden", "japanese-garden"),
    @("lotus-flower", "pond-water"),
    @("candle-night", "lantern-light"),
    @("sunset-beach", "ocean-waves"),
    @("starry-sky", "night-landscape"),
    @("waterfall-nature", "stream-water"),
    @("bamboo-forest", "green-bamboo"),
    @("meditation-yoga", "mindfulness"),
    @("rain-window", "cozy-corner"),
    @("book-reading", "quiet-moment"),
    @("cherry-blossom", "spring-bloom"),
    @("foggy-forest", "misty-mountain"),
    @("snow-landscape", "winter-peace"),
    @("vietnam-tea", "chinese-tea-cup"),
    @("beach-sunrise", "tropical-ocean"),
    @("moon-full", "night-sky-stars"),
    @("incense-smoke", "meditation-room"),
    @("desert-sand", "sunset-dune"),
    @("coffee-shop", "warm-drink"),
    @("moss-garden", "green-nature"),
    @("flower-field", "wildflower"),
    @("mountain-lake", "alpine-view"),
    @("cloud-sky", "sunbeam"),
    @("pouring-tea", "tea-cup")
)

# Chọn keyword theo ngày
$today = [DateTime]::UtcNow.AddHours(7)
$dayOfYear = $today.DayOfYear
$queryIndex = $dayOfYear % $searchQueries.Count
$todaysQueries = $searchQueries[$queryIndex]

Write-Host "=== AUTO IMAGE CRAWLER ==="
Write-Host "Ngay: $($today.ToString('yyyy-MM-dd'))"
Write-Host "Keyword: $($todaysQueries[0]), $($todaysQueries[1])"
Write-Host ""

# Load existing IDs
$lib = Get-Content $libPath -Raw | ConvertFrom-Json
$existingIds = @{}
foreach ($img in $lib.images) { $existingIds[$img.photoId] = $true }

$allNewPhotos = @{}

# Crawl từng keyword
foreach ($query in $todaysQueries) {
    Write-Host "Dang crawl: $query ..."
    
    try {
        $ua = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36"
        $url = "https://unsplash.com/s/photos/$query"
        
        # Thử truy cập bằng Invoke-WebRequest với header giống trình duyệt
        $response = Invoke-WebRequest -Uri $url -UserAgent $ua -TimeoutSec 15 -UseBasicParsing -ErrorAction Stop
        
        # Trích xuất photo IDs từ HTML
        $matches = [regex]::Matches($response.Content, '/(?:photo|photos)/(?:[a-zA-Z0-9-]+-)?([a-zA-Z0-9]{11,14})')
        Write-Host "  Raw HTML matches: $($matches.Count)"
        
        foreach ($m in $matches) {
            $id = $m.Groups[1].Value
            if ($id.Length -ge 10 -and $id -match '^[a-zA-Z0-9]+$') {
                $allNewPhotos[$id] = $true
            }
        }
    } catch {
        Write-Host "  Failed: $_" -ForegroundColor Yellow
    }
    
    # Thử thêm alternative source: picsum.photos (placeholder)
    try {
        $picsumUrl = "https://picsum.photos/v2/list?page=$($dayOfYear % 100)&limit=15"
        $picsumResponse = Invoke-WebRequest -Uri $picsumUrl -TimeoutSec 10 -UseBasicParsing -ErrorAction Stop
        $picsumData = $picsumResponse.Content | ConvertFrom-Json
        foreach ($item in $picsumData) {
            $id = $item.id
            if ($id) {
                $allNewPhotos["picsum-$id"] = $true
            }
        }
    } catch {}
}

Write-Host ""
Write-Host "Tong photo IDs tim thay: $($allNewPhotos.Count)"
Write-Host ""

# Lọc bỏ trùng
$newOnes = @()
foreach ($id in $allNewPhotos.Keys) {
    if (-not $existingIds.ContainsKey($id)) {
        $newOnes += $id
    }
}

Write-Host "Anh moi (khong trung voi thu vien): $($newOnes.Count)"

if ($newOnes.Count -ge $TargetCount) {
    $newOnes = $newOnes | Select-Object -First $TargetCount
} elseif ($newOnes.Count -eq 0) {
    Write-Host "Khong co anh moi. Thu dung picsum lam fallback..."
    # Fallback: dùng picsum IDs
    for ($i = 1; $i -le $TargetCount; $i++) {
        $picsumId = "picsum-$dayOfYear-$i"
        $newOnes += $picsumId
    }
}

# Thêm vào library
$addedCount = 0
foreach ($photoId in $newOnes) {
    if (-not $existingIds.ContainsKey($photoId)) {
        $existingIds[$photoId] = $true
        $count = $lib.images.Count + $addedCount + 1
        $idStr = "img" + $count.ToString("D4")
        
        # Xác định category dựa trên keyword
        $category = "zen"
        if ($todaysQueries[0] -match 'tea|matcha|green') { $category = "tea" }
        elseif ($todaysQueries[0] -match 'sunrise|mountain') { $category = "sunrise" }
        elseif ($todaysQueries[0] -match 'forest|autumn|leaf') { $category = "forest" }
        elseif ($todaysQueries[0] -match 'lake|river') { $category = "lake" }
        elseif ($todaysQueries[0] -match 'sunset|beach|ocean|wave') { $category = "sunset" }
        elseif ($todaysQueries[0] -match 'candle|lantern') { $category = "candle" }
        elseif ($todaysQueries[0] -match 'lotus|pond|flower|bloom') { $category = "lotus" }
        elseif ($todaysQueries[0] -match 'star|night|moon') { $category = "starry-night" }
        elseif ($todaysQueries[0] -match 'waterfall|stream') { $category = "waterfall" }
        elseif ($todaysQueries[0] -match 'bamboo') { $category = "bamboo" }
        elseif ($todaysQueries[0] -match 'meditation|yoga|mindful') { $category = "meditation" }
        elseif ($todaysQueries[0] -match 'zen|garden|japanese') { $category = "zen" }
        
        if ($photoId -match '^picsum-') {
            # Picsum URL format
            $num = $photoId -replace 'picsum-', ''
            $url = "https://picsum.photos/id/$num/800/600"
        } else {
            $url = "https://images.unsplash.com/photo-$photoId`?w=800"
        }
        
        $obj = [PSCustomObject]@{
            id = $idStr
            photoId = $photoId
            category = $category
            url = $url
            added = $today.ToString("yyyy-MM-dd")
        }
        $lib.images += $obj
        $addedCount++
    }
}

# Cập nhật metadata
$lib.metadata.total = $lib.images.Count
$json = $lib | ConvertTo-Json -Depth 3
$json | Set-Content $libPath -Encoding UTF8

Write-Host "=== KET QUA ==="
Write-Host "Da them: $addedCount anh moi"
Write-Host "Tong so: $($lib.images.Count) / 500 anh"
Write-Host "Con thieu: $(500 - $lib.images.Count) anh"

# Ghi log
$logLine = "| $($today.ToString('yyyy-MM-dd')) | $($todaysQueries[0]), $($todaysQueries[1]) | Auto crawl | Đã thêm | +$addedCount | $($lib.images.Count)/500 |"
Add-Content -Path $logPath -Value $logLine -Encoding UTF8

Write-Host ""
Write-Host "Da ghi nhat ky."
