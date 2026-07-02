# Platinum+ Optimizer Installer
# Self-contained installer with WPF GUI (matching Platinum+ Optimizer style)
[System.Diagnostics.Process]::GetCurrentProcess().PriorityClass = [System.Diagnostics.ProcessPriorityClass]::High
Add-Type -AssemblyName PresentationFramework, PresentationCore, WindowsBase, System.Windows.Forms, System.Drawing
[System.Windows.Forms.Application]::EnableVisualStyles()

# Determine script root
if ($MyInvocation.MyCommand.Path) {
    $script:InstallScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
} else {
    $script:InstallScriptRoot = Join-Path $env:TEMP "PlatinumInstallerCache"
    if (-not (Test-Path $script:InstallScriptRoot)) {
        New-Item -ItemType Directory -Path $script:InstallScriptRoot -Force | Out-Null
    }
    
    $xamlDir = Join-Path $script:InstallScriptRoot "XAML"
    $icoDir = Join-Path $script:InstallScriptRoot "ico"
    if (-not (Test-Path $xamlDir)) { New-Item -ItemType Directory -Path $xamlDir -Force | Out-Null }
    if (-not (Test-Path $icoDir)) { New-Item -ItemType Directory -Path $icoDir -Force | Out-Null }

    Write-Host "Downloading installer assets to cache..."
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    Invoke-WebRequest -Uri "https://platinum.optimizer.workers.dev/program/XAML/installer.xaml" -OutFile "$xamlDir\installer.xaml" -UseBasicParsing
    Invoke-WebRequest -Uri "https://platinum.optimizer.workers.dev/program/ico/logo.png" -OutFile "$icoDir\logo.png" -UseBasicParsing -ErrorAction SilentlyContinue
    Invoke-WebRequest -Uri "https://platinum.optimizer.workers.dev/program/ico/platinum.png" -OutFile "$icoDir\platinum.png" -UseBasicParsing -ErrorAction SilentlyContinue
}
# Load XAML
$splashXml = Get-Content "$InstallScriptRoot\XAML\installer.xaml" -Raw -Encoding UTF8
$reader = [System.Xml.XmlReader]::Create([System.IO.StringReader]$splashXml)
try {
    $script:w = [Windows.Markup.XamlReader]::Load($reader)
} catch {
    [System.Windows.Forms.MessageBox]::Show("Failed to load installer interface: $_", "Error", "OK", "Error")
    return
} finally {
    $reader.Close()
}

# Get UI elements
$script:root = $script:w.FindName("INSTALL_ROOT")
$script:dragArea = $script:w.FindName("DragArea")
$script:logo = $script:w.FindName("IMG_INSTALLER_LOGO")
$script:screen1 = $script:w.FindName("Screen1")
$script:screen2 = $script:w.FindName("Screen2")
$script:btnInstallNow = $script:w.FindName("BTN_INSTALL_NOW")
$script:btnStartInstall = $script:w.FindName("BTN_START_INSTALL")
$script:btnClose = $script:w.FindName("BTN_CLOSE")
$script:btnClose2 = $script:w.FindName("BTN_CLOSE2")
$script:btnLaunch = $script:w.FindName("BTN_LAUNCH")
$script:optNormal = $script:w.FindName("OPT_NORMAL")
$script:optPortable = $script:w.FindName("OPT_PORTABLE")
$script:optionsPanel = $script:w.FindName("OptionsPanel")
$script:progressPanel = $script:w.FindName("ProgressPanel")
$script:progressBar = $script:w.FindName("INSTALL_PROGRESS")
$script:progressFill = $script:w.FindName("ProgressFillScale")
$script:statusText = $script:w.FindName("TXT_INSTALL_STATUS")
$script:completedPanel = $script:w.FindName("CompletedPanel")
$script:txtCompletedInfo = $script:w.FindName("TXT_COMPLETED_INFO")
$script:btnBack = $script:w.FindName("BTN_BACK")

# Set logo source - try multiple locations
$logoFound = $false
$logoPaths = @(
    "$InstallScriptRoot\ico\platinum.png",
    "$InstallScriptRoot\ico\logo.png"
)

foreach ($path in $logoPaths) {
    if (Test-Path $path) {
        try {
            $bitmapImage = New-Object System.Windows.Media.Imaging.BitmapImage
            $bitmapImage.BeginInit()
            $resolvedPath = (Resolve-Path $path).Path
            $bitmapImage.UriSource = New-Object System.Uri($resolvedPath, [System.UriKind]::Absolute)
            $bitmapImage.CacheOption = [System.Windows.Media.Imaging.BitmapCacheOption]::OnLoad
            $bitmapImage.EndInit()
            $bitmapImage.Freeze()
            $script:logo.Source = $bitmapImage
            $logoFound = $true
            Write-Host "Logo loaded from: $path"
            break
        } catch {
            Write-Host "Failed to load logo from $path : $_"
        }
    }
}

if (-not $logoFound) {
    Write-Host "Warning: No logo file found in $InstallScriptRoot\ico\"
}

# Global drag support - intercept BEFORE children (Preview = tunneling)
$script:w.Add_PreviewMouseLeftButtonDown({
    param($sender, $e)
    # Walk up the visual tree from click source to check for interactive elements
    $isInteractive = $false
    $current = $e.OriginalSource
    while ($current -ne $null) {
        if ($current -is [System.Windows.Controls.Primitives.ButtonBase] -or
            $current -is [System.Windows.Controls.Primitives.Thumb] -or
            $current -is [System.Windows.Controls.TextBox] -or
            $current -is [System.Windows.Controls.ComboBox]) {
            $isInteractive = $true
            break
        }
        if ($current -is [System.Windows.Media.Visual] -or $current -is [System.Windows.Media.Media3D.Visual3D]) {
            $current = [System.Windows.Media.VisualTreeHelper]::GetParent($current)
        } else {
            $current = [System.Windows.LogicalTreeHelper]::GetParent($current)
        }
    }

    if (-not $isInteractive) {
        try {
            $script:w.DragMove()
        } catch {}
    }
})

# Close handlers
$script:btnClose.Add_Click({ $script:w.Close() })
$script:btnClose2.Add_Click({ $script:w.Close() })

# Back button handler - return to Screen1
$script:btnBack.Add_Click({
    Switch-Screen -From $script:screen2 -To $script:screen1 -GoBack $true
    $script:btnBack.Visibility = [System.Windows.Visibility]::Collapsed
})

# Launch button
$script:btnLaunch.Add_Click({
    $targetPath = $script:installPath
    if ($targetPath -and (Test-Path "$targetPath\interfaccia_grafica.ps1")) {
        try {
            Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$targetPath\interfaccia_grafica.ps1`"" -WindowStyle Normal
        } catch {
            [System.Windows.Forms.MessageBox]::Show("Could not launch Platinum+: $_", "Launch Error", "OK", "Warning")
        }
    }
    $script:w.Close()
})

# --- Install logic ---
$script:installPath = ""

# Helper: animated screen transition (fade + slide)
function Switch-Screen {
    param($From, $To, [bool]$GoBack = $false)

    $script:w.Dispatcher.Invoke([Action]{
        $slideOut = if ($GoBack) { 40 } else { -40 }
        $slideIn  = if ($GoBack) { -40 } else { 40 }

        # Store in script scope so the Tick closure can reach them
        $script:_sw_From    = $From
        $script:_sw_To      = $To
        $script:_sw_SlideIn = $slideIn

        # Animate OUT current panel
        if ($From -ne $null) {
            $From.IsHitTestVisible = $false
            $From.RenderTransform = New-Object System.Windows.Media.TranslateTransform

            $sbOut = New-Object System.Windows.Media.Animation.Storyboard

            $fadeOut = New-Object System.Windows.Media.Animation.DoubleAnimation
            $fadeOut.To = 0
            $fadeOut.Duration = [System.Windows.Duration]::new([TimeSpan]::FromMilliseconds(180))
            [System.Windows.Media.Animation.Storyboard]::SetTarget($fadeOut, $From)
            [System.Windows.Media.Animation.Storyboard]::SetTargetProperty($fadeOut, [System.Windows.PropertyPath]::new("Opacity"))

            $slideOutAnim = New-Object System.Windows.Media.Animation.DoubleAnimation
            $slideOutAnim.To = $slideOut
            $slideOutAnim.Duration = [System.Windows.Duration]::new([TimeSpan]::FromMilliseconds(200))
            $ease = New-Object System.Windows.Media.Animation.CubicEase
            $ease.EasingMode = [System.Windows.Media.Animation.EasingMode]::EaseIn
            $slideOutAnim.EasingFunction = $ease
            [System.Windows.Media.Animation.Storyboard]::SetTarget($slideOutAnim, $From)
            [System.Windows.Media.Animation.Storyboard]::SetTargetProperty($slideOutAnim, [System.Windows.PropertyPath]::new("(UIElement.RenderTransform).(TranslateTransform.X)"))

            $sbOut.Children.Add($fadeOut)    | Out-Null
            $sbOut.Children.Add($slideOutAnim) | Out-Null
            $sbOut.Begin()
        }

        # After OUT animation completes, animate IN the new panel
        $script:_sw_Timer = New-Object System.Windows.Threading.DispatcherTimer
        $script:_sw_Timer.Interval = [TimeSpan]::FromMilliseconds(185)
        $script:_sw_Timer.Add_Tick({
            $script:_sw_Timer.Stop()

            if ($script:_sw_From -ne $null) {
                $script:_sw_From.Visibility = [System.Windows.Visibility]::Collapsed
            }

            $script:_sw_To.Opacity = 0
            $script:_sw_To.Visibility = [System.Windows.Visibility]::Visible
            $script:_sw_To.RenderTransform = New-Object System.Windows.Media.TranslateTransform
            $script:_sw_To.RenderTransform.X = $script:_sw_SlideIn

            $sbIn = New-Object System.Windows.Media.Animation.Storyboard

            $fadeIn = New-Object System.Windows.Media.Animation.DoubleAnimation
            $fadeIn.To = 1
            $fadeIn.Duration = [System.Windows.Duration]::new([TimeSpan]::FromMilliseconds(220))
            [System.Windows.Media.Animation.Storyboard]::SetTarget($fadeIn, $script:_sw_To)
            [System.Windows.Media.Animation.Storyboard]::SetTargetProperty($fadeIn, [System.Windows.PropertyPath]::new("Opacity"))

            $slideInAnim = New-Object System.Windows.Media.Animation.DoubleAnimation
            $slideInAnim.From = $script:_sw_SlideIn
            $slideInAnim.To   = 0
            $slideInAnim.Duration = [System.Windows.Duration]::new([TimeSpan]::FromMilliseconds(220))
            $easeIn = New-Object System.Windows.Media.Animation.CubicEase
            $easeIn.EasingMode = [System.Windows.Media.Animation.EasingMode]::EaseOut
            $slideInAnim.EasingFunction = $easeIn
            [System.Windows.Media.Animation.Storyboard]::SetTarget($slideInAnim, $script:_sw_To)
            [System.Windows.Media.Animation.Storyboard]::SetTargetProperty($slideInAnim, [System.Windows.PropertyPath]::new("(UIElement.RenderTransform).(TranslateTransform.X)"))

            $sbIn.Children.Add($fadeIn)      | Out-Null
            $sbIn.Children.Add($slideInAnim) | Out-Null
            $sbIn.Begin()

            $script:_sw_To.IsHitTestVisible = $true
        })
        $script:_sw_Timer.Start()

    }, [System.Windows.Threading.DispatcherPriority]::Normal)
}

function Update-Progress {
    param([double]$Percent, [string]$Status)
    $script:w.Dispatcher.Invoke([Action]{
        if ($script:progressFill) {
            $script:progressFill.ScaleX = $Percent / 100.0
        }
        if ($script:statusText) {
            $script:statusText.Text = $Status
        }
        $script:w.InvalidateVisual()
    }, [System.Windows.Threading.DispatcherPriority]::Normal)
}

function Download-FromManifest {
    param([string]$ManifestUrl, [string]$Dest, [string]$Label, [double]$StartPct, [double]$EndPct)
    
    Update-Progress -Percent $StartPct -Status "Downloading manifest..."
    try {
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        $manifest = Invoke-RestMethod -Uri $ManifestUrl -UseBasicParsing
    } catch {
        throw "Failed to download manifest from $ManifestUrl : $_"
    }
    
    $total = $manifest.files.Count
    $current = 0
    $range = $EndPct - $StartPct
    
    foreach ($file in $manifest.files) {
        $current++
        $pct = $StartPct + ($current / $total * $range)
        
        if ($current % 5 -eq 0 -or $current -eq $total) {
            Update-Progress -Percent $pct -Status "${Label}: $($file.path)"
        }
        
        $destPath = Join-Path -Path $Dest -ChildPath $file.path
        $destDir = Split-Path -Parent $destPath
        if (-not (Test-Path $destDir)) {
            New-Item -ItemType Directory -Path $destDir -Force | Out-Null
        }
        
        $fileUrl = "$($manifest.baseUrl)$($file.path)"
        Invoke-WebRequest -Uri $fileUrl -OutFile $destPath -UseBasicParsing
    }
    
    # Download updater.ps1 as well
    Update-Progress -Percent $EndPct -Status "Downloading updater.ps1..."
    $baseUrl = $ManifestUrl.Substring(0, $ManifestUrl.LastIndexOf('/'))
    Invoke-WebRequest -Uri "$baseUrl/updater.ps1" -OutFile (Join-Path $Dest "updater.ps1") -UseBasicParsing -ErrorAction SilentlyContinue
    
    Update-Progress -Percent $EndPct -Status "${Label} complete."
}

function Install-Normal {
    $targetBase = Join-Path -Path $env:ProgramFiles -ChildPath "Platinum+ Optimizer"
    $script:installPath = $targetBase
    
    Update-Progress -Percent 2 -Status "Creating installation directory..."
    
    if (Test-Path $targetBase) {
        Remove-Item -Path $targetBase -Recurse -Force -ErrorAction SilentlyContinue
    }
    New-Item -ItemType Directory -Path $targetBase -Force | Out-Null
    
    Update-Progress -Percent 5 -Status "Downloading program files..."
    Download-FromManifest -ManifestUrl "https://platinum.optimizer.workers.dev/program/manifest-setup.json" -Dest $targetBase -Label "Downloading files" -StartPct 5 -EndPct 70
    
    # Create config to mark as installed
    @{ 
        InstallType = "Normal"
        InstallDate = [DateTime]::Now.ToString("yyyy-MM-dd HH:mm:ss")
        Version = "1.0.0"
    } | ConvertTo-Json | Out-File -FilePath "$targetBase\install_config.json" -Encoding UTF8
    
    Update-Progress -Percent 75 -Status "Creating Start Menu shortcut..."
    
    # Start Menu shortcut
    $startMenu = [System.Environment]::GetFolderPath("CommonPrograms")
    $shortcutDir = Join-Path -Path $startMenu -ChildPath "Platinum+ Optimizer"
    if (-not (Test-Path $shortcutDir)) {
        New-Item -ItemType Directory -Path $shortcutDir -Force | Out-Null
    }
    
    $shortcutPath = Join-Path -Path $shortcutDir -ChildPath "Platinum+ Optimizer.lnk"
    $shell = New-Object -ComObject WScript.Shell
    $shortcut = $shell.CreateShortcut($shortcutPath)
    $shortcut.TargetPath = "powershell.exe"
    $shortcut.Arguments = "-NoProfile -ExecutionPolicy Bypass -File `"$targetBase\interfaccia_grafica.ps1`""
    $shortcut.WorkingDirectory = $targetBase
    $shortcut.Description = "Platinum+ Optimizer - System Performance Tuner"
    
    # Try to use logo for icon
    $icoPath = "$targetBase\logo.png"
    if (Test-Path $icoPath) {
        $shortcut.IconLocation = "powershell.exe,0"
    }
    $shortcut.Save()
    
    Update-Progress -Percent 82 -Status "Creating Desktop shortcut..."
    
    # Desktop shortcut
    $desktop = [System.Environment]::GetFolderPath("CommonDesktopDirectory")
    $desktopShortcut = Join-Path -Path $desktop -ChildPath "Platinum+ Optimizer.lnk"
    $deskSc = $shell.CreateShortcut($desktopShortcut)
    $deskSc.TargetPath = "powershell.exe"
    $deskSc.Arguments = "-NoProfile -ExecutionPolicy Bypass -File `"$targetBase\interfaccia_grafica.ps1`""
    $deskSc.WorkingDirectory = $targetBase
    $deskSc.Description = "Platinum+ Optimizer - System Performance Tuner"
    $deskSc.Save()
    
    Update-Progress -Percent 88 -Status "Adding to Add/Remove Programs..."
    
    # Registry for uninstall
    $uninstallKey = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Platinum+ Optimizer"
    if (-not (Test-Path $uninstallKey)) {
        New-Item -Path $uninstallKey -Force | Out-Null
    }
    Set-ItemProperty -Path $uninstallKey -Name "DisplayName" -Value "Platinum+ Optimizer"
    Set-ItemProperty -Path $uninstallKey -Name "UninstallString" -Value "`"$targetBase\uninstall.ps1`""
    Set-ItemProperty -Path $uninstallKey -Name "InstallLocation" -Value $targetBase
    Set-ItemProperty -Path $uninstallKey -Name "DisplayIcon" -Value "powershell.exe,0"
    Set-ItemProperty -Path $uninstallKey -Name "Publisher" -Value "Platinum+ Team"
    Set-ItemProperty -Path $uninstallKey -Name "DisplayVersion" -Value "1.0.0"
    Set-ItemProperty -Path $uninstallKey -Name "NoModify" -Value 1
    Set-ItemProperty -Path $uninstallKey -Name "NoRepair" -Value 1
    
    # Create uninstall script
    $regUninstallPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Platinum+ Optimizer"
    $target = $targetBase
    $uninstallContent = @"
# Platinum+ Optimizer Uninstaller
`$target = "$target"
if (Test-Path `$target) {
    Remove-Item -Path `$target -Recurse -Force
}
# Remove shortcuts
`$desktop = [System.Environment]::GetFolderPath("CommonDesktopDirectory")
`$desktopSc = Join-Path `$desktop "Platinum+ Optimizer.lnk"
if (Test-Path `$desktopSc) { Remove-Item `$desktopSc -Force }

`$startMenu = [System.Environment]::GetFolderPath("CommonPrograms")
`$smDir = Join-Path `$startMenu "Platinum+ Optimizer"
if (Test-Path `$smDir) { Remove-Item `$smDir -Recurse -Force }

# Remove registry
Remove-Item '$regUninstallPath' -Force -ErrorAction SilentlyContinue
Write-Host "Platinum+ Optimizer has been uninstalled." -ForegroundColor Green
"@
    $uninstallContent | Out-File -FilePath "$targetBase\uninstall.ps1" -Encoding UTF8
    
    Update-Progress -Percent 100 -Status "Installation complete!"
}

function Install-Portable {
    $folderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
    $folderBrowser.Description = "Select destination folder for Platinum+ Optimizer Portable"
    $folderBrowser.ShowNewFolderButton = $true
    
    if ([System.Windows.Forms.Application]::OpenForms.Count -eq 0) {
        # Hide our WPF window temporarily for the folder dialog
        $script:w.WindowState = [System.Windows.WindowState]::Minimized
    }
    
    $result = $folderBrowser.ShowDialog()
    $script:w.WindowState = [System.Windows.WindowState]::Normal
    
    if ($result -ne [System.Windows.Forms.DialogResult]::OK) {
        $script:w.Dispatcher.Invoke([Action]{
            $script:progressPanel.Visibility = [System.Windows.Visibility]::Collapsed
            $script:screen2.Visibility = [System.Windows.Visibility]::Visible
            $script:optNormal.IsEnabled = $true
            $script:optPortable.IsEnabled = $true
            $script:btnClose.Visibility = [System.Windows.Visibility]::Visible
        })
        return $false
    }
    
    $targetBase = $folderBrowser.SelectedPath
    $script:installPath = $targetBase
    
    Update-Progress -Percent 2 -Status "Preparing portable installation..."
    
    if (Test-Path "$targetBase\Platinum+_Portable") {
        Remove-Item "$targetBase\Platinum+_Portable" -Recurse -Force -ErrorAction SilentlyContinue
    }
    $targetDir = "$targetBase\Platinum+_Portable"
    New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
    
    Update-Progress -Percent 10 -Status "Downloading portable files..."
    Download-FromManifest -ManifestUrl "https://platinum.optimizer.workers.dev/program/manifest-portable.json" -Dest $targetDir -Label "Downloading files" -StartPct 10 -EndPct 90
    
    # Create portable config
    @{ 
        InstallType = "Portable"
        InstallDate = [DateTime]::Now.ToString("yyyy-MM-dd HH:mm:ss")
        Version = "1.0.0"
        Location = $targetDir
    } | ConvertTo-Json | Out-File -FilePath "$targetDir\portable_config.json" -Encoding UTF8
    
    # Create a launcher script on desktop
    Update-Progress -Percent 92 -Status "Creating launcher shortcut..."
    
    $desktop = [System.Environment]::GetFolderPath("Desktop")
    $launchPath = "$targetDir\interfaccia_grafica.ps1"
    
    if (Test-Path $launchPath) {
        $shell = New-Object -ComObject WScript.Shell
        $shortcutPath = Join-Path -Path $desktop -ChildPath "Platinum+ Optimizer Portable.lnk"
        $shortcut = $shell.CreateShortcut($shortcutPath)
        $shortcut.TargetPath = "powershell.exe"
        $shortcut.Arguments = "-NoProfile -ExecutionPolicy Bypass -File `"$launchPath`""
        $shortcut.WorkingDirectory = $targetDir
        $shortcut.Description = "Platinum+ Optimizer Portable"
        $shortcut.Save()
    }
    
    Update-Progress -Percent 100 -Status "Portable installation complete!"
    return $true
}

# Screen transition
$script:btnInstallNow.Add_Click({
    Switch-Screen -From $script:screen1 -To $script:screen2
    $script:btnBack.Visibility = [System.Windows.Visibility]::Visible
})

# Install button click
$script:btnStartInstall.Add_Click({
    # Disable options
    $script:optNormal.IsEnabled = $false
    $script:optPortable.IsEnabled = $false
    $script:btnBack.Visibility = [System.Windows.Visibility]::Collapsed
    $script:btnClose.Visibility = [System.Windows.Visibility]::Collapsed

    Switch-Screen -From $script:screen2 -To $script:progressPanel
    $script:statusText.Text = "Starting installation..."

    # Run installation in background
    $isPortable = $script:optPortable.IsChecked

    $installJob = [System.Threading.Tasks.Task]::Run({
        if ($isPortable) {
            $result = Install-Portable
            return @{ Success = $result; Portable = $true }
        } else {
            try {
                Install-Normal
                return @{ Success = $true; Portable = $false }
            } catch {
                return @{ Success = $false; Error = $_.Exception.Message; Portable = $false }
            }
        }
    })

    # Wait for completion
    $timer = New-Object System.Windows.Threading.DispatcherTimer
    $timer.Interval = [TimeSpan]::FromMilliseconds(200)
    $timer.Add_Tick({
        if ($installJob.IsCompleted) {
            $timer.Stop()
            $result = $installJob.Result

            $script:w.Dispatcher.Invoke([Action]{
                if ($result.Success) {
                    Switch-Screen -From $script:progressPanel -To $script:completedPanel
                    if ($result.Portable) {
                        $script:txtCompletedInfo.Text = "Platinum has been deployed portably to:`n$script:installPath\Platinum+_Portable"
                    } else {
                        $script:txtCompletedInfo.Text = "Platinum has been installed to Program Files.`nYou can find it in the Start Menu."
                    }
                } else {
                    Switch-Screen -From $script:progressPanel -To $script:screen2 -GoBack $true
                    $script:statusText.Text = "Installation failed: $($result.Error)"
                    $script:optNormal.IsEnabled = $true
                    $script:optPortable.IsEnabled = $true
                    $script:btnClose.Visibility = [System.Windows.Visibility]::Visible
                    $script:btnBack.Visibility = [System.Windows.Visibility]::Visible
                    [System.Windows.Forms.MessageBox]::Show("Installation failed: $($result.Error)", "Error", "OK", "Error")
                }
            }, [System.Windows.Threading.DispatcherPriority]::Normal)
        }
    })
    $timer.Start()
})

# Show window
$script:w.ShowDialog() | Out-Null