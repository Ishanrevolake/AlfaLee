$dir = "f:\DELLO_SITES\AlfaFitness\lib"
Get-ChildItem -Path $dir -Recurse -Filter *.dart | ForEach-Object {
    $content = Get-Content $_.FullName -Raw
    if ($null -ne $content) {
        $original = $content
        
        # Color replacement: 0xFF3EB489 (Green) -> 0xFF8B0000 (Dark red)
        $content = $content -replace "0xFF3EB489", "0xFF8B0000"
        
        # Text replacements
        # Sometimes there's PT PAUL BENTLY or PT PAUL BENTLEY
        $content = $content -replace "PT PAUL BENTLEY", "ALFA LEE"
        $content = $content -replace "PT PAUL BENTLY", "ALFA LEE"
        
        # In inbox page, coach name
        $content = $content -replace "COACH PAUL", "COACH LEE"

        if ($original -cne $content) {
            Set-Content -Path $_.FullName -Value $content -NoNewline
            Write-Host "Updated: $($_.Name)"
        }
    }
}
