# Platinum+ Optimizer Uninstaller Script
# This script removes the program, shortcuts, and registry keys

# Error handling
$ErrorActionPreference = "Stop"

Write-Host "Starting Platinum+ Optimizer uninstallation..." -ForegroundColor Cyan

# Define paths
$programName = "Platinum+ optimizer"
$programFilesPath = "${env:ProgramFiles}\$programName"
$programFilesX86Path = "${env:ProgramFiles(x86)}\$programName"
$desktopPath = [Environment]::GetFolderPath("Desktop")
$startMenuPath = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs"

# Registry paths
$registryPaths = @(
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\platinum+ optimizer",
    "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\platinum+ optimizer",
    "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\platinum+ optimizer"
)

# Function to kill processes using files in directory
function Kill-ProcessesUsingDirectory {
    param([string]$Path)
    Write-Host "Checking for processes using: $Path" -ForegroundColor Yellow
    try {
        # Use handle.exe if available, or use built-in methods
        $processes = Get-Process | Where-Object {
            try {
                $_.Path -like "$Path*" -or $_.MainModule.FileName -like "$Path*"
            }
            catch {
                $false
            }
        }
        
        if ($processes) {
            Write-Host "Found $($processes.Count) processes using files in directory" -ForegroundColor Yellow
            foreach ($proc in $processes) {
                Write-Host "Killing process: $($proc.Name) (PID: $($proc.Id))" -ForegroundColor Yellow
                try {
                    Stop-Process -Id $proc.Id -Force -ErrorAction SilentlyContinue
                    Start-Sleep -Milliseconds 500
                }
                catch {
                    Write-Host "Could not kill process $($proc.Name): $_" -ForegroundColor Red
                }
            }
        }
        else {
            Write-Host "No processes found using files in directory" -ForegroundColor Gray
        }
    }
    catch {
        Write-Host "Error checking processes: $_" -ForegroundColor Red
    }
}

# Function to forcefully delete directory
function Remove-DirectorySafely {
    param([string]$Path)
    if (Test-Path $Path) {
        Write-Host "Removing directory: $Path" -ForegroundColor Yellow
        
        # First, kill any processes using the directory
        Kill-ProcessesUsingDirectory -Path $Path
        
        # Try standard removal first
        try {
            Remove-Item -Path $Path -Recurse -Force -ErrorAction Stop
            Write-Host "Successfully removed: $Path" -ForegroundColor Green
            return
        }
        catch {
            Write-Host "Standard removal failed, trying forced methods..." -ForegroundColor Yellow
        }
        
        # Try using robocopy to empty directory first
        try {
            $emptyDir = "$env:TEMP\empty_temp_$(Get-Random)"
            New-Item -ItemType Directory -Path $emptyDir -Force | Out-Null
            robocopy $emptyDir $Path /MIR /R:0 /W:0 /NFL /NDL /NJH /NJS | Out-Null
            Remove-Item -Path $emptyDir -Force -ErrorAction SilentlyContinue
            Remove-Item -Path $Path -Recurse -Force -ErrorAction Stop
            Write-Host "Successfully removed using robocopy method: $Path" -ForegroundColor Green
            return
        }
        catch {
            Write-Host "Robocopy method failed, trying take ownership..." -ForegroundColor Yellow
        }
        
        # Try taking ownership and removing
        try {
            takeown /F $Path /R /D Y | Out-Null
            icacls $Path /grant administrators:F /T | Out-Null
            Remove-Item -Path $Path -Recurse -Force -ErrorAction Stop
            Write-Host "Successfully removed using ownership method: $Path" -ForegroundColor Green
            return
        }
        catch {
            Write-Host "Ownership method failed" -ForegroundColor Yellow
        }
        
        # Final attempt with cmd
        try {
            cmd /c "rd /s /q `"$Path`"" 2>&1 | Out-Null
            if (-not (Test-Path $Path)) {
                Write-Host "Successfully removed using cmd method: $Path" -ForegroundColor Green
                return
            }
        }
        catch {
            Write-Host "CMD method failed" -ForegroundColor Yellow
        }
        
        Write-Host "ERROR: Could not remove directory: $Path" -ForegroundColor Red
        Write-Host "Please restart your computer and try again, or delete manually." -ForegroundColor Red
    }
    else {
        Write-Host "Directory not found: $Path" -ForegroundColor Gray
    }
}

# Function to safely delete file
function Remove-FileSafely {
    param([string]$Path)
    if (Test-Path $Path) {
        Write-Host "Removing file: $Path" -ForegroundColor Yellow
        try {
            Remove-Item -Path $Path -Force
            Write-Host "Successfully removed: $Path" -ForegroundColor Green
        }
        catch {
            Write-Host "Error removing $Path : $_" -ForegroundColor Red
        }
    }
    else {
        Write-Host "File not found: $Path" -ForegroundColor Gray
    }
}

# Function to safely delete registry key
function Remove-RegistryKeySafely {
    param([string]$Path)
    if (Test-Path $Path) {
        Write-Host "Removing registry key: $Path" -ForegroundColor Yellow
        try {
            Remove-Item -Path $Path -Recurse -Force
            Write-Host "Successfully removed registry key: $Path" -ForegroundColor Green
        }
        catch {
            Write-Host "Error removing registry key $Path : $_" -ForegroundColor Red
        }
    }
    else {
        Write-Host "Registry key not found: $Path" -ForegroundColor Gray
    }
}

# Remove program directories
Write-Host "`n=== Removing Program Files ===" -ForegroundColor Cyan
Remove-DirectorySafely -Path $programFilesPath
Remove-DirectorySafely -Path $programFilesX86Path

# Remove shortcuts
Write-Host "`n=== Removing Shortcuts ===" -ForegroundColor Cyan
$shortcutPaths = @(
    "$desktopPath\platinum+ optimizer.lnk",
    "$desktopPath\Platinum+ Optimizer.lnk",
    "$startMenuPath\platinum+ optimizer.lnk",
    "$startMenuPath\Platinum+ Optimizer.lnk",
    "$startMenuPath\platinum+ optimizer"
)

foreach ($shortcutPath in $shortcutPaths) {
    if (Test-Path $shortcutPath) {
        Remove-FileSafely -Path $shortcutPath
    }
}

# Remove registry keys
Write-Host "`n=== Removing Registry Keys ===" -ForegroundColor Cyan
foreach ($regPath in $registryPaths) {
    Remove-RegistryKeySafely -Path $regPath
}

# Cleanup temp script
Write-Host "`n=== Cleanup ===" -ForegroundColor Cyan
$tempScriptPath = "$env:TEMP\uninstall_platinum.ps1"
if (Test-Path $tempScriptPath) {
    try {
        Remove-Item -Path $tempScriptPath -Force
        Write-Host "Removed temporary script: $tempScriptPath" -ForegroundColor Green
    }
    catch {
        Write-Host "Could not remove temporary script: $_" -ForegroundColor Yellow
    }
}

Write-Host "`n=== Uninstallation Complete ===" -ForegroundColor Green
Write-Host "Platinum+ Optimizer has been successfully uninstalled." -ForegroundColor Green
Write-Host "Press any key to exit..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
