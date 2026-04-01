$dir = "f:\DELLO_SITES\delloFitness\lib\"
Get-ChildItem -Path $dir -Recurse -Filter *.dart | ForEach-Object {
    $content = Get-Content $_.FullName -Raw
    $original = $content
    
    $content = $content -creplace "backgroundcolor:", "backgroundColor:"
    $content = $content -creplace "foregroundcolor:", "foregroundColor:"
    $content = $content -creplace "fillcolor:", "fillColor:"
    
    if ($original -cne $content) {
        Set-Content -Path $_.FullName -Value $content -NoNewline
        Write-Host "Fixed $($_.Name)"
    }
}
