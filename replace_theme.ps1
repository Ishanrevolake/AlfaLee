$dir = "f:\DELLO_SITES\delloFitness\lib\"
Get-ChildItem -Path $dir -Recurse -Filter *.dart | ForEach-Object {
    $content = Get-Content $_.FullName -Raw
    $original = $content
    
    # Primary Accent: 0xFFCCFF00 -> 0xFFDC143C
    $content = $content -replace "0xFFCCFF00", "0xFFDC143C"
    
    # Background (Dark): Colors.black / 0xFF000000 -> 0xFF041E2B
    $content = $content -replace "Colors\.black", "Color(0xFF041E2B)"
    $content = $content -replace "0xFF000000", "0xFF041E2B"
    
    # Secondary Card Backgrounds: 0xFF1A1A1A, 0xFF121212, 0xFF161616 -> 0xFF0A364D
    $content = $content -replace "0xFF1A1A1A", "0xFF0A364D"
    $content = $content -replace "0xFF121212", "0xFF0A364D"
    $content = $content -replace "0xFF161616", "0xFF0A364D"
    
    # Light Accents: Colors.white, Colors.white10, etc.
    $content = $content -replace "Colors\.white10", "Color(0x1AFDFBD4)"
    $content = $content -replace "Colors\.white24", "Color(0x3DFDFBD4)"
    $content = $content -replace "Colors\.white38", "Color(0x61FDFBD4)"
    $content = $content -replace "Colors\.white54", "Color(0x8AFDFBD4)"
    $content = $content -replace "Colors\.white70", "Color(0xB3FDFBD4)"
    
    # Standard white
    $content = $content -replace "Colors\.white", "Color(0xFFFDFBD4)"
    $content = $content -replace "0xFFFFFFFF", "0xFFFDFBD4"

    if ($original -cne $content) {
        Set-Content -Path $_.FullName -Value $content -NoNewline
        Write-Host "Updated: $($_.Name)"
    }
}
