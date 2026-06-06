$pageToken = "EAAWyTvHLkaABRdXdYZC0LCbZCn9AaPy3ZAI2rIWCu5yrmhCsmiZA9QcSkTtZCg2x3rWK6ZBiWBukHI40V7B6t2Cn97Yyxu3YjQYxujfRT7zrSMZBuoQJ1iCTtgxMxHqUwQcyOXsu3Ag1H01T9hcxD1JVgOQZCw2gDOKUMrccVUaVsR4916bMWux2BZC7H7GjPH1lTZB8io0qjsKSZC20VXzf7HnxjwHs83ZCFf4LOj1ay5QZD"
$pageId = "1158980210638306"

try {
    # Test with photo (no message)
    $body = @{ access_token = $pageToken }
    $r = Invoke-RestMethod -Method Get -Uri "https://graph.facebook.com/v21.0/$pageId`?fields=id,name,fan_count&access_token=$pageToken" -ErrorAction Stop
    Write-Output "Page: $($r | ConvertTo-Json)"
    
    Write-Output "`n--- Try posting ---"
    $postBody = @{
        message = "Testing post"
        access_token = $pageToken
    }
    $p = Invoke-RestMethod -Method Post -Uri "https://graph.facebook.com/v21.0/$pageId/feed" -Body $postBody -ErrorAction Stop
    Write-Output "Posted: $($p.id)"
    
} catch {
    Write-Output "Err: $($_.Exception.Message)"
    if ($_.Exception.Response) {
        $s = [System.IO.StreamReader]::new($_.Exception.Response.GetResponseStream()).ReadToEnd()
        Write-Output "Response: $s"
    }
}
