# BuildManifest.ps1
# Script to generate manifest.json and version.json for Platinum+ Optimizer

param (
    [string]$Version
)

$ErrorActionPreference = "Stop"
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$programDir = (Resolve-Path "$scriptDir\..").Path
$filesDir = "$programDir\app"

# Helper module
. "$scriptDir\HashGenerator.ps1"

$baseUrl = "https://platinum.optimizer.workers.dev/update"
$versionFile = "$programDir\version.json"

# 1. Version Management
if (-not $Version) {
    if (Test-Path $versionFile) {
        $oldVersionJson = Get-Content $versionFile -Raw | ConvertFrom-Json
        $oldVersion = $oldVersionJson.version
        
        # Auto-increment patch (e.g. 1.0.0 -> 1.0.1)
        if ($oldVersion -match "^(\d+)\.(\d+)\.(\d+)$") {
            $major = $matches[1]
            $minor = $matches[2]
            $patch = [int]$matches[3] + 1
            $Version = "$major.$minor.$patch"
        } else {
            $Version = "1.0.0"
        }
    } else {
        $Version = "1.0.0"
    }
}

Write-Host "Generating manifest for version $Version..." -ForegroundColor Cyan
$buildDate = [DateTime]::UtcNow.ToString("yyyy-MM-ddTHH:mm:ssZ")

$utf8NoBom = New-Object System.Text.UTF8Encoding($false)

# 2. Generate Manifest
Write-Host "Calculating file hashes and generating manifest.json..."
$manifestObj = Get-DirectoryManifest -Path $filesDir
$manifest = @{
    version = $Version
    buildDate = $buildDate
    baseUrl = "/update/files/"
    files = $manifestObj
}
$manifestJson = $manifest | ConvertTo-Json -Depth 5
[System.IO.File]::WriteAllText("$programDir\build\manifest.json", $manifestJson, $utf8NoBom)

# 3. Generate version.json
Write-Host "Saving version.json..."
$versionInfo = @{
    version = $Version
    buildDate = $buildDate
    minPSVersion = "5.1"
}
$versionJson = $versionInfo | ConvertTo-Json -Depth 5
[System.IO.File]::WriteAllText($versionFile, $versionJson, $utf8NoBom)

# 4. Sync to web update directory if present
$webUpdateDir = Join-Path $programDir "..\update"
if (Test-Path $webUpdateDir) {
    Write-Host "Syncing build artifacts to website update folder ($webUpdateDir)..." -ForegroundColor Cyan
    $webUpdateFilesDir = Join-Path $webUpdateDir "files"
    if (-not (Test-Path $webUpdateFilesDir)) {
        New-Item -ItemType Directory -Path $webUpdateFilesDir -Force | Out-Null
    }
    
    # Copy manifest and version using UTF-8 without BOM
    [System.IO.File]::WriteAllText("$webUpdateDir\manifest.json", $manifestJson, $utf8NoBom)
    [System.IO.File]::WriteAllText("$webUpdateDir\version.json", $versionJson, $utf8NoBom)
    
    # Copy app files
    Copy-Item -Path "$filesDir\*" -Destination $webUpdateFilesDir -Recurse -Force
    Write-Host "Successfully synced files to $webUpdateFilesDir!" -ForegroundColor Green
}

Write-Host ""
Write-Host "=== Build Completed Successfully! ===" -ForegroundColor Green
Write-Host "Version: $Version"
Write-Host "Total Files: $($manifestObj.Count)"
Write-Host "The manifest and version.json are ready in $programDir and synced to $webUpdateDir."
