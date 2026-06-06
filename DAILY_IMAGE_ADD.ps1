# DAILY_IMAGE_ADD.ps1 - Script bổ sung 20 ảnh mới mỗi ngày
# Chạy qua cron job hằng ngày
# Usage: powershell -File DAILY_IMAGE_ADD.ps1

$libPath = "C:\Users\DidierChan\.openclaw\workspace\IMAGE_LIBRARY.json"
$newImages = @()

# === DANH SÁCH KEYWORD LUÂN PHIÊN THEO NGÀY ===
# Mỗi ngày crawl 1-2 chủ đề khác nhau để đa dạng hóa
$searchQueries = @(
    @("tea-cup","tea-ceremony"),
    @("japanese-tea","chinese-tea"),
    @("herbal-tea","tea-leaves"),
    @("sunrise-landscape","mountain-view"),
    @("forest-path","autumn-nature"),
    @("lake-water","river-peaceful"),
    @("zen-garden","buddha-statue"),
    @("lotus-pond","flower-garden"),
    @("candle-light","lantern",
    @("sunset-ocean","beach-waves"),
    @("star-sky","night-sky"),
    @("waterfall-nature","stream-water"),
    @("bamboo-forest","green-nature"),
    @("meditation-yoga","mindfulness"),
    @("matcha-latte","green-drink"),
    @("morning-coffee","breakfast-tea"),
    @("rainy-window","cozy-corner"),
    @("book-tea","reading-coffee"),
    @("cherry-blossom","spring-flower"),
    @("fog-mountain","cloud-sky"),
    @("autumn-leaves","fall-nature"),
    @("snow-mountain","winter-peace"),
    @("desert-sunset","sand-dunes"),
    @("tropical-beach","ocean-sunset"),
    @("moon-night","full-moon"),
    @("incense","meditation-room"),
    @("yoga-beach","sun-salutation"),
    @("green-field","wheat-field"),
    @("vietnam-tea","asian-tea"),
    @("forest-sunlight","light-trees")
)

# Chọn chủ đề dựa trên ngày
$today = [DateTime]::UtcNow.AddHours(7)
$dayOfYear = $today.DayOfYear
$queryIndex = $dayOfYear % $searchQueries.Count
$todaysQueries = $searchQueries[$queryIndex]

Write-Host "=== BỔ SUNG 20 ẢNH MỚI ==="
Write-Host "Ngày: $($today.ToString('yyyy-MM-dd'))"
Write-Host "Chủ đề: $($todaysQueries -join ', ')"

Write-Host "`n=== CẦN THỰC HIỆN THỦ CÔNG ==="
Write-Host "Trình duyệt cần được mở để crawl ảnh từ Unsplash."
Write-Host "Vui lòng chạy lệnh sau trong browser:"
Write-Host ""
Write-Host "Bước 1: Mở browser đến từng URL sau và extract photo IDs:"
foreach ($q in $todaysQueries) {
    Write-Host "  https://unsplash.com/s/photos/$q"
}
Write-Host ""
Write-Host "Bước 2: Dùng browser tool snapshot → evaluate script để lấy photo IDs"
Write-Host "Bước 3: Thêm thủ công vào IMAGE_LIBRARY.json"
Write-Host ""

# Ghi nhật ký
$logFile = "C:\Users\DidierChan\.openclaw\workspace\memory\image-library-log.md"
$logEntry = "| $($today.ToString('yyyy-MM-dd')) | $($todaysQueries[0]), $($todaysQueries[1]) | Đang chờ crawl |"
Add-Content -Path $logFile -Value $logEntry -Encoding UTF8

Write-Host "Đã ghi nhật ký vào $logFile"
