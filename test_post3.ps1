$pageToken = "EAAWyTvHLkaABRdXdYZC0LCbZCn9AaPy3ZAI2rIWCu5yrmhCsmiZA9QcSkTtZCg2x3rWK6ZBiWBukHI40V7B6t2Cn97Yyxu3YjQYxujfRT7zrSMZBuoQJ1iCTtgxMxHqUwQcyOXsu3Ag1H01T9hcxD1JVgOQZCw2gDOKUMrccVUaVsR4916bMWux2BZC7H7GjPH1lTZB8io0qjsKSZC20VXzf7HnxjwHs83ZCFf4LOj1ay5QZD"
$pageId = "1158980210638306"

Write-Output "=== Posting directly to page ==="

$headers = @{
    "Content-Type" = "application/x-www-form-urlencoded"
}
$body = "message=Hello+from+Tra+va+Ng%C6%B0%E1%BB%9Di+automation+system.+Testing+API+post.&access_token=$pageToken"

try {
    $result = Invoke-RestMethod -Method Post -Uri "https://graph.facebook.com/v21.0/$pageId/feed" -Body $body -ContentType "application/x-www-form-urlencoded" -ErrorAction Stop
    Write-Output "SUCCESS! Post ID: $($result.id)"
    Write-Output ($result | ConvertTo-Json -Depth 5)
}
catch {
    Write-Output "Error: $($_.Exception.Message)"
    if ($_.Exception.Response) {
        $stream = $_.Exception.Response.GetResponseStream()
        $reader = New-Object System.IO.StreamReader($stream)
        Write-Output "Response: $($reader.ReadToEnd())"
    }
}
