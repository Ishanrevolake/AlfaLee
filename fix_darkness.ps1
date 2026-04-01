$dir = "f:\DELLO_SITES\delloFitness\lib\"
Get-ChildItem -Path $dir -Recurse -Filter *.dart | ForEach-Object {
    $content = Get-Content $_.FullName -Raw
    $original = $content
    
    $content = $content -replace "backgroundColor:\s*Color\(0xFF000000\)", "backgroundColor: Color(0xFF121212)"
    $content = $content -replace "color:\s*const\s+Color\(0xFF000000\)", "color: const Color(0xFF1E1E1E)"
    $content = $content -replace "color:\s*Color\(0xFF000000\)", "color: const Color(0xFF1E1E1E)"
    $content = $content -replace "fillColor:\s*Color\(0xFF000000\)", "fillColor: Color(0xFF1E1E1E)"
    
    $content = $content -replace "0xFF000000", "0xFF121212"
    
    if ($original -cne $content) {
        Set-Content -Path $_.FullName -Value $content -NoNewline
        Write-Host "Fixed $($_.Name)"
    }
}
