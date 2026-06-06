$userToken = "EAAWyTvHLkaABRaccU8N39kLp9WtQ5b8XCkuRUEnBOBtUEiXL4QR5cJOgw2ZB582F02vDaOqRst7U8fppIrMK3y5d6bILjBwMYYu15c9pPsihZA29zWtfZA82VmEZBRz2Hb00kk5ghSi707ZCIe8kd22dof2EbTeJVqlCzmQbxkcXMZAf4dBxUDdt2LqGqz3RnnjGTY5igOvIqCjyZBYe2HkWflc5atKZCXCv"
$pageId = "1158980210638306"

# Step 1: Get the user's pages
Write-Output "=== Getting user pages ==="
$accounts = Invoke-RestMethod -Uri "https://graph.facebook.com/v21.0/me/accounts?access_token=$userToken" -ErrorAction Stop
Write-Output ($accounts | ConvertTo-Json -Depth 10)

Write-Output "`n=== Done ==="
