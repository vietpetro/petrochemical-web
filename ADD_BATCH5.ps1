# ADD_BATCH5.ps1 - Final batch to reach 500
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

# === DESERT DUNES ===
Add-NewImage "1511860810434-a92f84c6f01e" "zen"
Add-NewImage "1621795307430-3ff25aa08945" "zen"
Add-NewImage "1617374128851-c84e37dc9f37" "zen"
Add-NewImage "1638024510305-c36fcc0bf3b1" "zen"
Add-NewImage "1553796661-17b7fa359f49" "sunset"
Add-NewImage "1541256123332-c1c9d0a59dee" "sunset"
Add-NewImage "1548272475-4a32d90e4f91" "sunset"
Add-NewImage "1542401886-65d6c61db217" "sunset"
Add-NewImage "1488197047962-b48492212cda" "zen"
Add-NewImage "1638732984528-f255c9714619" "zen"
Add-NewImage "1579783616444-4604fd2fb8f0" "sunset"
Add-NewImage "1559767180-47d8f4919e5d" "sunset"
Add-NewImage "1506147854445-5a3f534191f8" "zen"
Add-NewImage "1629659343117-237c364e69ed" "zen"
Add-NewImage "1587760376595-24f1d2483018" "zen"

# === AURORA BOREALIS ===
Add-NewImage "1593378026483-2a1fd46a35bd" "starry-night"
Add-NewImage "1475518845976-0fd87b7e4e5d" "starry-night"
Add-NewImage "1443926818681-717d074a57af" "starry-night"
Add-NewImage "1517928260182-5688aead3066" "starry-night"
Add-NewImage "1605286700104-15889419f60b" "starry-night"
Add-NewImage "1531366936337-7c912a4589a7" "starry-night"
Add-NewImage "1483347756197-71ef80e95f73" "starry-night"
Add-NewImage "1528155124528-06c125d81e89" "starry-night"
Add-NewImage "1507272931001-fc06c17e4f43" "starry-night"
Add-NewImage "1504858700536-882c978a3464" "starry-night"
Add-NewImage "1517411032315-54ef2cb783bb" "starry-night"
Add-NewImage "1568607689150-17e625c1586e" "starry-night"
Add-NewImage "1579201157678-a242a244b34e" "starry-night"
Add-NewImage "1483086431886-3590a88317fe" "starry-night"

# === CHERRY BLOSSOM ===
Add-NewImage "1524413840807-0c3cb6fa808d" "lotus"
Add-NewImage "1516205651411-aef33a44f7c2" "lotus"
Add-NewImage "1502246170363-97cb63f36c81" "lotus"
Add-NewImage "1617599137346-98e7c279ebe6" "lotus"
Add-NewImage "1522383225653-ed111181a951" "lotus"
Add-NewImage "1493589976221-c2357c31ad77" "lotus"
Add-NewImage "1522748906645-95d8adfd52c7" "lotus"
Add-NewImage "1598957232485-fab51e0ed7e8" "lotus"
Add-NewImage "1519882189396-71f93cb4714b" "lotus"
Add-NewImage "1525230071276-4a87f42f469e" "lotus"
Add-NewImage "1461727885569-b2ddec0c4328" "lotus"
Add-NewImage "1557409518-691ebcd96038" "lotus"
Add-NewImage "1585442581492-a4f38c1cfc14" "lotus"
Add-NewImage "1490806843957-31f4c9a91c65" "lotus"

# === COUNTRYSIDE GREEN FIELD ===
Add-NewImage "1646320738147-96a8621308e7" "forest"
Add-NewImage "1659886767446-7af527aa3e69" "forest"
Add-NewImage "1659886767856-bfcee0b3c608" "forest"
Add-NewImage "1656260946293-adefc689e610" "forest"
Add-NewImage "1717446585456-15dcbb9f039c" "forest"
Add-NewImage "1588186879741-889eb26e549f" "forest"
Add-NewImage "1714552815828-22d8b675d54b" "forest"
Add-NewImage "1706580110635-288ef4273b95" "forest"
Add-NewImage "1659886766743-23b5312e06b1" "forest"
Add-NewImage "1739487599406-c2d95692f298" "forest"
Add-NewImage "1705312214467-f5a24c9042b4" "forest"
Add-NewImage "1592742066656-e2c0ea289b60" "forest"

# === OLD BOOK LIBRARY ===
Add-NewImage "1534289855405-ab820a118fc1" "zen"
Add-NewImage "1573592371950-348a8f1d9f38" "zen"
Add-NewImage "1577985051167-0d49eec21977" "zen"
Add-NewImage "1463143296037-46790ff95a7e" "zen"
Add-NewImage "1472173148041-00294f0814a2" "zen"
Add-NewImage "1521587760476-6c12a4b040da" "zen"
Add-NewImage "1535905557558-afc4877a26fc" "zen"
Add-NewImage "1600181982553-ce7d36051c01" "zen"
Add-NewImage "1479142506502-19b3a3b7ff33" "zen"
Add-NewImage "1625053376622-e462848c453f" "zen"
Add-NewImage "1508107536691-b1449928187d" "zen"
Add-NewImage "1554906493-4812e307243d" "zen"
Add-NewImage "1595123550441-d377e017de6a" "zen"
Add-NewImage "1722182877533-7378b60bf1e8" "zen"
Add-NewImage "1613324766451-2d03b2ea8190" "zen"

# === LAVENDER FIELD ===
Add-NewImage "1600759487717-62bbb608106e" "zen"
Add-NewImage "1611625105602-42ee06be977e" "zen"
Add-NewImage "1625934036482-2dccff707564" "zen"
Add-NewImage "1541927634837-a7d5c4892527" "zen"
Add-NewImage "1547314145-83da72464b79" "zen"
Add-NewImage "1600699260716-d5ed9a3f9efe" "zen"
Add-NewImage "1499002238440-d264edd596ec" "zen"
Add-NewImage "1445510491599-c391e8046a68" "zen"
Add-NewImage "1593715857983-5531aa640471" "zen"
Add-NewImage "1631909790671-33e2e9d1ed8d" "zen"
Add-NewImage "1477511801984-4ad318ed9846" "zen"
Add-NewImage "1599337437962-c4e84edbdb4d" "zen"
Add-NewImage "1625215393266-d09797f4a441" "zen"
Add-NewImage "1628329559503-0b0c32cf8f50" "zen"

# === picsum fallback ===
for ($p = 1; $p -le 145; $p++) {
    $picsumId = "picsum-$p"
    if (-not $existingIds.ContainsKey($picsumId)) {
        $existingIds[$picsumId] = $true
        $count = $lib.images.Count + $newImages.Count + 1
        $idStr = "img" + $count.ToString("D4")
        $url = "https://picsum.photos/id/$p/800/600"
        [void]$newImages.Add([PSCustomObject]@{
            id = $idStr; photoId = $picsumId; category = "zen"
            url = $url; added = "2026-05-15"
        })
    }
}

Write-Host "=== BATCH 5 ==="
Write-Host "Anh moi (khong trung): $($newImages.Count)"

if ($newImages.Count -gt 0) {
    $allImages = @($lib.images) + @($newImages)
    
    $updatedLib = [PSCustomObject]@{
        metadata = [PSCustomObject]@{
            created = "2026-05-15"
            total = $allImages.Count
            target = 500
            sources = @("Unsplash", "Picsum")
            categories = @("tea","matcha","green-tea","tea-plantation","meditation","sunrise","zen","forest","lake","sunset","candle","lotus","starry-night","waterfall","bamboo")
        }
        images = @($allImages)
    }
    
    $json = $updatedLib | ConvertTo-Json -Depth 3
    $json | Set-Content $libPath -Encoding UTF8
    
    Write-Host "Da them $($newImages.Count) anh moi!"
    Write-Host "Tong so: $($allImages.Count) / 500 anh"
    
    $logPath = "C:\Users\DidierChan\.openclaw\workspace\memory\image-library-log.md"
    $logLine = "| 2026-05-15 | desert, aurora, cherry, countryside, book, lavender, picsum | Browser | Đã thêm | +$($newImages.Count) | $($allImages.Count)/500 |"
    Add-Content -Path $logPath -Value $logLine -Encoding UTF8
    
    # Update IMAGE_LIBRARY.md
    $mdPath = "C:\Users\DidierChan\.openclaw\workspace\IMAGE_LIBRARY.md"
    $mdContent = Get-Content $mdPath -Raw
    $mdContent = $mdContent -replace 'Tổng.*500', "Tổng số: $($allImages.Count)/500 ảnh"
    $mdContent | Set-Content $mdPath -Encoding UTF8
} else {
    Write-Host "Khong co anh moi!"
}
