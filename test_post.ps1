$pageToken = "EAAWyTvHLkaABRdXdYZC0LCbZCn9AaPy3ZAI2rIWCu5yrmhCsmiZA9QcSkTtZCg2x3rWK6ZBiWBukHI40V7B6t2Cn97Yyxu3YjQYxujfRT7zrSMZBuoQJ1iCTtgxMxHqUwQcyOXsu3Ag1H01T9hcxD1JVgOQZCw2gDOKUMrccVUaVsR4916bMWux2BZC7H7GjPH1lTZB8io0qjsKSZC20VXzf7HnxjwHs83ZCFf4LOj1ay5QZD"
$pageId = "1158980210638306"

# Try a simple ASCII-only post first
Write-Output "=== Posting test ==="
$body = @{
    message = "Hello, this is a test post from the Trà và Người page automation system. Testing API connectivity."
    access_token = $pageToken
}
try {
    $result = Invoke-RestMethod -Method Post -Uri "https://graph.facebook.com/v21.0/$pageId/feed" -Body $body -ErrorAction Stop
    Write-Output "Post ID: $($result.id)"
    Write-Output ($result | ConvertTo-Json -Depth 5)
    Write-Output "`nSUCCESS: API posting works!"
} catch {
    Write-Output "Error: $($_.Exception.Message)"
    if ($_.Exception.Response) {
        $s = [System.IO.StreamReader]::new($_.Exception.Response.GetResponseStream()).ReadToEnd()
        Write-Output $s
    }
}
