$dir = "f:\DELLO_SITES\delloFitness\lib\"
Get-ChildItem -Path $dir -Recurse -Filter *.dart | ForEach-Object {
    $content = Get-Content $_.FullName -Raw
    $original = $content
    
    $content = $content -replace "0xFF061E29", "0xFF000000"
    $content = $content -replace "0xFF0A364D", "0xFF000000"
    
    if ($original -cne $content) {
        Set-Content -Path $_.FullName -Value $content -NoNewline
        Write-Host "Updated $($_.Name)"
    }
}
