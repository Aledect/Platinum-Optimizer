# Platinum+ Optimizer Auto-Updater
[CmdletBinding()]
param(
    [string]$AppPath,
    [string]$UpdateBaseUrl = "https://platinum.optimizer.workers.dev/update",
    [switch]$StartupCheck,
    [switch]$Force,
    [switch]$NoRestart
)

$ErrorActionPreference = "Stop"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

if (-not $AppPath) {
    $programRoot = Split-Path -Parent $PSScriptRoot
    $AppPath = Join-Path $programRoot "app"
}

$AppPath = (Resolve-Path -LiteralPath $AppPath -ErrorAction SilentlyContinue).Path
if (-not $AppPath) {
    $AppPath = Join-Path (Split-Path -Parent $PSScriptRoot) "app"
}

$UpdateBaseUrl = $UpdateBaseUrl.TrimEnd("/")
$versionUrl = "$UpdateBaseUrl/version.json"
$manifestUrl = "$UpdateBaseUrl/manifest.json"
$localUpdateInfo = Join-Path $AppPath "update_info.json"
$logDir = Join-Path $AppPath "log"
$lockFile = Join-Path $env:TEMP "platinum_optimizer_update.lock"

function Write-UpdateLog {
    param(
        [string]$Message,
        [string]$Color = "Gray"
    )

    if (-not $StartupCheck) {
        Write-Host $Message -ForegroundColor $Color
    }

    try {
        if (-not (Test-Path -LiteralPath $logDir)) {
            New-Item -ItemType Directory -Path $logDir -Force | Out-Null
        }
        $stamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        Add-Content -LiteralPath (Join-Path $logDir "updater.log") -Value "[$stamp] $Message" -Encoding UTF8
    } catch {}
}

function Exit-Update {
    param([int]$Code = 0)

    try {
        if (Test-Path -LiteralPath $lockFile) {
            Remove-Item -LiteralPath $lockFile -Force -ErrorAction SilentlyContinue
        }
    } catch {}
    exit $Code
}

function Get-FileSHA256 {
    param([string]$Path)

    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
        return $null
    }

    try {
        return (Get-FileHash -LiteralPath $Path -Algorithm SHA256 -ErrorAction Stop).Hash.ToLowerInvariant()
    } catch {
        return $null
    }
}

function ConvertTo-RelativePath {
    param(
        [string]$Path,
        [string]$Root
    )

    $rootFull = [System.IO.Path]::GetFullPath($Root).TrimEnd('\', '/')
    $pathFull = [System.IO.Path]::GetFullPath($Path)
    return $pathFull.Substring($rootFull.Length).TrimStart('\', '/') -replace '\\', '/'
}

function Test-UserDataPath {
    param([string]$RelativePath)

    $rel = ($RelativePath -replace '\\', '/').TrimStart('/').ToLowerInvariant()

    if ($rel -like "*.log") { return $true }
    if ($rel -like "log/*") { return $true }
    if ($rel -like "temp/*" -or $rel -like "tmp/*") { return $true }
    if ($rel -eq "config/state.json") { return $true }
    if ($rel -eq "config/settings.json") { return $true }
    if ($rel -like "config/user*") { return $true }

    # Keep the backup scripts updateable, but never touch generated backup payloads.
    if ($rel -like "tweak/01_backup/registry_backup/registry/*") { return $true }
    if ($rel -like "tweak/01_backup/restore_point/restore/*") { return $true }

    if ($rel -like "*/registry_backup/registry/*") { return $true }
    if ($rel -like "*/restore_point/restore/*") { return $true }

    return $false
}

function Test-ConfigPath {
    param([string]$RelativePath)

    $rel = ($RelativePath -replace '\\', '/').TrimStart('/').ToLowerInvariant()
    return ($rel -eq "config/state.json" -or $rel -eq "config/settings.json" -or $rel -like "config/user*")
}

function Join-Url {
    param(
        [string]$Base,
        [string]$Relative
    )

    return "$($Base.TrimEnd('/'))/$($Relative.TrimStart('/') -replace '\\','/')"
}

function Get-DownloadUrl {
    param(
        $Manifest,
        [string]$RelativePath
    )

    if ($Manifest.baseUrl) {
        $base = [string]$Manifest.baseUrl
        if ($base.StartsWith("/")) {
            $updateUri = [Uri]$UpdateBaseUrl
            $origin = "$($updateUri.Scheme)://$($updateUri.Host)"
            if (-not $updateUri.IsDefaultPort) {
                $origin = "$origin`:$($updateUri.Port)"
            }
            return Join-Url -Base "$origin$base" -Relative $RelativePath
        }

        return Join-Url -Base $base -Relative $RelativePath
    }

    return Join-Url -Base "$UpdateBaseUrl/files" -Relative $RelativePath
}

function Invoke-QuickJson {
    param([string]$Uri)

    return Invoke-RestMethod -Uri $Uri -UseBasicParsing -TimeoutSec 4 -ErrorAction Stop
}

function Merge-JsonObject {
    param(
        [Parameter(Mandatory=$true)]$Local,
        [Parameter(Mandatory=$true)]$Remote
    )

    foreach ($remoteProp in $Remote.PSObject.Properties) {
        $localProp = $Local.PSObject.Properties[$remoteProp.Name]

        if ($null -eq $localProp) {
            $Local | Add-Member -MemberType NoteProperty -Name $remoteProp.Name -Value $remoteProp.Value
            continue
        }

        $localIsObject = $localProp.Value -is [pscustomobject]
        $remoteIsObject = $remoteProp.Value -is [pscustomobject]
        if ($localIsObject -and $remoteIsObject) {
            Merge-JsonObject -Local $localProp.Value -Remote $remoteProp.Value
        }
    }
}

function Update-ConfigPreservingUserValues {
    param(
        [string]$RelativePath,
        [string]$DownloadUrl,
        [string]$ExpectedHash
    )

    $localPath = Join-Path $AppPath ($RelativePath -replace '/', '\')

    if (Test-Path -LiteralPath $localPath) {
        if ([System.IO.Path]::GetExtension($localPath).ToLowerInvariant() -ne ".json") {
            Write-UpdateLog "Skipping user config: $RelativePath"
            return $true
        }
    }

    $tempFile = Join-Path $env:TEMP ("platinum_config_{0}.tmp" -f ([guid]::NewGuid().ToString("N")))
    try {
        Invoke-WebRequest -Uri $DownloadUrl -OutFile $tempFile -UseBasicParsing -TimeoutSec 12 -ErrorAction Stop

        $downloadHash = Get-FileSHA256 -Path $tempFile
        if ($ExpectedHash -and $downloadHash -ne $ExpectedHash.ToLowerInvariant()) {
            throw "Hash mismatch for $RelativePath"
        }

        $dir = Split-Path -Parent $localPath
        if (-not (Test-Path -LiteralPath $dir)) {
            New-Item -ItemType Directory -Path $dir -Force | Out-Null
        }

        if (-not (Test-Path -LiteralPath $localPath)) {
            Copy-Item -LiteralPath $tempFile -Destination $localPath -Force
            Write-UpdateLog "Created missing config: $RelativePath" "Green"
            return $true
        }

        $localJson = Get-Content -LiteralPath $localPath -Raw -Encoding UTF8 | ConvertFrom-Json
        $remoteJson = Get-Content -LiteralPath $tempFile -Raw -Encoding UTF8 | ConvertFrom-Json

        if ($localJson -is [pscustomobject] -and $remoteJson -is [pscustomobject]) {
            Merge-JsonObject -Local $localJson -Remote $remoteJson
            $localJson | ConvertTo-Json -Depth 20 | Out-File -LiteralPath $localPath -Encoding UTF8 -Force
            Write-UpdateLog "Merged config defaults without replacing user values: $RelativePath" "Green"
        } else {
            Write-UpdateLog "Skipping config array/list to preserve user values: $RelativePath"
        }

        return $true
    } catch {
        Write-UpdateLog "Config update skipped for ${RelativePath}: $_" "Yellow"
        return $false
    } finally {
        Remove-Item -LiteralPath $tempFile -Force -ErrorAction SilentlyContinue
    }
}

if (Test-Path -LiteralPath $lockFile) {
    $age = (Get-Date) - (Get-Item -LiteralPath $lockFile).LastWriteTime
    if ($age.TotalMinutes -lt 10) {
        Exit-Update 0
    }
}

try {
    Set-Content -LiteralPath $lockFile -Value ([System.Diagnostics.Process]::GetCurrentProcess().Id) -Encoding ASCII -Force
} catch {}

Write-UpdateLog "Checking updates from $UpdateBaseUrl" "Cyan"

try {
    $remoteVersion = Invoke-QuickJson -Uri $versionUrl
} catch {
    Write-UpdateLog "Update server unavailable, startup continues offline." "Yellow"
    Exit-Update 0
}

# Compare with local version file to prevent downgrading or overwriting active local development edits
$localVersionFile = Join-Path (Split-Path -Parent $AppPath) "version.json"
if (Test-Path -LiteralPath $localVersionFile) {
    try {
        $localVerObj = Get-Content -LiteralPath $localVersionFile -Raw -Encoding UTF8 | ConvertFrom-Json
        if ($localVerObj.version -and $remoteVersion.version) {
            $localVerStr = [string]$localVerObj.version -replace '[^0-9\.]',''
            $remoteVerStr = [string]$remoteVersion.version -replace '[^0-9\.]',''
            $localVer = [version]$localVerStr
            $remoteVer = [version]$remoteVerStr
            if ($localVer -ge $remoteVer -and -not $Force) {
                Write-UpdateLog "Local version ($localVer) is up to date or newer than remote ($remoteVer). Skipping update." "Green"
                Exit-Update 0
            }
        }
    } catch {}
}

try {
    $manifest = Invoke-QuickJson -Uri $manifestUrl
} catch {
    Write-UpdateLog "Manifest unavailable, startup continues without update." "Yellow"
    Exit-Update 0
}

if (-not $manifest.files) {
    Write-UpdateLog "Manifest does not contain files, update skipped." "Yellow"
    Exit-Update 0
}

$filesToUpdate = @()
$configFiles = @()

foreach ($file in $manifest.files) {
    if (-not $file.path -or -not $file.hash) {
        continue
    }

    $relativePath = ([string]$file.path) -replace '\\', '/'

    if (Test-ConfigPath -RelativePath $relativePath) {
        $configFiles += $file
        continue
    }

    if (Test-UserDataPath -RelativePath $relativePath) {
        continue
    }

    $localPath = Join-Path $AppPath ($relativePath -replace '/', '\')
    $localHash = Get-FileSHA256 -Path $localPath
    if ($Force -or $localHash -ne ([string]$file.hash).ToLowerInvariant()) {
        $filesToUpdate += $file
    }
}

$changed = 0
$failed = 0

foreach ($file in $filesToUpdate) {
    $relativePath = ([string]$file.path) -replace '\\', '/'
    $localPath = Join-Path $AppPath ($relativePath -replace '/', '\')
    $tempFile = Join-Path $env:TEMP ("platinum_update_{0}.tmp" -f ([guid]::NewGuid().ToString("N")))

    try {
        $fileUrl = Get-DownloadUrl -Manifest $manifest -RelativePath $relativePath
        Invoke-WebRequest -Uri $fileUrl -OutFile $tempFile -UseBasicParsing -TimeoutSec 20 -ErrorAction Stop

        $newHash = Get-FileSHA256 -Path $tempFile
        if ($newHash -ne ([string]$file.hash).ToLowerInvariant()) {
            throw "Hash mismatch for $relativePath"
        }

        $dir = Split-Path -Parent $localPath
        if (-not (Test-Path -LiteralPath $dir)) {
            New-Item -ItemType Directory -Path $dir -Force | Out-Null
        }

        Move-Item -LiteralPath $tempFile -Destination $localPath -Force
        $changed++
        Write-UpdateLog "Updated: $relativePath" "Green"
    } catch {
        $failed++
        Write-UpdateLog "Failed to update ${relativePath}: $_" "Red"
    } finally {
        Remove-Item -LiteralPath $tempFile -Force -ErrorAction SilentlyContinue
    }
}

foreach ($file in $configFiles) {
    $relativePath = ([string]$file.path) -replace '\\', '/'
    $localPath = Join-Path $AppPath ($relativePath -replace '/', '\')

    if ($Force -or -not (Test-Path -LiteralPath $localPath)) {
        $ok = Update-ConfigPreservingUserValues -RelativePath $relativePath -DownloadUrl (Get-DownloadUrl -Manifest $manifest -RelativePath $relativePath) -ExpectedHash ([string]$file.hash)
        if ($ok) { $changed++ } else { $failed++ }
    }
}

try {
    $remoteVersion | ConvertTo-Json -Depth 10 | Out-File -LiteralPath $localUpdateInfo -Encoding UTF8 -Force
} catch {}

if ($failed -eq 0) {
    Write-UpdateLog "Update check completed. Changed files: $changed." "Green"
} else {
    Write-UpdateLog "Update completed with $failed failed file(s)." "Yellow"
}

if (-not $StartupCheck -and -not $NoRestart -and $changed -gt 0) {
    $launcher = Join-Path $AppPath "run.ps1"
    if (Test-Path -LiteralPath $launcher) {
        Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$launcher`"" -WorkingDirectory $AppPath -WindowStyle Hidden
    }
}

Exit-Update 0
