$pageToken = "EAAWyTvHLkaABRdXdYZC0LCbZCn9AaPy3ZAI2rIWCu5yrmhCsmiZA9QcSkTtZCg2x3rWK6ZBiWBukHI40V7B6t2Cn97Yyxu3YjQYxujfRT7zrSMZBuoQJ1iCTtgxMxHqUwQcyOXsu3Ag1H01T9hcxD1JVgOQZCw2gDOKUMrccVUaVsR4916bMWux2BZC7H7GjPH1lTZB8io0qjsKSZC20VXzf7HnxjwHs83ZCFf4LOj1ay5QZD"
$pageId = "1158980210638306"

$uri = "https://graph.facebook.com/v21.0/$pageId/feed"
$body = "message=Chao+ban.+Trang+Tra+va+Nguoi+da+duoc+kich+hoat.&access_token=$pageToken"

Write-Output "Posting..."
try {
    $result = Invoke-RestMethod -Method Post -Uri $uri -Body $body -ContentType "application/x-www-form-urlencoded" -ErrorAction Stop
    Write-Output "SUCCESS! $($result.id)"
    Write-Output ($result | ConvertTo-Json)
}
catch {
    $e = $_.Exception
    if ($e.Response) {
        $s = [System.IO.StreamReader]::new($e.Response.GetResponseStream()).ReadToEnd()
        Write-Output $s
    } else {
        Write-Output $e.Message
    }
}
