# Platinum+ Optimizer Installer
# Please run this script as Administrator
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Add-Type -AssemblyName System.Windows.Forms
    [System.Windows.Forms.MessageBox]::Show("Please run this installer as Administrator.`n`nRight-click the script and select 'Run as Administrator'.", "Administrator Required", "OK", "Information")
    exit
}

# Server configuration
$script:ServerUrl = "https://platinum.optimizer.workers.dev/program"
$script:UseServer = $true

# Setup file logging
$logFile = Join-Path $env:TEMP "platinum_installer_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"
function Write-Log {
    param($Message, $Color = "White")
    $timestamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss.fff")
    $logEntry = "[$timestamp] $Message"
    Write-Host $logEntry -ForegroundColor $Color
    Add-Content -Path $logFile -Value $logEntry
}
Write-Log "[INIT] Platinum+ Optimizer Installer Subsystem Initialized" "Cyan"

[System.Diagnostics.Process]::GetCurrentProcess().PriorityClass = [System.Diagnostics.ProcessPriorityClass]::High
Add-Type -AssemblyName PresentationFramework, PresentationCore, WindowsBase, System.Windows.Forms, System.Drawing

# ─── Determina root script ────────────────────────────────────────────────────
Write-Host "[INIT] Platinum+ Optimizer Installer starting..." -ForegroundColor Cyan
Write-Host "[INIT] Script path: $($MyInvocation.MyCommand.Path)" -ForegroundColor Cyan
if ($MyInvocation.MyCommand.Path) {
    $script:ScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
    Write-Host "[INIT] Script root: $ScriptRoot" -ForegroundColor Cyan
    
    # Check for app folder in parent directory (new structure)
    if (Test-Path "$ScriptRoot\..\app") {
        $script:InstallScriptRoot = $ScriptRoot
        $script:LocalFilesDir = "$ScriptRoot\..\app"
        Write-Host "[INIT] Local files found: $LocalFilesDir" -ForegroundColor Green
    } elseif (Test-Path "$ScriptRoot\files") {
        # Legacy structure support
        $script:InstallScriptRoot = $ScriptRoot
        $script:LocalFilesDir = "$ScriptRoot\files"
        Write-Host "[INIT] Local files found (legacy): $LocalFilesDir" -ForegroundColor Green
    } elseif (Test-Path "$ScriptRoot\program\files") {
        # Alternative legacy structure
        $script:InstallScriptRoot = "$ScriptRoot\program"
        $script:LocalFilesDir = "$ScriptRoot\program\files"
        Write-Host "[INIT] Local files found (legacy): $LocalFilesDir" -ForegroundColor Green
    } else {
        $script:InstallScriptRoot = $ScriptRoot
        $script:LocalFilesDir = "$ScriptRoot\..\app"
        Write-Host "[INIT] No local files found, will use server" -ForegroundColor Yellow
    }
} else {
    # If run directly without file context, report error and exit
    Write-Host "[ERROR] Script must be run from a file" -ForegroundColor Red
    exit
}

$script:UseLocalFiles = Test-Path $script:LocalFilesDir
Write-Host "[INIT] UseLocalFiles: $script:UseLocalFiles" -ForegroundColor Cyan
Write-Host "[INIT] InstallScriptRoot: $script:InstallScriptRoot" -ForegroundColor Cyan
Write-Host "[INIT] LocalFilesDir: $script:LocalFilesDir" -ForegroundColor Cyan

# ─── Carica XAML ─────────────────────────────────────────────────────────────
Write-Host "[INIT] Loading XAML file..." -ForegroundColor Cyan
$xamlPath = "$InstallScriptRoot\XAML\installer.xaml"
Write-Host "[INIT] XAML path: $xamlPath" -ForegroundColor Cyan
if (-not (Test-Path $xamlPath)) {
    Write-Host "[ERROR] XAML file not found: $xamlPath" -ForegroundColor Red
    exit
}
$splashXml = Get-Content $xamlPath -Raw -Encoding UTF8
Write-Host "[INIT] XAML content loaded successfully" -ForegroundColor Green

try {
    Write-Host "[INIT] Parsing XAML..." -ForegroundColor Cyan
    $script:w = [Windows.Markup.XamlReader]::Parse($splashXml)
    Write-Host "[INIT] XAML parsed successfully" -ForegroundColor Green
    Write-Host "[INIT] Window object created: $($script:w -ne $null)" -ForegroundColor Cyan
} catch {
    Write-Host "[ERROR] Failed to load UI: $_" -ForegroundColor Red
    Write-Host "[ERROR] Exception details: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "[ERROR] Stack trace: $($_.ScriptStackTrace)" -ForegroundColor Red
    [System.Windows.Forms.MessageBox]::Show("Errore UI: $_`n`nDetails: $($_.Exception.Message)","Errore","OK","Error")
    exit
}

# ─── UI Elements ─────────────────────────────────────────────────────────────
Write-Host "[INIT] Finding UI elements..." -ForegroundColor Cyan

# Check if window was created successfully
if (-not $script:w) {
    Write-Host "[ERROR] Window object is null after XAML parsing" -ForegroundColor Red
    [System.Windows.Forms.MessageBox]::Show("Failed to create window object. XAML parsing may have failed.", "Critical Error", "OK", "Error")
    exit
}

$script:logo             = $script:w.FindName("IMG_INSTALLER_LOGO")
$script:screen1          = $script:w.FindName("Screen1")
$script:screen2          = $script:w.FindName("Screen2")
$script:screen3          = $script:w.FindName("Screen3")
$script:screen4          = $script:w.FindName("Screen4")
$script:btnInstallNow    = $script:w.FindName("BTN_INSTALL_NOW")
$script:btnStartInstall  = $script:w.FindName("BTN_START_INSTALL")
$script:btnInstallAnyway = $script:w.FindName("BTN_INSTALL_ANYWAY")
$script:btnCancelWarn    = $script:w.FindName("BTN_CANCEL_WARN")
$script:btnStartPortable = $script:w.FindName("BTN_START_PORTABLE")
$script:btnBrowse        = $script:w.FindName("BTN_BROWSE")
$script:txtPortablePath  = $script:w.FindName("TXT_PORTABLE_PATH")
$script:btnClose         = $script:w.FindName("BTN_CLOSE")
$script:btnClose2        = $script:w.FindName("BTN_CLOSE2")
$script:btnLaunch        = $script:w.FindName("BTN_LAUNCH")
$script:optNormal        = $script:w.FindName("OPT_NORMAL")
$script:optPortable      = $script:w.FindName("OPT_PORTABLE")
$script:progressPanel    = $script:w.FindName("ProgressPanel")
$script:progressFill     = $script:w.FindName("ProgressFillScale")
$script:statusText       = $script:w.FindName("TXT_INSTALL_STATUS")
$script:completedPanel   = $script:w.FindName("CompletedPanel")
$script:txtCompletedInfo = $script:w.FindName("TXT_COMPLETED_INFO")
$script:btnBack          = $script:w.FindName("BTN_BACK")
$script:txtPercent       = $script:w.FindName("TXT_PERCENT")
# Optional elements that may not exist in all versions
$script:txtLog           = $script:w.FindName("TXT_LOG")
$script:logScroll        = $script:w.FindName("LOG_SCROLL")

Write-Host "[INIT] All UI elements found successfully" -ForegroundColor Green
$script:installPath      = ""
$script:InstallResult    = $null

# ─── Logo ────────────────────────────────────────────────────────────────────
foreach ($p in @("$InstallScriptRoot\ico\platinum.png","$InstallScriptRoot\ico\logo.png","$script:LocalFilesDir\ico\logo.png","$script:LocalFilesDir\ico\platinum.png")) {
    if (Test-Path $p) {
        try {
            $bmp = New-Object System.Windows.Media.Imaging.BitmapImage
            $bmp.BeginInit()
            $bmp.UriSource = New-Object System.Uri((Resolve-Path $p).Path, [System.UriKind]::Absolute)
            $bmp.CacheOption = [System.Windows.Media.Imaging.BitmapCacheOption]::OnLoad
            $bmp.EndInit(); $bmp.Freeze()
            $script:logo.Source = $bmp
            # Also set for completed panel logo
            $script:completedLogo = $script:w.FindName("IMG_COMPLETED_LOGO")
            if ($script:completedLogo) {
                $script:completedLogo.Source = $bmp
            }
            break
        } catch {}
    }
}

# ─── Drag ────────────────────────────────────────────────────────────────────
$script:w.Add_PreviewMouseLeftButtonDown({
    param($s,$e)
    $cur = $e.OriginalSource
    while ($cur) {
        if ($cur -is [System.Windows.Controls.Primitives.ButtonBase] -or
            $cur -is [System.Windows.Controls.TextBox]) { return }
        $cur = if ($cur -is [System.Windows.Media.Visual]) {
            [System.Windows.Media.VisualTreeHelper]::GetParent($cur)
        } else { [System.Windows.LogicalTreeHelper]::GetParent($cur) }
    }
    try { $script:w.DragMove() } catch {}
})

# ─── Chiudi ──────────────────────────────────────────────────────────────────
Write-Host "[INIT] Setting up event handlers..." -ForegroundColor Cyan
$script:btnClose.Add_Click(  { $script:w.Close() })
Write-Host "[INIT] btnClose click handler set" -ForegroundColor Green
$script:btnClose2.Add_Click( { $script:w.Close() })
Write-Host "[INIT] btnClose2 click handler set" -ForegroundColor Green
$script:btnCancelWarn.Add_Click({ $script:w.Close() })
Write-Host "[INIT] btnCancelWarn click handler set" -ForegroundColor Green

$script:btnBack.Add_Click({
    if ($script:screen3.Visibility -eq [System.Windows.Visibility]::Visible -or
        $script:screen4.Visibility -eq [System.Windows.Visibility]::Visible) {
        # Torna a Screen2
        Switch-Screen -From ($script:w.FindName($script:_currentScreenName)) -To $script:screen2 -GoBack $true
        $script:_currentScreenName = "Screen2"
    } else {
        # Torna a Screen1
        Switch-Screen -From $script:screen2 -To $script:screen1 -GoBack $true
        $script:btnBack.Visibility = [System.Windows.Visibility]::Collapsed
        $script:_currentScreenName = "Screen1"
    }
})

if ($script:btnLaunch) {
    $script:btnLaunch.Add_Click({
        $tp = $script:installPath
        Write-Log "[DIRECTORY] Button clicked. Install path: $tp" "Cyan"
        if ($tp -and (Test-Path $tp)) {
            Write-Log "[DIRECTORY] Path exists, opening Explorer..." "Green"
            try {
                explorer.exe $tp
                Write-Log "[DIRECTORY] Explorer launched successfully" "Green"
            } catch {
                Write-Log "[DIRECTORY] Failed to launch Explorer: $_" "Red"
            }
        } else {
            Write-Log "[DIRECTORY] Path does not exist or is empty" "Red"
        }
        $script:w.Close()
    })
}

# ─── Switch-Screen animata ────────────────────────────────────────────────────
$script:_currentScreenName = "Screen1"
$script:_isAnimating = $false
function Switch-Screen {
    param($From, $To, [bool]$GoBack = $false)
    if ($From -eq $To) { return }
    
    # Prevent multiple simultaneous animations
    if ($script:_isAnimating) {
        Write-Log "[ANIMATION] Animation already in progress, ignoring request" "Yellow"
        return
    }
    
    $script:_isAnimating = $true
    
    $script:w.Dispatcher.Invoke([Action]{
        $slideOut = if ($GoBack) { 40 } else { -40 }
        $slideIn  = if ($GoBack) { -40 } else { 40 }
        $script:_sw_From = $From; $script:_sw_To = $To; $script:_sw_SlideIn = $slideIn

        if ($From) {
            $From.IsHitTestVisible = $false
            $From.RenderTransform  = New-Object System.Windows.Media.TranslateTransform
            $sbOut = New-Object System.Windows.Media.Animation.Storyboard
            $fo = New-Object System.Windows.Media.Animation.DoubleAnimation; $fo.To=0; $fo.Duration=[System.Windows.Duration]::new([TimeSpan]::FromMilliseconds(180))
            [System.Windows.Media.Animation.Storyboard]::SetTarget($fo,$From); [System.Windows.Media.Animation.Storyboard]::SetTargetProperty($fo,[System.Windows.PropertyPath]::new("Opacity"))
            $so = New-Object System.Windows.Media.Animation.DoubleAnimation; $so.To=$slideOut; $so.Duration=[System.Windows.Duration]::new([TimeSpan]::FromMilliseconds(200))
            $e1=New-Object System.Windows.Media.Animation.CubicEase; $e1.EasingMode=[System.Windows.Media.Animation.EasingMode]::EaseIn; $so.EasingFunction=$e1
            [System.Windows.Media.Animation.Storyboard]::SetTarget($so,$From); [System.Windows.Media.Animation.Storyboard]::SetTargetProperty($so,[System.Windows.PropertyPath]::new("(UIElement.RenderTransform).(TranslateTransform.X)"))
            $sbOut.Children.Add($fo)|Out-Null; $sbOut.Children.Add($so)|Out-Null; $sbOut.Begin()
        }

        $script:_sw_Timer = New-Object System.Windows.Threading.DispatcherTimer
        $script:_sw_Timer.Interval = [TimeSpan]::FromMilliseconds(185)
        $script:_sw_Timer.Add_Tick({
            $script:_sw_Timer.Stop()
            try {
                if ($script:_sw_From) { $script:_sw_From.Visibility=[System.Windows.Visibility]::Collapsed }
                $script:_sw_To.Opacity=0; $script:_sw_To.Visibility=[System.Windows.Visibility]::Visible
                $script:_sw_To.RenderTransform=New-Object System.Windows.Media.TranslateTransform
                $script:_sw_To.RenderTransform.X=$script:_sw_SlideIn
                $sbIn=New-Object System.Windows.Media.Animation.Storyboard
                $fi=New-Object System.Windows.Media.Animation.DoubleAnimation; $fi.To=1; $fi.Duration=[System.Windows.Duration]::new([TimeSpan]::FromMilliseconds(220))
                [System.Windows.Media.Animation.Storyboard]::SetTarget($fi,$script:_sw_To); [System.Windows.Media.Animation.Storyboard]::SetTargetProperty($fi,[System.Windows.PropertyPath]::new("Opacity"))
                $si=New-Object System.Windows.Media.Animation.DoubleAnimation; $si.From=$script:_sw_SlideIn; $si.To=0; $si.Duration=[System.Windows.Duration]::new([TimeSpan]::FromMilliseconds(220))
                $e2=New-Object System.Windows.Media.Animation.CubicEase; $e2.EasingMode=[System.Windows.Media.Animation.EasingMode]::EaseOut; $si.EasingFunction=$e2
                [System.Windows.Media.Animation.Storyboard]::SetTarget($si,$script:_sw_To); [System.Windows.Media.Animation.Storyboard]::SetTargetProperty($si,[System.Windows.PropertyPath]::new("(UIElement.RenderTransform).(TranslateTransform.X)"))
                $sbIn.Children.Add($fi)|Out-Null; $sbIn.Children.Add($si)|Out-Null; $sbIn.Begin()
                $script:_sw_To.IsHitTestVisible=$true
                
                # Mark animation as complete after slide-in finishes
                $script:_animTimer = New-Object System.Windows.Threading.DispatcherTimer
                $script:_animTimer.Interval = [TimeSpan]::FromMilliseconds(250)
                $script:_animTimer.Add_Tick({
                    $script:_animTimer.Stop()
                    $script:_isAnimating = $false
                })
                $script:_animTimer.Start()
            }
            catch {
                $script:_isAnimating = $false
            }
        })
        $script:_sw_Timer.Start()
    }, [System.Windows.Threading.DispatcherPriority]::Normal)
}

# ─── Installation functions ─────────────────────────────────────────────────────
function Copy-Files {
    param($Source, $Dest)
    Write-Log "[COPY] Copying files from $Source to $Dest" "Cyan"
    if (-not (Test-Path $Dest)) {
        New-Item -ItemType Directory $Dest -Force | Out-Null
    }
    Copy-Item -Path "$Source\*" -Destination $Dest -Recurse -Force
    Write-Log "[COPY] Files copied successfully" "Green"
}

function Create-Shortcut {
    param($Target, $ShortcutPath, $Description, $IconPath)
    $wsh = New-Object -ComObject WScript.Shell
    $shortcut = $wsh.CreateShortcut($ShortcutPath)
    $shortcut.TargetPath = $Target
    $shortcut.Description = $Description
    $shortcut.WorkingDirectory = Split-Path -Parent $Target
    if ($IconPath -and (Test-Path $IconPath)) {
        $shortcut.IconLocation = $IconPath
    }
    $shortcut.Save()
}

function Download-Files {
    param($ServerUrl, $Dest)
    Write-Log "[DOWNLOAD] Downloading Platinum+ Optimizer application package..." "Cyan"
    
    if (-not (Test-Path $Dest)) {
        New-Item -ItemType Directory $Dest -Force | Out-Null
    }
    
    $cb = Get-Random
    $zipUrls = @(
        "https://raw.githubusercontent.com/Aledect/Platinum-Optimizer/main/program/app.zip?v=$cb",
        "https://platinum.optimizer.workers.dev/program/app.zip?v=$cb"
    )
    
    $zipFile = Join-Path $env:TEMP "platinum_app_$cb.zip"
    $downloadSuccess = $false
    
    foreach ($url in $zipUrls) {
        try {
            Write-Log "[DOWNLOAD] Fetching application package from: $url" "Cyan"
            Invoke-WebRequest -Uri $url -OutFile $zipFile -UseBasicParsing -TimeoutSec 45 -ErrorAction Stop
            if ((Test-Path $zipFile) -and ((Get-Item $zipFile).Length -gt 100000)) {
                $downloadSuccess = $true
                break
            }
        } catch {
            Write-Log "[DOWNLOAD] Failed from $url : $_" "Yellow"
        }
    }
    
    if (-not $downloadSuccess) {
        Write-Log "[DOWNLOAD] Could not download application package" "Red"
        return $false
    }
    
    Write-Log "[DOWNLOAD] Extracting application package files..." "Green"
    try {
        Expand-Archive -Path $zipFile -DestinationPath $Dest -Force
        Remove-Item -Path $zipFile -Force -ErrorAction SilentlyContinue
        Write-Log "[DOWNLOAD] Application files successfully extracted to: $Dest" "Green"
        return $true
    } catch {
        Write-Log "[DOWNLOAD] Failed to extract application package: $_" "Red"
        return $false
    }
}

function Get-FileHashExclusions {
    param($Path, $InstallPath)
    
    # Check if file should be excluded from hash calculation
    $relativePath = $Path.Replace($InstallPath, "").TrimStart('\', '/')
    
    # Exclude patterns
    $exclusions = @(
        "*.log",
        "*\log\*",
        "*\temp\*",
        "*\tmp\*",
        "*\backup\*",
        "*\restore\*",
        "*\01_backup\*",
        "*tweak\01_backup\*",
        "*\registry_backup\*",
        "*\reg_backup\*"
    )
    
    foreach ($pattern in $exclusions) {
        if ($relativePath -like $pattern) {
            return $true
        }
    }
    
    # Check if file extension is .log
    if ([System.IO.Path]::GetExtension($Path) -eq ".log") {
        return $true
    }
    
    # Check if path contains backup keywords
    if ($relativePath -match "backup|restore|01_backup|registry_backup|reg_backup") {
        return $true
    }
    
    return $false
}

function Generate-IntegrityCheck {
    param($InstallPath)
    
    Write-Log "[INTEGRITY] Starting integrity check..." "Cyan"
    
    $hashFile = Join-Path $InstallPath "integrity.json"
    $fileHashes = @{}
    
    # Get all files recursively
    $files = Get-ChildItem -Path $InstallPath -Recurse -File -ErrorAction SilentlyContinue
    
    foreach ($file in $files) {
        $relativePath = $file.FullName.Replace($InstallPath, "").TrimStart('\', '/')
        
        # Skip excluded files
        if (Get-FileHashExclusions -Path $file.FullName -InstallPath $InstallPath) {
            Write-Log "[INTEGRITY] Excluded: $relativePath" "DarkGray"
            continue
        }
        
        try {
            $hash = (Get-FileHash -Path $file.FullName -Algorithm SHA256 -ErrorAction Stop).Hash.ToLower()
            $fileHashes[$relativePath] = $hash
            Write-Log "[INTEGRITY] Hashed: $relativePath" "DarkGray"
        } catch {
            Write-Log "[INTEGRITY] Failed to hash: $relativePath" "Yellow"
        }
    }
    
    # Create integrity file
    $integrityData = @{
        Generated = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
        Algorithm = "SHA256"
        Files = $fileHashes
        TotalFiles = $fileHashes.Count
    }
    
    $integrityData | ConvertTo-Json -Depth 10 | Out-File -FilePath $hashFile -Encoding UTF8 -Force
    Write-Log "[INTEGRITY] Integrity check completed. Hashed $($fileHashes.Count) files." "Green"
    Write-Log "[INTEGRITY] Integrity file saved to: $hashFile" "Green"
}

function Test-InstallationStatus {
    param($InstallPath)
    
    Write-Log "[STATUS] Checking installation status..." "Cyan"
    
    # Check if installation folder exists
    if (-not (Test-Path $InstallPath)) {
        return @{ Status = "New"; Message = "New installation" }
    }
    
    # Check if folder is empty
    $totalSize = 0
    try {
        $files = Get-ChildItem -Path $InstallPath -Recurse -File -ErrorAction SilentlyContinue
        foreach ($file in $files) {
            $totalSize += $file.Length
        }
    } catch {
        $totalSize = 0
    }
    
    if ($totalSize -eq 0) {
        return @{ Status = "New"; Message = "Empty folder - New installation" }
    }
    
    # Try to download manifest to check for updates
    try {
        $manifestUrl = "$script:ServerUrl/build/manifest.json"
        $manifest = Invoke-RestMethod -Uri $manifestUrl -UseBasicParsing -TimeoutSec 10
        
        # Check for missing or outdated files
        $missingFiles = 0
        $outdatedFiles = 0
        
        foreach ($file in $manifest.files) {
            $localFilePath = "$InstallPath\$($file.path)"
            
            # Skip excluded files
            if (Get-FileHashExclusions -Path $localFilePath -InstallPath $InstallPath) {
                continue
            }
            
            if (-not (Test-Path $localFilePath)) {
                $missingFiles++
            } else {
                try {
                    $localHash = (Get-FileHash -Path $localFilePath -Algorithm SHA256).Hash.ToLower()
                    if ($localHash -ne $file.hash.ToLower()) {
                        $outdatedFiles++
                    }
                } catch {
                    $missingFiles++
                }
            }
        }
        
        if ($missingFiles -gt 0 -or $outdatedFiles -gt 0) {
            return @{
                Status = "Update"
                Message = "Update available ($missingFiles missing, $outdatedFiles outdated files)"
                MissingFiles = $missingFiles
                OutdatedFiles = $outdatedFiles
            }
        } else {
            return @{
                Status = "Reinstall"
                Message = "Installation is current - Reinstall option"
            }
        }
    } catch {
        Write-Log "[STATUS] Could not check manifest, assuming reinstall" "Yellow"
        return @{ Status = "Reinstall"; Message = "Cannot check updates - Reinstall option" }
    }
}

function Merge-StateJson {
    param($InstallPath, $LocalFilesDir, $FilesFromServer = $false)
    
    $configDir = Join-Path $InstallPath "config"
    $stateJsonPath = Join-Path $configDir "state.json"
    
    if (-not (Test-Path $configDir)) {
        New-Item -ItemType Directory $configDir -Force | Out-Null
    }
    
    # If files from server, state.json is already current
    if ($FilesFromServer) {
        Write-Log "[STATE] Server files, state.json is current" "Green"
        return
    }
    
    # Existing merge logic for local files
    $newStateJsonPath = Join-Path $LocalFilesDir "config\state.json"
    
    Write-Log "[STATE] Checking state.json configuration..." "Cyan"
    
    # If state.json doesn't exist in install path, just copy the new one
    if (-not (Test-Path $stateJsonPath)) {
        if (Test-Path $newStateJsonPath) {
            Copy-Item $newStateJsonPath $stateJsonPath -Force
            Write-Log "[STATE] Created new state.json from source" "Green"
        } else {
            Write-Log "[STATE] No state.json found in source, skipping" "Yellow"
        }
        return
    }
    
    # If new state.json doesn't exist, keep the old one
    if (-not (Test-Path $newStateJsonPath)) {
        Write-Log "[STATE] New state.json not found, keeping existing configuration" "Yellow"
        return
    }
    
    # Both exist, need to merge
    try {
        $oldState = Get-Content $stateJsonPath -Raw | ConvertFrom-Json
        $newState = Get-Content $newStateJsonPath -Raw | ConvertFrom-Json
        
        Write-Log "[STATE] Merging configurations..." "Cyan"
        
        # Merge logic: preserve user's true settings
        $mergedState = @{}
        
        # Start with new state as base
        foreach ($prop in $newState.PSObject.Properties) {
            $mergedState[$prop.Name] = $prop.Value
        }
        
        # Override with old state's true values (preserve user preferences)
        foreach ($prop in $oldState.PSObject.Properties) {
            if ($prop.Value -eq $true) {
                $mergedState[$prop.Name] = $true
                Write-Log "[STATE] Preserved user setting: $($prop.Name) = true" "Green"
            }
        }
        
        # Convert back to JSON and save
        $mergedState | ConvertTo-Json -Depth 10 | Out-File -FilePath $stateJsonPath -Encoding UTF8 -Force
        Write-Log "[STATE] Configuration merged successfully" "Green"
        
    } catch {
        Write-Log "[STATE] Failed to merge state.json: $_" "Red"
        # On error, keep the old state
        Write-Log "[STATE] Keeping existing configuration" "Yellow"
    }
}

# ─── Navigation & Actions ────────────────────────────────────────────────────────
$script:btnInstallNow.Add_Click({
    Switch-Screen -From $script:screen1 -To $script:screen2
    $script:btnBack.Visibility = [System.Windows.Visibility]::Visible
    $script:_currentScreenName = "Screen2"
})

$script:btnStartInstall.Add_Click({
    if ($script:optNormal.IsChecked) {
        # Check installation status
        $targetBase = Join-Path $env:ProgramFiles "Platinum+ Optimizer"
        $status = Test-InstallationStatus -InstallPath $targetBase
        
        Write-Log "[STATUS] Installation status: $($status.Status) - $($status.Message)" "Cyan"
        
        if ($status.Status -eq "New") {
            # New installation - proceed directly
            Start-InstallProcess -IsPortable $false
        } else {
            # Update or Reinstall - show Screen3
            Switch-Screen -From $script:screen2 -To $script:screen3
            $script:_currentScreenName = "Screen3"
            
            # Update screen message based on status
            $message1Text = if ($status.Status -eq "Update") {
                "Updates are available for your installation."
            } else {
                "A previous installation of Platinum+ Optimizer was detected."
            }
            $message2Text = if ($status.Status -eq "Update") {
                $status.Message
            } else {
                $status.Message
            }
            
            # Update XAML elements
            $screen3Message1 = $script:w.FindName("Screen3Message1")
            $screen3Message2 = $script:w.FindName("Screen3Message2")
            $btnInstallAnyway = $script:w.FindName("BTN_INSTALL_ANYWAY")
            
            if ($screen3Message1) { $screen3Message1.Text = $message1Text }
            if ($screen3Message2) { $screen3Message2.Text = $message2Text }
            
            # Update button text based on status
            if ($btnInstallAnyway) {
                if ($status.Status -eq "Update") {
                    $btnInstallAnyway.Content = "UPDATE NOW"
                } else {
                    $btnInstallAnyway.Content = "REINSTALL"
                }
            }
        }
    } else {
        # Portable -> Go to path picker
        $script:txtPortablePath.Text = Join-Path ([System.Environment]::GetFolderPath("UserProfile")) "Downloads\PlatinumPlusPortable"
        Switch-Screen -From $script:screen2 -To $script:screen4
        $script:_currentScreenName = "Screen4"
    }
})

$script:btnInstallAnyway.Add_Click({
    Start-InstallProcess -IsPortable $false -FromScreen $script:screen3
})

$script:btnBrowse.Add_Click({
    $dialog = New-Object System.Windows.Forms.FolderBrowserDialog
    $dialog.Description = "Select Portable Installation Folder"
    $dialog.ShowNewFolderButton = $true
    if ($dialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
        $script:txtPortablePath.Text = Join-Path $dialog.SelectedPath "PlatinumPlusPortable"
    }
})

$script:btnStartPortable.Add_Click({
    Start-InstallProcess -IsPortable $true -PortablePath $script:txtPortablePath.Text -FromScreen $script:screen4
})


function Start-InstallProcess {
    param(
        [bool]$IsPortable,
        [string]$PortablePath = "",
        [System.Windows.UIElement]$FromScreen = $script:screen2
    )

    Write-Log "[INSTALL] Starting installation process..." "Cyan"
    Write-Log "[INSTALL] IsPortable: $IsPortable" "Cyan"
    Write-Log "[INSTALL] PortablePath: $PortablePath" "Cyan"

    # Disable all buttons to prevent premature clicks
    $script:btnInstallNow.IsEnabled = $false
    $script:btnStartInstall.IsEnabled = $false
    $script:btnInstallAnyway.IsEnabled = $false
    $script:btnStartPortable.IsEnabled = $false
    $script:btnBrowse.IsEnabled = $false
    $script:btnBack.IsEnabled = $false

    Switch-Screen -From $FromScreen -To $script:progressPanel
    $script:_currentScreenName = "ProgressPanel"
    $script:btnBack.Visibility  = [System.Windows.Visibility]::Collapsed
    $script:btnClose.Visibility = [System.Windows.Visibility]::Collapsed
    $script:statusText.Text     = "Avvio installazione..."

    Write-Log "[INSTALL] Progress panel shown" "Green"

    # Wait for animation to complete before starting installation
    Start-Sleep -Milliseconds 300
    
    # Force UI refresh before starting installation
    $script:w.Dispatcher.Invoke([Action]{}, [System.Windows.Threading.DispatcherPriority]::ContextIdle)

    if ($script:txtPercent){ $script:txtPercent.Text = "0%" }
    $script:_lastLog = ""

    # Direct installation without runspace
    $success = $false
    $error = $null
    $installPath = ""
    
    try {
        # Define local functions for installation
        function Set-Progress { 
            param($pct, $msg) 
            $script:w.Dispatcher.Invoke([Action]{
                if ($script:progressFill) { $script:progressFill.ScaleX = $pct / 100.0 }
                if ($script:statusText)   { $script:statusText.Text = $msg }
                if ($script:txtPercent)   { $script:txtPercent.Text = "$([int]$pct)%" }
            }, [System.Windows.Threading.DispatcherPriority]::Normal)
            # Force UI refresh
            $script:w.Dispatcher.Invoke([Action]{}, [System.Windows.Threading.DispatcherPriority]::ContextIdle)
            Write-Log "[PROGRESS] Percent: $pct%, Status: $msg" "Cyan"
        }

        # Installation logic
        if ($IsPortable) {
            $installPath = $PortablePath
            Write-Log "[INSTALL] Portable installation to: $installPath" "Cyan"
        } else {
            $installPath = Join-Path $env:ProgramFiles "Platinum+ Optimizer"
            Write-Log "[INSTALL] Normal installation to: $installPath" "Cyan"
        }

        if (-not (Test-Path $installPath)) {
            New-Item -ItemType Directory $installPath -Force | Out-Null
            Write-Log "[INSTALL] Created installation directory" "Green"
        }

        Set-Progress 10 "Copying files..."
        $filesCopied = $false

        if ($script:UseLocalFiles -and (Test-Path $script:LocalFilesDir)) {
            Write-Log "[INSTALL] Installing from local app directory: $script:LocalFilesDir" "Cyan"
            Copy-Files -Source $script:LocalFilesDir -Dest $installPath
            $filesCopied = $true
            Write-Log "[INSTALL] Files successfully copied from local app directory" "Green"
        } elseif ($script:UseServer) {
            Write-Log "[INSTALL] Trying server..." "Cyan"
            $filesCopied = Download-Files -ServerUrl $script:ServerUrl -Dest $installPath
            if ($filesCopied) {
                Write-Log "[INSTALL] Files from server" "Green"
            } else {
                Write-Log "[INSTALL] Server failed, trying local files..." "Yellow"
                if (Test-Path $script:LocalFilesDir) {
                    Copy-Files -Source $script:LocalFilesDir -Dest $installPath
                    $filesCopied = $true
                }
            }
        }

        if (-not $filesCopied) {
            throw "Installation files not found (neither local nor server)"
        }

        Set-Progress 80 "Finalizing installation..."

        if (-not $IsPortable) {
            Set-Progress 85 "Creating shortcuts..."
            $desktopPath = [Environment]::GetFolderPath("Desktop")
            $startMenuPath = Join-Path $env:ProgramData "Microsoft\Windows\Start Menu\Programs"
            $launcher = $null
            foreach ($n in @("run.bat", "run.ps1", "interfaccia_grafica.ps1")) {
                if (Test-Path "$installPath\$n") { $launcher = "$installPath\$n"; break }
            }
            if ($launcher) {
                # Find icon file
                $iconPath = $null
                foreach ($iconFile in @("$installPath\ico\platinum.ico", "$installPath\ico\logo.png", "$script:LocalFilesDir\ico\platinum.ico")) {
                    if (Test-Path $iconFile) { $iconPath = $iconFile; break }
                }
                
                Create-Shortcut -Target $launcher -ShortcutPath "$desktopPath\Platinum+ Optimizer.lnk" -Description "Platinum+ Optimizer" -IconPath $iconPath
                Create-Shortcut -Target $launcher -ShortcutPath "$startMenuPath\Platinum+ Optimizer.lnk" -Description "Platinum+ Optimizer" -IconPath $iconPath
                Create-Shortcut -Target $launcher -ShortcutPath "$installPath\Platinum+ Optimizer.lnk" -Description "Platinum+ Optimizer" -IconPath $iconPath
                Write-Log "[INSTALL] Shortcuts created (Desktop, Start Menu, Installation folder)" "Green"
            }

            Set-Progress 90 "Writing registry keys..."
            $regPath = "HKLM:\SOFTWARE\Platinum+ Optimizer"
            if (-not (Test-Path $regPath)) {
                New-Item -Path $regPath -Force | Out-Null
            }
            Set-ItemProperty -Path $regPath -Name "InstallPath" -Value $installPath -Type String -Force
            Set-ItemProperty -Path $regPath -Name "Version" -Value "0.3.5" -Type String -Force
            Write-Log "[INSTALL] Registry keys written" "Green"

            Set-Progress 95 "Writing uninstaller..."
            $uninstallPath = Join-Path $installPath "uninstall.ps1"
            $uninstallScript = Get-Content "$script:InstallScriptRoot\uninstall.ps1" -Raw -ErrorAction SilentlyContinue
            if (-not $uninstallScript) {
                # Try alternative path for new structure
                $uninstallScript = Get-Content "$script:InstallScriptRoot\..\installer\uninstall.ps1" -Raw -ErrorAction SilentlyContinue
            }
            if ($uninstallScript) {
                $uninstallScript | Out-File -FilePath $uninstallPath -Encoding UTF8 -Force
                Write-Log "[INSTALL] Uninstaller written" "Green"
            }

            # Create batch file wrapper for easy execution
            $batchPath = Join-Path $installPath "uninstall.bat"
            $batchScript = @"
@echo off
setlocal
set "TEMP_UNINSTALL=%TEMP%\platinum_uninstall_%RANDOM%.ps1"
copy "%~dp0uninstall.ps1" "%TEMP_UNINSTALL%" >nul
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%TEMP_UNINSTALL%"
del "%TEMP_UNINSTALL%" >nul 2>&1
endlocal
"@
            $batchScript | Out-File -FilePath $batchPath -Encoding ASCII -Force
            Write-Log "[INSTALL] Uninstaller batch file written" "Green"
        }

        Set-Progress 100 "Installation complete."
        Write-Log "[INSTALL] Installation completed successfully" "Green"
        
        # Generate integrity check
        Set-Progress 100 "Generating integrity check..."
        Generate-IntegrityCheck -InstallPath $installPath
        
        # Merge state.json configuration
        Set-Progress 100 "Merging configuration..."
        Merge-StateJson -InstallPath $installPath -LocalFilesDir $script:LocalFilesDir -FilesFromServer $filesCopied
        
        $success = $true

    } catch {
        $error = $_.Exception.Message
        Write-Log "[ERROR] Installation failed: $error" "Red"
        Write-Log "[ERROR] Exception: $($_.Exception)" "Red"
        $success = $false
    }

    # Show completion or error
    if ($success) {
        if ($script:progressFill) { $script:progressFill.ScaleX = 1.0 }
        if ($script:statusText)   { $script:statusText.Text = "Completato!" }
        if ($script:txtPercent)   { $script:txtPercent.Text = "100%" }
        
        # Save install path to script variable for DIRECTORY button
        $script:installPath = $installPath
        Write-Log "[INSTALL] Saved install path to script variable: $script:installPath" "Green"
        
        Switch-Screen -From $script:progressPanel -To $script:completedPanel
        $script:_currentScreenName = "CompletedPanel"
        $script:btnClose.Visibility = [System.Windows.Visibility]::Visible
        
        # Always show DIRECTORY button when installation succeeds
        if ($script:btnLaunch) {
            $script:btnLaunch.Visibility = [System.Windows.Visibility]::Visible
        }
        if ($script:txtCompletedInfo) {
            $script:txtCompletedInfo.Text = "Platinum+ Optimizer is ready."
        }
        
        # Re-enable navigation buttons
        $script:btnClose.IsEnabled = $true
    } else {
        Switch-Screen -From $script:progressPanel -To $script:screen2 -GoBack $true
        $script:_currentScreenName = "Screen2"
        $script:btnClose.Visibility = [System.Windows.Visibility]::Visible
        $script:btnBack.Visibility  = [System.Windows.Visibility]::Visible
        
        # Re-enable all buttons for retry
        $script:btnInstallNow.IsEnabled = $true
        $script:btnStartInstall.IsEnabled = $true
        $script:btnInstallAnyway.IsEnabled = $true
        $script:btnStartPortable.IsEnabled = $true
        $script:btnBrowse.IsEnabled = $true
        $script:btnBack.IsEnabled = $true
        $script:btnClose.IsEnabled = $true
        
        [System.Windows.Forms.MessageBox]::Show("Installation failed:`n$error", "Error", "OK", "Error")
    }
}

# ─── Mostra finestra ──────────────────────────────────────────────────────────
Write-Host "[INIT] Showing installer window..." -ForegroundColor Cyan
Write-Host "[INIT] Window object check: $($script:w -ne $null)" -ForegroundColor Cyan
Write-Host "[INIT] Window type: $($script:w.GetType().FullName)" -ForegroundColor Cyan

# Stop any running timers before showing dialog
if ($script:_sw_Timer) { $script:_sw_Timer.Stop() }
if ($script:_animTimer) { $script:_animTimer.Stop() }

# Ensure window object stays alive
$script:w = $script:w
[GC]::Collect()
[GC]::WaitForPendingFinalizers()

# Add fade-in animation on window load
$script:w.Add_Loaded({
    Write-Host "[INIT] Window loaded, starting fade-in animation" -ForegroundColor Cyan
    try {
        $installRoot = $script:w.FindName("INSTALL_ROOT")
        $screen1 = $script:w.FindName("Screen1")
        
        if ($installRoot) {
            $installRoot.Opacity = 0
            $sbRoot = New-Object System.Windows.Media.Animation.Storyboard
            $animRoot = New-Object System.Windows.Media.Animation.DoubleAnimation
            $animRoot.From = 0
            $animRoot.To = 1
            $animRoot.Duration = [System.Windows.Duration]::new([TimeSpan]::FromMilliseconds(800))
            [System.Windows.Media.Animation.Storyboard]::SetTarget($animRoot, $installRoot)
            [System.Windows.Media.Animation.Storyboard]::SetTargetProperty($animRoot, [System.Windows.PropertyPath]::new("Opacity"))
            $sbRoot.Children.Add($animRoot)
            $sbRoot.Begin()
        }
        
        if ($screen1) {
            $screen1.Opacity = 0
            $sbScreen = New-Object System.Windows.Media.Animation.Storyboard
            $animScreen = New-Object System.Windows.Media.Animation.DoubleAnimation
            $animScreen.From = 0
            $animScreen.To = 1
            $animScreen.Duration = [System.Windows.Duration]::new([TimeSpan]::FromMilliseconds(1200))
            $animScreen.BeginTime = [TimeSpan]::FromMilliseconds(200)
            [System.Windows.Media.Animation.Storyboard]::SetTarget($animScreen, $screen1)
            [System.Windows.Media.Animation.Storyboard]::SetTargetProperty($animScreen, [System.Windows.PropertyPath]::new("Opacity"))
            $sbScreen.Children.Add($animScreen)
            $sbScreen.Begin()
        }
    } catch {
        Write-Host "[WARN] Fade-in animation failed: $_" -ForegroundColor Yellow
    }
})

try {
    Write-Host "[INIT] Attempting ShowDialog..." -ForegroundColor Cyan
    $result = $script:w.ShowDialog()
    Write-Host "[INIT] Installer window closed with result: $result" -ForegroundColor Green
} catch {
    Write-Host "[ERROR] Failed to show window: $_" -ForegroundColor Red
    Write-Host "[ERROR] Exception: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "[ERROR] Window object is null: $($script:w -eq $null)" -ForegroundColor Red
    Write-Host "[ERROR] Inner exception: $($_.Exception.InnerException)" -ForegroundColor Red
    [System.Windows.Forms.MessageBox]::Show("Failed to show installer window:`n$($_.Exception.Message)`n`nInner: $($_.Exception.InnerException)", "Error", "OK", "Error")
}
