# TEST_UNSPLASH_ACCESS.ps1 - Test if we can access Unsplash via PowerShell
$ua = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36"
try {
    $response = Invoke-WebRequest -Uri "https://unsplash.com/s/photos/herbal-tea" -UserAgent $ua -TimeoutSec 10 -UseBasicParsing
    if ($response.Content -match 'photo-([a-zA-Z0-9-]+)') {
        Write-Host "Unsplash accessible via PowerShell!"
        $matches = [regex]::Matches($response.Content, 'photo-([a-zA-Z0-9-]{10,50})\?')
        $unique = @{}
        foreach ($m in $matches) {
            $id = $m.Groups[1].Value
            if (-not $id.StartsWith('profile') -and -not $id.StartsWith('fb-') -and -not $id.StartsWith('placeholder')) {
                $unique[$id] = $true
            }
        }
        Write-Host "Found $($unique.Count) photo IDs"
        $libPath = "C:\Users\DidierChan\.openclaw\workspace\IMAGE_LIBRARY.json"
        $lib = Get-Content $libPath -Raw | ConvertFrom-Json
        $existingIds = @{}
        foreach ($img in $lib.images) { $existingIds[$img.photoId] = $true }
        $newPhotos = @()
        foreach ($id in $unique.Keys) {
            if (-not $existingIds.ContainsKey($id)) {
                $newPhotos += $id
            }
        }
        Write-Host "New unique IDs: $($newPhotos.Count)"
        if ($newPhotos.Count -gt 0) {
            $newPhotos | Select-Object -First 5
        }
    } else {
        Write-Host "Connected but no photo pattern found. Content length: $($response.Content.Length)"
        try {
            $response.Content.Substring(0, 500)
        } catch {}
    }
} catch {
    Write-Host "Error: $_"
}
