# ADD_BATCH4.ps1
$libPath = "C:\Users\DidierChan\.openclaw\workspace\IMAGE_LIBRARY.json"
$libContent = Get-Content $libPath -Raw -Encoding UTF8
$lib = $libContent | ConvertFrom-Json

$existingIds = @{}
foreach ($img in $lib.images) { $existingIds[$img.photoId] = $true }

$newImages = New-Object System.Collections.ArrayList

function Add-NewImage($photoId, $category) {
    if (-not $existingIds.ContainsKey($photoId) -and $photoId.Length -ge 11 -and $photoId.Length -le 25) {
        $existingIds[$photoId] = $true
        $count = $lib.images.Count + $newImages.Count + 1
        $idStr = "img" + $count.ToString("D4")
        $url = "https://images.unsplash.com/photo-$photoId`?w=800"
        [void]$newImages.Add([PSCustomObject]@{
            id = $idStr; photoId = $photoId; category = $category
            url = $url; added = "2026-05-15"
        })
    }
}

# === CLOUDY MOUNTAIN ===
Add-NewImage "1509625409161-38f93149c7b7" "sunrise"
Add-NewImage "1610442220171-47346dffd2d8" "sunrise"
Add-NewImage "1705448082121-dd6888a685d4" "sunrise"
Add-NewImage "1486707471592-8e7eb7e36f78" "sunrise"
Add-NewImage "1577230789540-8e0f8435dc08" "lake"
Add-NewImage "1661167490531-d035e4c9345d" "sunrise"
Add-NewImage "1530814475243-8163d9d8bf41" "sunrise"
Add-NewImage "1573411765728-9e4b9073e2c5" "sunrise"
Add-NewImage "1620299813821-01fc99b67409" "sunrise"
Add-NewImage "1631719211985-573b6cef7679" "meditation"
Add-NewImage "1444580442178-56153ed65706" "meditation"
Add-NewImage "1530814394340-02d8010713d8" "sunrise"
Add-NewImage "1613508788423-c15176f2f964" "sunrise"
Add-NewImage "1501446690852-da55df7bfe07" "meditation"
Add-NewImage "1543274511-6db17d19cb2c" "sunrise"

# === CALM SEA WAVE ===
Add-NewImage "1538248814128-02e1bd877c01" "lake"
Add-NewImage "1562972905-25fccd40dcc2" "lake"
Add-NewImage "1441829266145-6d4bfbd38eb4" "lake"
Add-NewImage "1568571022375-ad4f3ef34972" "lake"
Add-NewImage "1468581264429-2548ef9eb732" "lake"
Add-NewImage "1498813295229-27bd6c349cc8" "lake"
Add-NewImage "1560260240-c6ef90a163a4" "lake"
Add-NewImage "1461503312594-019be44dd599" "lake"
Add-NewImage "1518837695005-2083093ee35b" "lake"
Add-NewImage "1614723267704-86f4122a43ad" "lake"
Add-NewImage "1523167105243-c09dd058af08" "lake"
Add-NewImage "1666692266862-d336f746d46d" "lake"
Add-NewImage "1615472768508-9db82090f4c6" "lake"
Add-NewImage "1545733099-152483684cb5" "lake"
Add-NewImage "1707489636403-c539c2cdc101" "lake"

# === SUNBEAM FOREST ===
Add-NewImage "1674244988698-0bfc39dad0d0" "forest"
Add-NewImage "1593848814511-c15e9ae11265" "forest"
Add-NewImage "1659382134993-9f574f6363fb" "forest"
Add-NewImage "1615369631167-6ce2eef15889" "forest"
Add-NewImage "1665073526612-a2c3d7faddca" "forest"
Add-NewImage "1679176035370-039bff74ea5b" "forest"
Add-NewImage "1657210439292-cedbdd74d43f" "forest"
Add-NewImage "1597167030996-73087be318b7" "forest"
Add-NewImage "1611530866681-61929483ad62" "forest"
Add-NewImage "1682904554147-bd3e8b6827f1" "forest"
Add-NewImage "1595892361444-c0ec6a62b0ec" "forest"
Add-NewImage "1611530866748-b7518e1f431a" "forest"
Add-NewImage "1643744471020-ca1c979bc692" "forest"
Add-NewImage "1679176035372-9b8c95132493" "forest"
Add-NewImage "1679176035290-06904a8adf2d" "forest"

# === WINTER SNOW ===
Add-NewImage "1483043012503-8a8849b4c949" "zen"
Add-NewImage "1611331023516-6ec931575ecc" "zen"
Add-NewImage "1611386631747-567f084347aa" "zen"
Add-NewImage "1711137483289-f5eb1e295a9a" "zen"
Add-NewImage "1549057255-854cb1b9e71c" "zen"
Add-NewImage "1547576962-9f4ee7e7a7c1" "zen"
Add-NewImage "1596513010486-e3b472d162ed" "zen"
Add-NewImage "1674378682490-55df8218ee27" "zen"
Add-NewImage "1546587433-03af044f8065" "meditation"
Add-NewImage "1734939552965-2ae244c5d15b" "zen"
Add-NewImage "1700588254424-341f5f0e466f" "zen"
Add-NewImage "1613392720953-19002a0f661a" "zen"
Add-NewImage "1610727005021-f30e7f33ff7f" "zen"
Add-NewImage "1647192893809-87a27480f701" "zen"

# === MORNING FOG RIVER ===
Add-NewImage "1524435497396-7bc897fa8d97" "lake"
Add-NewImage "1699801352983-c61ce6259f6b" "lake"
Add-NewImage "1696340871286-55e1616f78af" "lake"
Add-NewImage "1560996025-95b43d543770" "lake"
Add-NewImage "1528184039930-bd03972bd974" "lake"
Add-NewImage "1630077206464-542623667156" "lake"
Add-NewImage "1702441652314-43efae929d44" "lake"
Add-NewImage "1581236799689-6e41b34383c6" "lake"
Add-NewImage "1659276800100-1a14e4e27579" "lake"
Add-NewImage "1666873015737-0f5170b8a059" "lake"
Add-NewImage "1635853500159-f7bb17eea508" "lake"
Add-NewImage "1663051109655-d187b0ce9c1f" "lake"

# === DRY TEA LEAVES ===
Add-NewImage "1604697976842-d36fa5a1b2ed" "tea"
Add-NewImage "1628153792464-21bffac488d4" "tea"
Add-NewImage "1627894006066-b45786537103" "tea"
Add-NewImage "1625715490354-9a37e8298bf7" "tea"
Add-NewImage "1606163017137-888c0177b3dd" "tea"
Add-NewImage "1543060895-03f57478a710" "tea"
Add-NewImage "1607655892518-265705ba1f1f" "tea"
Add-NewImage "1656160234511-1d7e438cefd9" "tea"

# === PAGODA TEMPLE ===
Add-NewImage "1560577458-a86c451add31" "zen"
Add-NewImage "1585772357329-a89547291250" "zen"
Add-NewImage "1618165220283-e85246c4171c" "zen"
Add-NewImage "1721528311146-71e9523221a0" "zen"
Add-NewImage "1570514504127-b1cabc8c904f" "zen"
Add-NewImage "1677607220717-20d71984a207" "zen"
Add-NewImage "1609168959134-9914b77bd890" "zen"
Add-NewImage "1560577462-d2b473539953" "zen"
Add-NewImage "1707029531152-d7bc56e729a9" "zen"
Add-NewImage "1570572273532-54174fe48a56" "zen"
Add-NewImage "1618165200720-c6ba3138e5c9" "zen"
Add-NewImage "1625572765703-293579a3bec4" "zen"

Write-Host "=== BATCH 4 ==="
Write-Host "Anh moi (khong trung): $($newImages.Count)"

if ($newImages.Count -gt 0) {
    $allImages = @($lib.images) + @($newImages)
    
    $updatedLib = [PSCustomObject]@{
        metadata = [PSCustomObject]@{
            created = "2026-05-15"
            total = $allImages.Count
            target = 500
            sources = @("Unsplash")
            categories = @("tea","matcha","green-tea","tea-plantation","meditation","sunrise","zen","forest","lake","sunset","candle","lotus","starry-night","waterfall","bamboo")
        }
        images = @($allImages)
    }
    
    $json = $updatedLib | ConvertTo-Json -Depth 3
    $json | Set-Content $libPath -Encoding UTF8
    
    Write-Host "Da them $($newImages.Count) anh moi!"
    Write-Host "Tong so: $($allImages.Count) / 500 anh"
    Write-Host "Con thieu: $(500 - $allImages.Count) anh"
    
    $logPath = "C:\Users\DidierChan\.openclaw\workspace\memory\image-library-log.md"
    $logLine = "| 2026-05-15 | cloudy, sea-wave, sunbeam, snow, fog, tea-leaves, pagoda | Browser | Đã thêm | +$($newImages.Count) | $($allImages.Count)/500 |"
    Add-Content -Path $logPath -Value $logLine -Encoding UTF8
} else {
    Write-Host "Khong co anh moi!"
}
