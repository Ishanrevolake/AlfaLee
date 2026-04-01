$dir = "f:\DELLO_SITES\delloFitness\lib\"
Get-ChildItem -Path $dir -Recurse -Filter *.dart | ForEach-Object {
    $content = Get-Content $_.FullName -Raw
    $original = $content
    
    $content = $content -creplace "backgroundcolor: Colors\.white", "backgroundColor: Color(0xFF061E29)"
    $content = $content -creplace "foregroundcolor: Colors\.white", "foregroundColor: Colors.white"
    $content = $content -creplace "fillcolor: Colors\.white", "fillColor: Color(0xFF061E29)"
    
    if ($original -cne $content) {
        Set-Content -Path $_.FullName -Value $content -NoNewline
        Write-Host "Fixed $($_.Name)"
    }
}
