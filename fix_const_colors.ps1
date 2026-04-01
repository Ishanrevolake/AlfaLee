$dir = "f:\DELLO_SITES\delloFitness\lib\"
Get-ChildItem -Path $dir -Recurse -Filter *.dart | ForEach-Object {
    $content = Get-Content $_.FullName -Raw
    $original = $content
    
    # Replace invalid consts before Colors.
    $content = $content -replace "const\s+Colors\.white", "Colors.white"
    $content = $content -replace "const\s+Colors\.black", "Colors.black"
    $content = $content -replace "const\s+Colors\.black12", "Colors.black12"
    $content = $content -replace "const\s+Colors\.black26", "Colors.black26"
    $content = $content -replace "const\s+Colors\.black38", "Colors.black38"
    $content = $content -replace "const\s+Colors\.black54", "Colors.black54"
    $content = $content -replace "const\s+Colors\.black87", "Colors.black87"
    $content = $content -replace "const\s+Colors\.transparent", "Colors.transparent"
    
    # Replace shades with hex colors to avoid const evaluation errors
    $content = $content -replace "const\s+Colors\.grey\.shade50", "const Color(0xFFFAFAFA)"
    $content = $content -replace "const\s+Colors\.grey\.shade200", "const Color(0xFFEEEEEE)"
    $content = $content -replace "const\s+Colors\.grey\.shade300", "const Color(0xFFE0E0E0)"
    $content = $content -replace "const\s+Colors\.grey\.shade400", "const Color(0xFFBDBDBD)"
    
    $content = $content -replace "Colors\.grey\.shade50", "const Color(0xFFFAFAFA)"
    $content = $content -replace "Colors\.grey\.shade200", "const Color(0xFFEEEEEE)"
    $content = $content -replace "Colors\.grey\.shade300", "const Color(0xFFE0E0E0)"
    $content = $content -replace "Colors\.grey\.shade400", "const Color(0xFFBDBDBD)"
    
    if ($original -cne $content) {
        Set-Content -Path $_.FullName -Value $content -NoNewline
        Write-Host "Fixed $($_.Name)"
    }
}
