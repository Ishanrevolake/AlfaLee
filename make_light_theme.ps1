$dir = "f:\DELLO_SITES\delloFitness\lib\"
Get-ChildItem -Path $dir -Recurse -Filter *.dart | ForEach-Object {
    $content = Get-Content $_.FullName -Raw
    $original = $content
    
    # Backgrounds
    $content = $content -replace "Color\(0xFF121212\)", "Colors.grey.shade50"
    $content = $content -replace "Color\(0xFF1E1E1E\)", "Colors.white"
    
    # Texts and borders
    $content = $content -replace "Color\(0xFFFDFBD4\)\.withOpacity\(0\.03\)", "Colors.grey.shade200"
    $content = $content -replace "Color\(0xFFFDFBD4\)\.withOpacity\(0\.05\)", "Colors.grey.shade200"
    $content = $content -replace "Color\(0xFFFDFBD4\)\.withOpacity\(0\.1\)", "Colors.grey.shade300"
    $content = $content -replace "Color\(0xFFFDFBD4\)\.withOpacity\(0\.2\)", "Colors.black38"
    $content = $content -replace "Color\(0xFFFDFBD4\)\.withOpacity\(0\.3\)", "Colors.black54"
    $content = $content -replace "Color\(0xFFFDFBD4\)\.withOpacity\(0\.35\)", "Colors.black54"
    
    $content = $content -replace "Color\(0x1AFDFBD4\)", "Colors.black12"
    $content = $content -replace "Color\(0x1FFDFBD4\)", "Colors.black12"
    $content = $content -replace "Color\(0x3DFDFBD4\)", "Colors.black38"
    $content = $content -replace "Color\(0x4DFDFBD4\)", "Colors.black38"
    $content = $content -replace "Color\(0x61FDFBD4\)", "Colors.black54"
    $content = $content -replace "Color\(0x8AFDFBD4\)", "Colors.black87"
    $content = $content -replace "Color\(0x99FDFBD4\)", "Colors.black87"
    $content = $content -replace "Color\(0xB3FDFBD4\)", "Colors.black87"
    $content = $content -replace "Color\(0xFFFDFBD4\)", "Colors.black"
    
    if ($original -cne $content) {
        Set-Content -Path $_.FullName -Value $content -NoNewline
        Write-Host "Updated $($_.Name)"
    }
}
