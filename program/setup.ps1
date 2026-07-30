# Platinum+ Optimizer Setup Launcher
# Executes installer directly within active shell session

param (
    [switch]$Silent
)

$ErrorActionPreference = "Stop"

# Resolve script directory
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$installerPath = Join-Path $scriptDir "installer\install.ps1"

if (-not (Test-Path $installerPath)) {
    Write-Error "Installer script not found at: $installerPath"
    exit 1
}

# Check Administrator privileges
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Host "[PRIVILEGE] [WARN] Administrator privileges required. Requesting elevation in current shell..." -ForegroundColor Yellow
    $argList = "-NoProfile -ExecutionPolicy Bypass -File `"$installerPath`""
    if ($Silent) { $argList += " -Silent" }
    Start-Process powershell.exe -ArgumentList $argList -WorkingDirectory $scriptDir -Verb RunAs
    exit
}

Write-Host "[EXEC] [INFO] Executing installer in active shell session: $installerPath" -ForegroundColor Cyan
Set-Location -Path $scriptDir
. $installerPath
