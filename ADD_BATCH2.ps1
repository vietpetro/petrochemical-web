# ADD_BATCH2.ps1 - Add new images from Batch 2 crawl
$libPath = "C:\Users\DidierChan\.openclaw\workspace\IMAGE_LIBRARY.json"
$libContent = Get-Content $libPath -Raw -Encoding UTF8
$lib = $libContent | ConvertFrom-Json

# Get existing photoIds for dedup
$existingIds = @{}
foreach ($img in $lib.images) { $existingIds[$img.photoId] = $true }

$newImages = New-Object System.Collections.ArrayList

function Add-NewImage($photoId, $category) {
    if (-not $existingIds.ContainsKey($photoId)) {
        $existingIds[$photoId] = $true
        $count = $lib.images.Count + $newImages.Count + 1
        $idStr = "img" + $count.ToString("D4")
        $url = "https://images.unsplash.com/photo-$photoId`?w=800"
        $obj = [PSCustomObject]@{
            id = $idStr
            photoId = $photoId
            category = $category
            url = $url
            added = "2026-05-15"
        }
        [void]$newImages.Add($obj)
    }
}

# === BATCH 2: TEA-CUP ===
Add-NewImage "1555447014-7ead71574544" "tea"
Add-NewImage "1615486780246-76e6bb33e8b5" "tea"
Add-NewImage "1610478506025-8110cc8f1986" "tea"
Add-NewImage "1595434091143-b375ced5fe5c" "tea"
Add-NewImage "1560228022-f1a3298022e9" "tea"
Add-NewImage "1518881922778-bacb4debc3d7" "tea"
Add-NewImage "1458819714733-e5ab3d536722" "tea"
Add-NewImage "1491720731493-223f97d92c21" "tea"
Add-NewImage "1514228742587-6b1558fcca3d" "tea"
Add-NewImage "1577968897966-3d4325b36b61" "tea"
Add-NewImage "1615484477112-677decb29c57" "tea"
Add-NewImage "1498604636225-6b87a314baa0" "tea"

# === JAPANESE TEA ===
Add-NewImage "1577016029703-cc22a7c0c28c" "tea"
Add-NewImage "1565080636132-56952ee2861c" "tea"
Add-NewImage "1601831753677-01f960be19eb" "tea"
Add-NewImage "1585157603875-17aacca6182a" "tea"
Add-NewImage "1617191880520-c6a69e04fa75" "tea"
Add-NewImage "1531876066433-09d3a1f79fac" "tea"
Add-NewImage "1609016617751-e80552ae6ec2" "tea"
Add-NewImage "1544451822-38e32b887c08" "tea"

# === ZEN GARDEN ===
Add-NewImage "1567372704182-ec2ea042c937" "zen"
Add-NewImage "1432958576632-8a39f6b97dc7" "zen"
Add-NewImage "1723242017109-64ac2ad3babf" "zen"
Add-NewImage "1721943351594-179ded3c4ebb" "zen"
Add-NewImage "1619441207978-3d326c46e2c9" "zen"
Add-NewImage "1556010656-e60700d4c0d5" "zen"
Add-NewImage "1566940564578-309d64952258" "zen"
Add-NewImage "1537154259951-00da64098b37" "zen"
Add-NewImage "1672758688257-a110c93de407" "zen"
Add-NewImage "1490713575234-cbe010982904" "zen"

# === INCENSE MEDITATION ===
Add-NewImage "1541795083-1b160cf4f3d7" "meditation"
Add-NewImage "1640775670963-7d5d67de6bcc" "meditation"
Add-NewImage "1628709353367-35f0bb07413d" "meditation"
Add-NewImage "1617954095840-0427f79be4cf" "meditation"
Add-NewImage "1424177558417-016f30ac3059" "meditation"
Add-NewImage "1531933046417-48eda63717b9" "meditation"
Add-NewImage "1639390167093-9c62311fe84d" "meditation"
Add-NewImage "1551690935-a9e6f0a7e788" "meditation"
Add-NewImage "1626937526107-ca0be0eecccd" "meditation"
Add-NewImage "1627809381019-976c0d1adc98" "meditation"
Add-NewImage "1715070990039-c6ef0ad6c2c2" "meditation"
Add-NewImage "1586875401592-64f1d5cb43e4" "meditation"
Add-NewImage "1627769792188-d3f9f59833e5" "meditation"
Add-NewImage "1613750255797-7d4f877615df" "meditation"
Add-NewImage "1509726360306-3f44543aea4c" "meditation"

# === AUTUMN LEAVES ===
Add-NewImage "1543683840-c66117bdb1f8" "forest"
Add-NewImage "1513986615308-8f59cc8a16e1" "forest"
Add-NewImage "1477414348463-c0eb7f1359b6" "forest"
Add-NewImage "1476458393436-fb857cc4c7b5" "forest"
Add-NewImage "1478733672327-ce27bc999503" "forest"
Add-NewImage "1429198739803-7db875882052" "forest"
Add-NewImage "1506193503569-d57d2a678510" "forest"
Add-NewImage "1501973801540-537f08ccae7b" "forest"
Add-NewImage "1637162330294-28cc8540d41d" "forest"
Add-NewImage "1535608577102-bb54e62fe045" "forest"
Add-NewImage "1453959022778-cfda85dbe0f9" "forest"
Add-NewImage "1573776396359-5576727fa835" "forest"
Add-NewImage "1635612316999-4621560634be" "forest"
Add-NewImage "1507967669805-c23336beea5b" "forest"
Add-NewImage "1605246811037-7a815fa646e4" "forest"

# === RAIN WINDOW COZY ===
Add-NewImage "1515694346937-94d85e41e6f0" "zen"
Add-NewImage "1501297875943-27f3803b4956" "zen"
Add-NewImage "1629108406619-3b46f5877750" "zen"
Add-NewImage "1631816591249-ba33dde81a23" "zen"
Add-NewImage "1509635022432-0220ac12960b" "zen"
Add-NewImage "1632900182533-c8ee9ba229f4" "zen"
Add-NewImage "1470432581262-e7880e8fe79a" "zen"
Add-NewImage "1594516150843-b2a82ece1035" "zen"
Add-NewImage "1587736891536-beb1e48bb22b" "zen"
Add-NewImage "1543251698-10f13f004b0f" "zen"
Add-NewImage "1528402520525-05f8b9608a6c" "zen"
Add-NewImage "1501186758051-167ca3c0fde8" "zen"
Add-NewImage "1511634829096-045a111727eb" "zen"
Add-NewImage "1597931188156-d08a28137637" "zen"
Add-NewImage "1611738740585-3598e06e0f8c" "zen"

# === BEACH SUNSET ===
Add-NewImage "1626951876321-3b7137628f83" "sunset"
Add-NewImage "1578349198494-f76d9dcac32a" "sunset"
Add-NewImage "1624365700883-cc574778eff5" "sunset"
Add-NewImage "1494459940152-1e911caa8cc5" "sunset"
Add-NewImage "1545327229-a4b759c9d448" "sunset"
Add-NewImage "1564867430521-0d3a5b56dd43" "sunset"
Add-NewImage "1535338611490-9926ac7e0eaf" "sunset"
Add-NewImage "1514890084135-f16d926f4d03" "sunset"

# === MOON NIGHT SKY ===
Add-NewImage "1614989799749-6c1e704dca56" "starry-night"
Add-NewImage "1669764721666-915960e73e0d" "starry-night"
Add-NewImage "1627277291166-a9e873004023" "starry-night"
Add-NewImage "1507499739999-097706ad8914" "starry-night"
Add-NewImage "1507502707541-f369a3b18502" "starry-night"
Add-NewImage "1581886573745-4487c55d95f8" "starry-night"
Add-NewImage "1590005510163-dec35d52ddcd" "starry-night"
Add-NewImage "1647941953367-6ff24a0e5857" "starry-night"
Add-NewImage "1620055374842-145f66ec4652" "starry-night"
Add-NewImage "1693418777220-e94f65d4cd4d" "starry-night"
Add-NewImage "1568570098538-f38bf89c3339" "starry-night"
Add-NewImage "1720731375441-80fa2aa8e87b" "starry-night"
Add-NewImage "1678381569197-e80aef5157d0" "starry-night"
Add-NewImage "1605776502818-8d2103f63a25" "starry-night"
Add-NewImage "1609324911767-16456f5c8dbf" "starry-night"

Write-Host "=== BATCH 2: THEM ANH MOI ==="
Write-Host "Tong so anh moi (khong trung): $($newImages.Count)"

if ($newImages.Count -gt 0) {
    # Combine existing + new
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
    
    Write-Host "Da them $($newImages.Count) anh moi vao thu vien!"
    Write-Host "Tong so: $($allImages.Count) / 500 anh"
    Write-Host ""
    
    # Update log
    $logLine = "| 2026-05-15 | tea-cup, japanese-tea, zen-garden, incense, autumn, rain, sunset, moon-night | Unsplash | Đã thêm | +$($newImages.Count) |"
    $logPath = "C:\Users\DidierChan\.openclaw\workspace\memory\image-library-log.md"
    Add-Content -Path $logPath -Value $logLine -Encoding UTF8
} else {
    Write-Host "Khong co anh moi (tat ca da ton tai)"
}
