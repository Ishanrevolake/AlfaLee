$dir = "f:\DELLO_SITES\AlfaFitness\lib"
Get-ChildItem -Path $dir -Recurse -Filter *.dart | ForEach-Object {
    $content = Get-Content $_.FullName -Raw
    if ($null -ne $content) {
        $original = $content
        
        # Color replacement: 0xFF8B0000 (Dark red) -> 0xFFDC143C (Lighter Crimson Red)
        $content = $content -replace "0xFF8B0000", "0xFFDC143C"
        
        if ($original -cne $content) {
            Set-Content -Path $_.FullName -Value $content -NoNewline
            Write-Host "Updated: $($_.Name)"
        }
    }
}
