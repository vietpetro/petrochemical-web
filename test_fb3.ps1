$token = "1603427017396640|sewXN6zUTwJwsgMvG1z5fxgCWKc"
$appId = "1603427017396640"

# Try to create a page via Graph API (needs user token, but let's try)
Write-Output "=== Try: Create Page ==="
$body = @{
    name = "Trà và Người"
    category_id = "1615"  # Tea Room category
    about = "Một góc nhỏ cho người yêu trà, yêu sống chậm và yêu những điều bình yên."
    access_token = $token
}
try {
    $r = Invoke-RestMethod -Method Post -Uri "https://graph.facebook.com/v21.0/me/pages" -Body $body -ErrorAction Stop
    Write-Output ($r | ConvertTo-Json -Depth 10)
} catch {
    $e = $_.Exception
    Write-Output "Error: $($e.Message)"
    if ($e.Response) {
        $s = [System.IO.StreamReader]::new($e.Response.GetResponseStream()).ReadToEnd()
        Write-Output "Details: $s"
    }
}

# Try alternative endpoint
Write-Output "`n=== Try: Create Page v2 ==="
$body2 = @{
    name = "Trà và Người"
    category_id = "1615"
    access_token = $token
}
try {
    $r2 = Invoke-RestMethod -Method Post -Uri "https://graph.facebook.com/v21.0/me/accounts" -Body $body2 -ErrorAction Stop
    Write-Output ($r2 | ConvertTo-Json -Depth 10)
} catch {
    $e = $_.Exception
    if ($e.Response) {
        $s = [System.IO.StreamReader]::new($e.Response.GetResponseStream()).ReadToEnd()
        Write-Output "Details: $s"
    } else {
        Write-Output "Error: $($e.Message)"
    }
}

# Try to list app's pages
Write-Output "`n=== Try: List pages ==="
try {
    $r3 = Invoke-RestMethod -Uri "https://graph.facebook.com/v21.0/$appId/accounts?access_token=$token" -ErrorAction Stop
    Write-Output ($r3 | ConvertTo-Json -Depth 10)
} catch {
    $e = $_.Exception
    if ($e.Response) {
        $s = [System.IO.StreamReader]::new($e.Response.GetResponseStream()).ReadToEnd()
        Write-Output "Details: $s"
    } else {
        Write-Output "Error: $($e.Message)"
    }
}
