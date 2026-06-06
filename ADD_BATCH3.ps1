# ADD_BATCH3.ps1 - Add new images from Batch 3 crawl
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

# === HERBAL TEA ===
Add-NewImage "1514733670139-4d87a1941d55" "tea"
Add-NewImage "1615205597144-5c7c885291d2" "tea"
Add-NewImage "1648455321715-e8ed86188c0e" "tea"
Add-NewImage "1504382103100-db7e92322d39" "tea"
Add-NewImage "1563822249548-9a72b6353cd1" "tea"
Add-NewImage "1596344084757-b83f2081da8b" "tea"

# === TEA POT CERAMIC ===
Add-NewImage "1703580004436-446285bf6694" "tea"
Add-NewImage "1531980838447-354c51364546" "tea"
Add-NewImage "1642145239592-a3ad7308726d" "tea"
Add-NewImage "1590507558401-511dc091c09c" "tea"
Add-NewImage "1683558654439-8b9986cbf1dd" "tea"
Add-NewImage "1629440400842-9108c0ccf336" "tea"
Add-NewImage "1629440404898-4a527437484f" "tea"
Add-NewImage "1565101468699-e4fb8b9b8cec" "tea"
Add-NewImage "1656313832937-68971753e96a" "tea"
Add-NewImage "1574948740506-1e6278b50607" "tea"
Add-NewImage "1614808252086-4589b0f83550" "tea"
Add-NewImage "1565550967973-727d4372df7c" "tea"
Add-NewImage "1562996069-90bc7c450c58" "tea"
Add-NewImage "1600126303431-3814a3fd54eb" "tea"

# === OCEAN SUNSET ===
Add-NewImage "1501436513145-30f24e19fcc8" "sunset"
Add-NewImage "1581116972164-b89ed0cdf64f" "sunset"
Add-NewImage "1533371452382-d45a9da51ad9" "sunset"
Add-NewImage "1439405326854-014607f694d7" "sunset"
Add-NewImage "1524107680653-13db74b77f58" "sunset"
Add-NewImage "1563738068154-8d2e9f19ed62" "sunset"
Add-NewImage "1470329508532-be27fda94658" "sunset"
Add-NewImage "1594342436424-dda50df715d9" "sunset"

# === MOUNTAIN LAKE ===
Add-NewImage "1603979649806-5299879db16b" "lake"
Add-NewImage "1473448912268-2022ce9509d8" "lake"
Add-NewImage "1439853949127-fa647821eba0" "lake"
Add-NewImage "1595076590135-e070743b31c5" "lake"
Add-NewImage "1516655855035-d5215bcb5604" "lake"
Add-NewImage "1503614472-8c93d56e92ce" "lake"
Add-NewImage "1600298882438-de4298571be4" "lake"
Add-NewImage "1464852045489-bccb7d17fe39" "lake"
Add-NewImage "1505490096310-204ef067fe6b" "lake"
Add-NewImage "1597655601841-214a4cfe8b2c" "lake"
Add-NewImage "1604440095301-4ec2f9230155" "lake"

# === SPRING FLOWER GARDEN ===
Add-NewImage "1602685869889-663733c93aec" "lotus"
Add-NewImage "1494007485290-ce668e189d92" "lotus"
Add-NewImage "1615820358106-6b112e1f690d" "lotus"
Add-NewImage "1589048400130-2e707d7786a9" "lotus"
Add-NewImage "1709733124970-74927f8a2dc3" "lotus"
Add-NewImage "1712687592729-81efde358ef9" "lotus"
Add-NewImage "1650424367497-e6f70b493167" "lotus"
Add-NewImage "1650424364322-48ce89d2d150" "lotus"
Add-NewImage "1559153938-6e32533c00a0" "lotus"
Add-NewImage "1648992137572-02d9646bbbda" "lotus"
Add-NewImage "1712688922191-b83ecaa59b88" "lotus"
Add-NewImage "1709733125002-c7bd0ad2256b" "lotus"
Add-NewImage "1552350718-03eafd9b774a" "lotus"
Add-NewImage "1559424476-49ee32099623" "lotus"

# === WATERFALL FOREST ===
Add-NewImage "1544519954-6aeb4816f0ab" "waterfall"
Add-NewImage "1597099911706-1f7c9ba6839b" "waterfall"
Add-NewImage "1710812030602-4a3662eb0135" "waterfall"
Add-NewImage "1445287295867-134337e27c2a" "waterfall"
Add-NewImage "1623801006075-d38c11e8646b" "waterfall"
Add-NewImage "1493713838217-28e23b41b798" "waterfall"
Add-NewImage "1667337104810-b846d9293ed4" "waterfall"
Add-NewImage "1656086407297-0779ee11ca2e" "waterfall"
Add-NewImage "1693287528551-b3c3a6b28843" "waterfall"
Add-NewImage "1583912385566-058bb89a4cff" "waterfall"
Add-NewImage "1562053232-1b9ef8cd1f26" "waterfall"
Add-NewImage "1610044847457-f6aabcbb67d3" "waterfall"
Add-NewImage "1556292990-e4f4a36222e5" "waterfall"
Add-NewImage "1623980051061-fce02122f7fe" "waterfall"

# === YOGA MEDITATION BEACH ===
Add-NewImage "1584936964770-7d9a3cd21143" "meditation"
Add-NewImage "1636619297905-54f124aa90b2" "meditation"
Add-NewImage "1646166624936-d93c08117e02" "meditation"
Add-NewImage "1533012562945-b003ce1d3269" "meditation"
Add-NewImage "1584937046815-5ed7abc5a8c9" "meditation"
Add-NewImage "1646166468261-b18339c92fda" "meditation"
Add-NewImage "1545205597-3d9d02c29597" "meditation"
Add-NewImage "1591228127791-8e2eaef098d3" "meditation"
Add-NewImage "1584937005173-c307e769aa24" "meditation"
Add-NewImage "1732107195798-4cb9db201131" "meditation"
Add-NewImage "1646941836303-12a0a6bff9b6" "meditation"
Add-NewImage "1577900289221-a432e08f3af5" "meditation"
Add-NewImage "1647010164502-83632da3e919" "meditation"
Add-NewImage "1579126038374-6064e9370f0f" "meditation"
Add-NewImage "1547852356-a386daab4b26" "meditation"

# === BUDDHA STATUE ===
Add-NewImage "1534104275488-7ba96ed1a2f6" "zen"
Add-NewImage "1642980522015-7b060e307692" "zen"
Add-NewImage "1529485726363-95c8d62f656f" "zen"
Add-NewImage "1589400554239-7c6cf8393a6e" "zen"
Add-NewImage "1629953031870-02be15a295ee" "zen"
Add-NewImage "1513415564515-763d91423bdd" "zen"
Add-NewImage "1544592218-b546f7b9ddb4" "zen"
Add-NewImage "1625888593864-afef418841e7" "zen"
Add-NewImage "1623722583569-1dc4829d48c8" "zen"
Add-NewImage "1550141627-edb66a32a2eb" "zen"
Add-NewImage "1625888593865-1bb1e5352471" "zen"
Add-NewImage "1553285207-a28928d5cc82" "zen"
Add-NewImage "1554020632-57ebe4b1933f" "zen"
Add-NewImage "1537903904737-13fc83b81be0" "zen"
Add-NewImage "1666730140062-786a7b354bc5" "zen"

Write-Host "=== BATCH 3 ==="
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
    $logLine = "| 2026-05-15 | herbal-tea, tea-pot, ocean-sunset, mountain-lake, flower, waterfall, yoga, buddha | Browser | Đã thêm | +$($newImages.Count) | $($allImages.Count)/500 |"
    Add-Content -Path $logPath -Value $logLine -Encoding UTF8
} else {
    Write-Host "Khong co anh moi!"
}
