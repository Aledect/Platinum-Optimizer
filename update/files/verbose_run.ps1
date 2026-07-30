# Platinum+ Optimizer - Verbose Mode (Console Visible)
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if (-not $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    $scriptFile = if ($PSCommandPath) { $PSCommandPath } elseif ($MyInvocation.MyCommand.Path) { $MyInvocation.MyCommand.Path } else { "$PSScriptRoot\verbose_run.ps1" }
    $psi = New-Object System.Diagnostics.ProcessStartInfo
    $psi.FileName = "powershell.exe"
    $psi.Arguments = "-NoProfile -ExecutionPolicy Bypass -File `"$scriptFile`""
    $psi.Verb = "runas"
    [System.Diagnostics.Process]::Start($psi) | Out-Null
    Exit
}

$ErrorActionPreference = "Continue"
[System.Diagnostics.Process]::GetCurrentProcess().PriorityClass = [System.Diagnostics.ProcessPriorityClass]::High
Add-Type -AssemblyName PresentationFramework, PresentationCore, WindowsBase
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing


# Set explicit AppUserModelID so it doesn't group with generic powershell.exe windows in the taskbar
# NOTE: Console window is NOT hidden in verbose mode for debugging
try {
    if ($null -eq ("ShellHelper" -as [type])) {
        $source = @"
using System;
using System.Runtime.InteropServices;

public class ShellHelper {
    [DllImport("shell32.dll", SetLastError = true)]
    public static extern int SetCurrentProcessExplicitAppUserModelID([MarshalAs(UnmanagedType.LPWStr)] string AppID);

    [DllImport("kernel32.dll")]
    public static extern IntPtr GetConsoleWindow();

    [DllImport("user32.dll")]
    public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
}
"@
        Add-Type -TypeDefinition $source -ErrorAction SilentlyContinue
    }
    [ShellHelper]::SetCurrentProcessExplicitAppUserModelID("Platinum.Optimizer")

    # CONSOLE NOT HIDDEN IN VERBOSE MODE - Commented out for debugging
    # $hWnd = [ShellHelper]::GetConsoleWindow()
    # if ($hWnd -ne [System.IntPtr]::Zero) {
    #     [ShellHelper]::ShowWindow($hWnd, 0) # 0 = SW_HIDE
    # }
    Write-Host "=== Platinum+ Optimizer - Verbose Mode Started ===" -ForegroundColor Cyan
    Write-Host "Console window visible for debugging purposes" -ForegroundColor Yellow
} catch {
    Write-Host "Error setting up shell helper: $_" -ForegroundColor Red
}

# Determine root path
if ($PS2EXE -or ($MyInvocation.MyCommand.Path -eq $null)) {
    $script:ModuleRoot = [System.AppDomain]::CurrentDomain.BaseDirectory.TrimEnd('\')
} else {
    $script:ModuleRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
}

Write-Host "Module Root: $ModuleRoot" -ForegroundColor Green

# Quick silent update check. If the network or endpoint is unavailable, the updater exits without blocking startup.
try {
    $programRoot = Split-Path -Parent $script:ModuleRoot
    $updaterPath = Join-Path $programRoot "updater\updater.ps1"
    if (Test-Path -LiteralPath $updaterPath) {
        Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$updaterPath`" -AppPath `"$script:ModuleRoot`" -StartupCheck -NoRestart" -WorkingDirectory $programRoot -WindowStyle Hidden
    }
} catch {}

# Load variables first to define paths
Write-Host "Loading variables..." -ForegroundColor Cyan
. "$ModuleRoot\modules\variables.ps1"

# Load Splash Screen instantly
Write-Host "Loading splash screen..." -ForegroundColor Cyan
$splashXml = Get-Content "$ModuleRoot\XAML\splash.xaml" -Raw -Encoding UTF8
$script:splash = [Windows.Markup.XamlReader]::Load([System.Xml.XmlReader]::Create([System.IO.StringReader]$splashXml))
try { $script:splash.FindName("IMG_SPLASH_LOGO").Source = $global:LogoPath } catch {}
try {
    if ($global:AppIcon -and (Test-Path $global:AppIcon)) {
        $script:splash.Icon = [System.Windows.Media.Imaging.BitmapFrame]::Create($global:AppIcon)
    }
} catch {}
$script:splash.WindowStartupLocation = 'CenterScreen'
$script:splash.Topmost = $true
$script:splash.Show()
$script:SplashStartTime = [DateTime]::Now

$script:statusText = $script:splash.FindName("TXT_SPLASH_STATUS")
if ($script:statusText) { $script:statusText.Text = "Loading core engine..." }
[System.Windows.Forms.Application]::DoEvents()

# Load modules in dependency order
Write-Host "Loading core engine..." -ForegroundColor Cyan
. "$ModuleRoot\modules\core_engine.ps1"

if ($script:statusText) { $script:statusText.Text = "Loading XAML layout..." }
[System.Windows.Forms.Application]::DoEvents()

# Load the XAML layout
Write-Host "Loading XAML layout..." -ForegroundColor Cyan
$xmlTemplate = Get-Content "$ModuleRoot\XAML\layout.xaml" -Raw -Encoding UTF8
$xml = $xmlTemplate -replace '\$W', $global:W -replace '\$H', $global:H

# Load XAML
$script:ui = [Windows.Markup.XamlReader]::Load([System.Xml.XmlReader]::Create([System.IO.StringReader]$xml))
$script:ui.Opacity = 0

$script:ui.Title = "Platinum+ Optimizer"
try {
    if ($global:AppIcon -and (Test-Path $global:AppIcon)) {
        $script:ui.Icon = [System.Windows.Media.Imaging.BitmapFrame]::Create($global:AppIcon)
    }
} catch {}


if ($script:statusText) { $script:statusText.Text = "Binding interface assets..." }
[System.Windows.Forms.Application]::DoEvents()

# Set image sources for elements that had inline PowerShell variables
Write-Host "Binding interface assets..." -ForegroundColor Cyan
try { $ui.FindName("IMG_LOGO").Source = $global:LogoPath } catch {}
try { $ui.FindName("IMG_LOGO_MAIN").Source = $global:MainLogo } catch {}
try { $ui.FindName("IMG_RESTORE").Source = $global:RestoreIco } catch {}
try { $ui.FindName("IMG_REGISTRY").Source = $global:RegIco } catch {}
try { $ui.FindName("IMG_BUGFIX_NAV").Source = $global:BugIco } catch {}
try { $ui.FindName("IMG_DRIVER_NAV").Source = $global:DriverIco } catch {}
try { $ui.FindName("IMG_DEBLOAT_NAV").Source = $global:DebloatIco } catch {}
try { $ui.FindName("IMG_SERVICE_NAV").Source = $global:ServiceIco } catch {}
try { $ui.FindName("IMG_SYSTWEAKS_NAV").Source = $global:WrenchIco } catch {}
try { $ui.FindName("IMG_CLEANUP_NAV").Source = $global:BrushIco } catch {}
try { $ui.FindName("IMG_CPU_NAV").Source = $global:CpuIco } catch {}
try { $ui.FindName("IMG_GPU_NAV").Source = $global:GpuIco } catch {}
try { $ui.FindName("IMG_RAM_NAV").Source = $global:RamIco } catch {}
try { $ui.FindName("IMG_INPUT_NAV").Source = $global:InputIco } catch {}
try { $ui.FindName("IMG_DISK_NAV").Source = $global:DiskIco } catch {}
try { $ui.FindName("IMG_NET_NAV").Source = $global:EthernetIco } catch {}
try { $ui.FindName("IMG_ABOUT_NAV").Source = $global:AboutIco } catch {}
try { $ui.FindName("IMG_SEARCH_ICON").Source = $global:SearchIco } catch {}
try { $ui.FindName("IMG_SERVICE_SEARCH_ICON").Source = $global:SearchIco } catch {}
try { $ui.FindName("IMG_DEBLOAT_SEARCH_ICON").Source = $global:SearchIco } catch {}
try { $ui.FindName("IMG_SYSTWEAKS_SEARCH_ICON").Source = $global:SearchIco } catch {}
try { $ui.FindName("IMG_CLEANUP_SEARCH_ICON").Source = $global:SearchIco } catch {}
try { $ui.FindName("IMG_CPUTWEAKS_SEARCH_ICON").Source = $global:SearchIco } catch {}
try { $ui.FindName("IMG_RAMTWEAKS_SEARCH_ICON").Source = $global:SearchIco } catch {}
try { $ui.FindName("IMG_GPUTWEAKS_SEARCH_ICON").Source = $global:SearchIco } catch {}
try { $ui.FindName("IMG_NETTWEAKS_SEARCH_ICON").Source = $global:SearchIco } catch {}
try { $ui.FindName("IMG_INPUTTWEAKS_SEARCH_ICON").Source = $global:SearchIco } catch {}
try { $ui.FindName("IMG_DISKTWEAKS_SEARCH_ICON").Source = $global:SearchIco } catch {}
try { $ui.FindName("IMG_ALEDECT").ImageSource = $global:AleDectIco } catch {}
try { $ui.FindName("IMG_STEFANO").ImageSource = $global:StefanoIco } catch {}
try { $ui.FindName("IMG_ALE_TG_ICON").Source = $global:TgIco } catch {}
try { $ui.FindName("IMG_ALE_KOFI_ICON").Source = $global:KofiIco } catch {}
try { $ui.FindName("IMG_ALE_GITHUB_ICON").Source = $global:GhIco } catch {}
try { $ui.FindName("IMG_ALE_YT_ICON").Source = $global:YoutubeIco } catch {}
try { $ui.FindName("IMG_ALE_DISCORD_ICON").Source = $global:DiscordIco } catch {}
try { $ui.FindName("IMG_ALE_TIKTOK_ICON").Source = $global:TikTokIco } catch {}
try { $ui.FindName("IMG_STE_TIKTOK_ICON").Source = $global:TikTokIco } catch {}
try { $ui.FindName("IMG_STE_TG_ICON").Source = $global:TgIco } catch {}
try { $ui.FindName("IMG_STE_KOFI_ICON").Source = $global:KofiIco } catch {}
try { $ui.FindName("IMG_STE_GITHUB_ICON").Source = $global:GhIco } catch {}
try { $ui.FindName("IMG_STE_YT_ICON").Source = $global:YoutubeIco } catch {}
try { $ui.FindName("IMG_STE_DISCORD_ICON").Source = $global:DiscordIco } catch {}
try { $ui.FindName("IMG_LINK_WEB").Source = $global:MainLogo } catch {}
try { $ui.FindName("IMG_LINK_WIKI").Source = $global:MainLogo } catch {}
try { $ui.FindName("IMG_LINK_TG").Source = $global:TgIco } catch {}
try { $ui.FindName("IMG_LINK_DISCORD").Source = $global:DiscordIco } catch {}
try { $ui.FindName("IMG_LINK_KOFI").Source = $global:KofiIco } catch {}
try { $ui.FindName("IMG_LINK_GH").Source = $global:GhIco } catch {}
try { $ui.FindName("MODAL_ICON_IMAGE").Source = $global:CheckIco } catch {}
try { $ui.FindName("IMG_CPU_CARD").Source = $global:CpuIco } catch {}
try { $ui.FindName("IMG_CPU_GENERAL").Source = $global:GeneralIco } catch {}
try { $ui.FindName("IMG_CPU_AMD").Source = $global:AmdIco } catch {}
try { $ui.FindName("IMG_CPU_INTEL").Source = $global:IntelIco } catch {}
try { $ui.FindName("IMG_RAM_CARD").Source = $global:RamIco } catch {}
try { $ui.FindName("IMG_GPU_CARD").Source = $global:GpuIco } catch {}
try { $ui.FindName("IMG_GPU_GENERAL").Source = $global:GeneralIco } catch {}
try { $ui.FindName("IMG_GPU_NVIDIA").Source = $global:NvidiaIco } catch {}
try { $ui.FindName("IMG_GPU_AMD").Source = $global:RadeonIco } catch {}
try { $ui.FindName("IMG_GPU_INTEL").Source = $global:IntelIco } catch {}
try { $ui.FindName("IMG_CHART").Source = $global:ChartIco } catch {}
try { $ui.FindName("IMG_SYSTEM").Source = $global:SystemIco } catch {}
try { $ui.FindName("IMG_RAM_TWEAK").Source = $global:RamIco } catch {}
try { $ui.FindName("IMG_DISK_TWEAK").Source = $global:DiskIco } catch {}
try { $ui.FindName("IMG_NET_TWEAK").Source = $global:EthernetTweakIco } catch {}
try { $ui.FindName("IMG_HOME").Source = $global:HomeIco } catch {}
try { $ui.FindName("IMG_RESTORE_NAV").Source = $global:BackupIco } catch {}
try { $ui.FindName("IMG_GAME_NAV").Source = $global:DriverIco } catch {}
try { $ui.FindName("IMG_COMING_SOON").Source = $global:DriverIco } catch {}
try { $ui.FindName("IMG_BUGFIX_TAB_WINDOWS").Source = $global:WindowsFixIco } catch {}
try { $ui.FindName("IMG_BUGFIX_TAB_GAME").Source = $global:GameIco } catch {}
try { $ui.FindName("IMG_BUGFIX_TAB_NETWORK").Source = $global:Wifi1Ico } catch {}
try { $ui.FindName("IMG_BUGFIX_TAB_APP").Source = $global:AppFixIco } catch {}
try { $ui.FindName("IMG_SYSTWEAKS_TAB_KERNEL").Source = $global:Wrench1Ico } catch {}
try { $ui.FindName("IMG_SYSTWEAKS_TAB_CUSTOMIZATION").Source = $global:CustomizationIco } catch {}
try { $ui.FindName("IMG_SYSTWEAKS_TAB_SECURITY").Source = $global:LockIco } catch {}
try { $ui.FindName("IMG_SYSTWEAKS_TAB_POWER").Source = $global:PlugIco } catch {}
try { $ui.FindName("IMG_SYSTWEAKS_TAB_BOOT").Source = $global:PowerIco } catch {}
try { $ui.FindName("IMG_SYSTWEAKS_TAB_CLEANUP").Source = $global:BrushIco } catch {}
try { $ui.FindName("IMG_DISK_TAB_SSD").Source = $global:DiskIco } catch {}
try { $ui.FindName("IMG_DISK_TAB_STORAGE").Source = $global:DiskIco } catch {}
try { $ui.FindName("IMG_DISK_TAB_FILESYSTEM").Source = $global:RegIco } catch {}
try { $ui.FindName("IMG_NET_TAB_TCPIP").Source = $global:EthernetIco } catch {}
try { $ui.FindName("IMG_NET_TAB_WIFI").Source = $global:WifiIco } catch {}
try { $ui.FindName("IMG_NET_TAB_ADAPTER").Source = $global:EthernetTweakIco } catch {}
try { $ui.FindName("IMG_INPUT_TAB_MOUSE").Source = $global:InputIco } catch {}
try { $ui.FindName("IMG_INPUT_TAB_KEYBOARD").Source = $global:InputIco } catch {}
try { $ui.FindName("IMG_INPUT_TAB_USB").Source = $global:GeneralIco } catch {}
try { $ui.FindName("IMG_INPUT_TAB_TOUCH").Source = $global:GeneralIco } catch {}
try { $ui.FindName("IMG_DEBLOAT_TAB_COMPONENTS").Source = $global:DebloatIco } catch {}
try { $ui.FindName("IMG_DEBLOAT_TAB_TELEMETRY").Source = $global:TelemetryIco } catch {}
try { $ui.FindName("IMG_DEBLOAT_TAB_PRIVACY").Source = $global:PrivacyIco } catch {}
try { $ui.FindName("IMG_DEBLOAT_SEARCH_ICON").Source = $global:GamePerfSearchIco } catch {}
try { $ui.FindName("IMG_GAMEPERF_TAB_GAMES").Source = $global:GamesTabIco } catch {}
try { $ui.FindName("IMG_GAMEPERF_TAB_LAUNCHERS").Source = $global:LaunchersTabIco } catch {}
try { $ui.FindName("IMG_GAMEPERF_TAB_SOFTWARE").Source = $global:SoftwareTabIco } catch {}
try { $ui.FindName("IMG_SOFTWARE_1").Source = $global:DriverIco } catch {}
try { $ui.FindName("IMG_SOFTWARE_2").Source = $global:DriverIco } catch {}
try { $ui.FindName("IMG_SOFTWARE_3").Source = $global:DriverIco } catch {}
try { $ui.FindName("IMG_SOFTWARE_4").Source = $global:DriverIco } catch {}
try { $ui.FindName("IMG_SOFTWARE_5").Source = $global:DriverIco } catch {}
try { $ui.FindName("IMG_SOFTWARE_6").Source = $global:DriverIco } catch {}
try { $ui.FindName("IMG_GAMEPERF_SEARCH_ICON").Source = $global:GamePerfSearchIco } catch {}

if ($statusText) { $statusText.Text = "Loading application modules..." }
[System.Windows.Forms.Application]::DoEvents()

# Load remaining modules
Write-Host "Loading application modules..." -ForegroundColor Cyan
. "$ModuleRoot\modules\animations.ps1"
. "$ModuleRoot\modules\ui_helpers.ps1"
. "$ModuleRoot\modules\background_monitor.ps1"
. "$ModuleRoot\modules\platinum_shell.ps1"

# WINDOW BUTTONS
$ui.FindName("BTN_EXIT").Add_Click({ 
    $ui.Close() 
})
$ui.FindName("BTN_MIN").Add_Click({ $ui.WindowState = 'Minimized' })
$ui.FindName("BTN_MAX").Add_Click({ 
    if ($ui.WindowState -eq 'Maximized') { 
        $ui.WindowState = 'Normal' 
    } else { 
        $ui.WindowState = 'Maximized' 
    } 
})

$ui.Add_Closed({
    try {
        $global:TeleTimer.Stop()
        if ($global:Computer) { $global:Computer.Close() | Out-Null }
        $global:BgHash.IsRunning = $false
        $null = $global:BgPs.Stop(); $global:BgPs.Dispose()
        $null = $global:BgRs.Close(); $global:BgRs.Dispose()
        if ($global:PlatinumShell) { $global:PlatinumShell.Close() | Out-Null }
    } catch {}

    Stop-Process -Id $PID -Force
})

# DYNAMIC ELEMENTS for telemetry
$dCpuPct = $ui.FindName("TXT_CPU"); $dRamPct = $ui.FindName("TXT_RAM"); $dGpuPct = $ui.FindName("TXT_GPU_USE")
$waveCpu = $ui.FindName("WAVE_FILL_CPU"); $waveRam = $ui.FindName("WAVE_FILL_RAM"); $waveGpu = $ui.FindName("WAVE_FILL_GPU")
$txtDn = $ui.FindName("TXT_NET_DN"); $txtUp = $ui.FindName("TXT_NET_UP")
$txtProc = $ui.FindName("TXT_PROCS")

$global:TotRamMB = 1000
$global:LastRx = 0; $global:LastTx = 0; $global:LastTick = [DateTime]::Now

# Load navigation, event handlers, and module logic
Write-Host "Loading navigation and modules..." -ForegroundColor Cyan
Write-Host "UI Type before loading modules: $($ui.GetType().FullName)" -ForegroundColor Cyan
. "$ModuleRoot\modules\state_manager.ps1"
Write-Host "UI Type after state_manager: $($ui.GetType().FullName)" -ForegroundColor Cyan
. "$ModuleRoot\modules\navigation.ps1"
Write-Host "UI Type after navigation: $($ui.GetType().FullName)" -ForegroundColor Cyan
. "$ModuleRoot\modules\backup_restore.ps1"
Write-Host "UI Type after backup_restore: $($ui.GetType().FullName)" -ForegroundColor Cyan
. "$ModuleRoot\modules\bugfix.ps1"
Write-Host "UI Type after bugfix: $($ui.GetType().FullName)" -ForegroundColor Cyan
. "$ModuleRoot\modules\services.ps1"
Write-Host "UI Type after services: $($ui.GetType().FullName)" -ForegroundColor Cyan
. "$ModuleRoot\modules\debloat.ps1"
Write-Host "UI Type after debloat: $($ui.GetType().FullName)" -ForegroundColor Cyan
. "$ModuleRoot\modules\system_tweaks.ps1"
Write-Host "UI Type after system_tweaks: $($ui.GetType().FullName)" -ForegroundColor Cyan
. "$ModuleRoot\modules\cleanup_tweaks.ps1"
Write-Host "UI Type after cleanup_tweaks: $($ui.GetType().FullName)" -ForegroundColor Cyan
. "$ModuleRoot\modules\cpu_tweaks.ps1"
Write-Host "UI Type after cpu_tweaks: $($ui.GetType().FullName)" -ForegroundColor Cyan
. "$ModuleRoot\modules\gpu_tweaks.ps1"
Write-Host "UI Type after gpu_tweaks: $($ui.GetType().FullName)" -ForegroundColor Cyan
. "$ModuleRoot\modules\ram_tweaks.ps1"
Write-Host "UI Type after ram_tweaks: $($ui.GetType().FullName)" -ForegroundColor Cyan
. "$ModuleRoot\modules\network_tweaks.ps1"
Write-Host "UI Type after network_tweaks: $($ui.GetType().FullName)" -ForegroundColor Cyan
. "$ModuleRoot\modules\input_tweaks.ps1"
Write-Host "UI Type after input_tweaks: $($ui.GetType().FullName)" -ForegroundColor Cyan
. "$ModuleRoot\modules\disk_tweaks.ps1"
Write-Host "UI Type after disk_tweaks: $($ui.GetType().FullName)" -ForegroundColor Cyan
. "$ModuleRoot\modules\game_performance.ps1"
Write-Host "UI Type after game_performance: $($ui.GetType().FullName)" -ForegroundColor Cyan

# ABOUT SECTION - Modal and links
$ui.FindName("BTN_MODAL_CONTINUE").Add_Click({
    if ($null -ne $global:ModalContinueAction) {
        & $global:ModalContinueAction
    }
    $global:ModalOkAction = $null
    Hide-CustomPopup
})
$ui.FindName("BTN_MODAL_OK").Add_Click({
    if ($null -ne $global:ModalOkAction) {
        & $global:ModalOkAction
        $global:ModalOkAction = $null
    }
    Hide-CustomPopup
})

$ui.FindName("LINK_WEB").Add_MouseLeftButtonDown({ Start-Process "https://platinum.optimizer.workers.dev/" })
$ui.FindName("LINK_TG_PLAT").Add_MouseLeftButtonDown({ Start-Process "https://t.me/+AKZO7Y5buhw0ZjRk" })
$ui.FindName("LINK_DISCORD").Add_MouseLeftButtonDown({ Start-Process "https://discord.com/invite/rMZPgAJvPF" })

# Alessio
$ui.FindName("LINK_ALE_TIKTOK").Add_MouseLeftButtonDown({ Start-Process "http://tiktok.com/@aledect" })
$ui.FindName("LINK_ALE_TG").Add_MouseLeftButtonDown({ Start-Process "https://t.me/aledect" })
$ui.FindName("LINK_ALE_KOFI").Add_MouseLeftButtonDown({ Start-Process "https://ko-fi.com/platinumoptimizer" })
$ui.FindName("LINK_ALE_GITHUB").Add_MouseLeftButtonDown({ Start-Process "https://github.com/Aledect/" })
$ui.FindName("LINK_ALE_YT").Add_MouseLeftButtonDown({ Start-Process "https://www.youtube.com/@Aledect" })
$ui.FindName("LINK_ALE_DISCORD").Add_MouseLeftButtonDown({ Start-Process "https://discord.com/users/1278098851236151412" })

# Stefano
$ui.FindName("LINK_STE_TIKTOK").Add_MouseLeftButtonDown({ Start-Process "https://www.tiktok.com/@rtx_4060_laptop" })
$ui.FindName("LINK_STE_TG").Add_MouseLeftButtonDown({ Start-Process "https://t.me/STEFANO83223" })
$ui.FindName("LINK_STE_KOFI").Add_MouseLeftButtonDown({ Start-Process "https://ko-fi.com/stefano_rtx_4060_laptop" })
$ui.FindName("LINK_STE_GITHUB").Add_MouseLeftButtonDown({ Start-Process "https://github.com/stefanomorandi83762-design" })
$ui.FindName("LINK_STE_YT").Add_MouseLeftButtonDown({ Start-Process "https://www.youtube.com/@STEFANO_MOR_MUSIC4452" })
$ui.FindName("LINK_STE_DISCORD").Add_MouseLeftButtonDown({ Start-Process "https://discord.com/users/1518703063110520983" })

# Loaded event - triggers system detection and telemetry
$ui.Add_Loaded({
    $ui.FindName("INP_RP_NAME").Add_GotKeyboardFocus({ $this.SelectAll() })
    $ui.FindName("INP_REG_NAME").Add_GotKeyboardFocus({ $this.SelectAll() })

    $ui.FindName("LIST_RP").Add_SelectionChanged({
        if ($this.SelectedIndex -ne -1) {
            $ui.FindName("BTN_DO_APPLY_RP").Opacity = 1; $ui.FindName("BTN_DO_APPLY_RP").IsEnabled = $true
            $ui.FindName("BTN_DO_DEL_RP").Opacity = 1; $ui.FindName("BTN_DO_DEL_RP").IsEnabled = $true
        }
    })
    
    $ui.FindName("LIST_REG").Add_SelectionChanged({
        if ($this.SelectedIndex -ne -1) {
            $ui.FindName("BTN_DO_APPLY_REG").Opacity = 1; $ui.FindName("BTN_DO_APPLY_REG").IsEnabled = $true
            $ui.FindName("BTN_DO_DEL_REG").Opacity = 1; $ui.FindName("BTN_DO_DEL_REG").IsEnabled = $true
        }
    })

    if ($script:statusText) { $script:statusText.Text = "Detecting system hardware..." }
    [System.Windows.Forms.Application]::DoEvents()

    # Load system information
    Write-Host "Loading system information..." -ForegroundColor Cyan
    . "$ModuleRoot\modules\system_info.ps1"

    # Load configuration tweak state
    Write-Host "Loading tweak state..." -ForegroundColor Cyan
    Load-TweakState

    # Set initial view
    Write-Host "Setting initial view..." -ForegroundColor Cyan
    Set-Selector ($ui.FindName("NAV_HOME"))
    Update-NavSelection ($ui.FindName("NAV_HOME"))
    Show-View "MAIN"
    Register-SidebarScrollHandlers

    $global:TeleTimer.Start()

    # Calculate remaining time for the 2.5s splash animation
    $elapsed = 0
    if ($script:SplashStartTime) {
        $elapsed = ([DateTime]::Now - $script:SplashStartTime).TotalSeconds
    }
    $remaining = 2.5 - $elapsed
    if ($remaining -lt 0.5) { $remaining = 0.5 } # Minimum duration cushion for fade out

    # DispatcherTimer for transition
    $transitionTimer = New-Object System.Windows.Threading.DispatcherTimer
    $transitionTimer.Interval = [TimeSpan]::FromSeconds($remaining)
    $transitionTimer.Add_Tick({
        $this.Stop()
        
        if ($script:statusText) { $script:statusText.Text = "Ready!" }
        [System.Windows.Forms.Application]::DoEvents()

        # Setup cross-fade animations (400ms duration)
        $fadeOut = New-Object System.Windows.Media.Animation.DoubleAnimation -Property @{
            From = 1.0; To = 0.0; Duration = "0:0:0.400"
        }
        $fadeIn = New-Object System.Windows.Media.Animation.DoubleAnimation -Property @{
            From = 0.0; To = 1.0; Duration = "0:0:0.400"
        }

        # Start animations
        $script:splash.BeginAnimation([System.Windows.Window]::OpacityProperty, $fadeOut)
        $script:ui.BeginAnimation([System.Windows.Window]::OpacityProperty, $fadeIn)

        # Initialize shell immediately so it launches with the program
        Initialize-PlatinumShell -LogoPath $global:LogoPath

        $fadeOut.Add_Completed({
            $script:splash.Close()
            $script:ui.Activate()
            $script:ui.Focus()
        })
    })
    $transitionTimer.Start()
})

# Load telemetry timer
Write-Host "Loading telemetry timer..." -ForegroundColor Cyan
. "$ModuleRoot\modules\telemetry.ps1"

# Show the window
Write-Host "Showing main window..." -ForegroundColor Green
try {
    $ui.WindowStartupLocation = 'CenterScreen'
    $ui.ShowDialog()
} catch {
    Write-Host "ERROR: Failed to show dialog: $_" -ForegroundColor Red
    Write-Host "UI Type: $($ui.GetType().FullName)" -ForegroundColor Yellow
    Write-Host "Attempting alternative window display..." -ForegroundColor Yellow
    $ui.Show()
}
