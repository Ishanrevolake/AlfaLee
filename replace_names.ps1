$searchPaths = @(
    "pubspec.yaml",
    "README.md",
    "test",
    "lib",
    "android",
    "ios",
    "linux",
    "macos",
    "windows",
    "web"
)

$replacements = @{
    "dello_fitness" = "alfa_fitness"
    "com.dello.fitness" = "com.dello.alfafitness"
    "Dello Fitness" = "AlfaFitness"
    "delloFitness" = "AlfaFitness"
}

foreach ($path in $searchPaths) {
    if (Test-Path $path) {
        $files = Get-ChildItem -Path $path -Recurse -File | Where-Object { 
            $_.Extension -inotmatch "\.png|\.jpg|\.jpeg|\.ico|\.sqlite|\.exe|\.dll" 
        }

        foreach ($file in $files) {
            $content = Get-Content $file.FullName -Raw
            if ($null -ne $content) {
                $modified = $false
                foreach ($key in $replacements.Keys) {
                    if ($content -match [regex]::Escape($key)) {
                        $content = $content -replace [regex]::Escape($key), $replacements[$key]
                        $modified = $true
                    }
                }
                if ($modified) {
                    Set-Content -Path $file.FullName -Value $content -NoNewline
                    Write-Host "Updated $($file.FullName)"
                }
            }
        }
    }
}

# Rename the android folder
$kotlinDir = "android\app\src\main\kotlin\com\dello\fitness"
if (Test-Path "$kotlinDir\dello_fitness") {
    Rename-Item "$kotlinDir\dello_fitness" "alfa_fitness"
    Write-Host "Renamed kotlin directory."
}
