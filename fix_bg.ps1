$dir = "f:\DELLO_SITES\delloFitness\lib\"
Get-ChildItem -Path $dir -Recurse -Filter *.dart | ForEach-Object {
    $content = Get-Content $_.FullName -Raw
    $original = $content
    
    # Text and Icon colors
    $content = $content -replace "color:\s*Color\(0xFF041E2B\)", "color: Colors.white"
    $content = $content -replace "foregroundColor:\s*Color\(0xFF041E2B\)", "foregroundColor: Colors.white"
    $content = $content -replace "\?\s*Color\(0xFF041E2B\)\s*:", "? Colors.white :"
    
    # Backgrounds
    $content = $content -replace "backgroundColor:\s*Color\(0xFF041E2B\)", "backgroundColor: Color(0xFF061E29)"
    $content = $content -replace "fillColor:\s*Color\(0xFF041E2B\)", "fillColor: Color(0xFF061E29)"
    
    # Catch all remaining 0xFF041E2B
    $content = $content -replace "0xFF041E2B", "0xFF061E29"
    
    if ($original -cne $content) {
        Set-Content -Path $_.FullName -Value $content -NoNewline
        Write-Host "Updated $($_.Name)"
    }
}
