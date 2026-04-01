$dir = "f:\DELLO_SITES\delloFitness\lib\"
Get-ChildItem -Path $dir -Recurse -Filter *.dart | ForEach-Object {
    $content = Get-Content $_.FullName -Raw
    $original = $content
    
    $content = $content -replace "Color\(0xFFFDFBD4\)12", "Color(0x1FFDFBD4)"
    $content = $content -replace "Color\(0xFFFDFBD4\)30", "Color(0x4DFDFBD4)"
    $content = $content -replace "Color\(0xFFFDFBD4\)60", "Color(0x99FDFBD4)"
    
    if ($original -cne $content) {
        Set-Content -Path $_.FullName -Value $content -NoNewline
    }
}
