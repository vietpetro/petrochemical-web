$token = "EAAWyTvHLkaABRYdLfC0ehZB1j0Cg4NlxmQalrAvidrfmQ9D6xsZBLpWWdeBPAUyIGa5JTqUKhUV2qoAZCu82FoNMMyZCiXppzlbtXyplMEW1rLNZA0NBuUZAbgCGredWPpv9D4qXGuqGS3wInY9KGfpOvKrvVTcqp8O0eIYXzTprvDRm8YnP3ZCM0oiEv72Md1hSLfLNwmceQsVuuM9ZAz4FNZAC91mFtmf3U"
$appToken = "1603427017396640|sewXN6zUTwJwsgMvG1z5fxgCWKc"
$pageId = "1158980210638306"

Write-Host "=== DEBUG TOKEN ==="
$uri = "https://graph.facebook.com/v25.0/debug_token?input_token=$token&access_token=$appToken"
$debug = Invoke-RestMethod -Uri $uri -Method Get
$debug.data | Format-List
Write-Host "`n=== SCOPES ==="
$debug.data.scopes

Write-Host "`n=== ME ==="
$me = Invoke-RestMethod -Uri "https://graph.facebook.com/v25.0/me?fields=id,name&access_token=$token" -Method Get
$me | ConvertTo-Json

Write-Host "`n=== GET PAGE TOKEN ==="
$accounts = Invoke-RestMethod -Uri "https://graph.facebook.com/v25.0/me/accounts?access_token=$token" -Method Get
$accounts | ConvertTo-Json -Depth 5
