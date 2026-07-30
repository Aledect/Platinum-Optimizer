# Debloat Module - Search and Execute Handlers

# Global variable to track selected tab
$global:SelectedDebloatTab = "TAB_DEBLOAT_MSAPPS"

# Selector bar function
$setDebloatSelector = {
    param($btn)
    if ($null -eq $btn) { return }
    $transform = $ui.FindName("DebloatSelectorTransform")
    $selector = $ui.FindName("DebloatTabSelector")
    $container = $ui.FindName("DEBLOAT_TAB_CONTAINER")
    if ($null -eq $transform -or $null -eq $selector -or $null -eq $container) { return }
    if ($btn.ActualWidth -eq 0) {
        $container.UpdateLayout()
    }
    if ($btn.ActualWidth -eq 0) { return }
    $pos = $btn.TranslatePoint((New-Object System.Windows.Point(0,0)), $container)
    $animation = New-Object System.Windows.Media.Animation.DoubleAnimation
    $animation.From = $transform.X
    $animation.To = $pos.X
    $animation.Duration = [TimeSpan]::FromMilliseconds(250)
    $animation.EasingFunction = New-Object System.Windows.Media.Animation.CubicEase
    $transform.BeginAnimation([System.Windows.Media.TranslateTransform]::XProperty, $animation)
    $widthAnimation = New-Object System.Windows.Media.Animation.DoubleAnimation
    $widthAnimation.From = $selector.Width
    $widthAnimation.To = $btn.ActualWidth
    $widthAnimation.Duration = [TimeSpan]::FromMilliseconds(250)
    $widthAnimation.EasingFunction = New-Object System.Windows.Media.Animation.CubicEase
    $selector.BeginAnimation([System.Windows.Controls.Border]::WidthProperty, $widthAnimation)
}

# Helper function to toggle subtab visibility
$setDebloatSubTabVisibility = {
    param([bool]$visible)
    $subGrid = $ui.FindName("DEBLOAT_SUBTAB_GRID")
    $subCont = $ui.FindName("DEBLOAT_SUBTAB_CONTAINER")
    $subSel  = $ui.FindName("DebloatSubTabSelector")
    $visState = if ($visible) { 'Visible' } else { 'Collapsed' }
    if ($null -ne $subGrid) { $subGrid.Visibility = $visState }
    if ($null -ne $subCont) { $subCont.Visibility = $visState }
    if ($null -ne $subSel)  { $subSel.Visibility  = $visState }
}

# Helper function to toggle action bar visibility (Apply/Revert buttons)
$setDebloatActionBarVisibility = {
    param([bool]$visible)
    $bar = $ui.FindName("DEBLOAT_ACTION_BAR")
    if ($null -ne $bar) {
        $bar.Visibility = if ($visible) { 'Visible' } else { 'Collapsed' }
    }
}

# Add selector bar to tab buttons
$tabMsApps = $ui.FindName("TAB_DEBLOAT_MSAPPS")
if ($null -ne $tabMsApps) {
    $imgTabMs = $ui.FindName("IMG_DEBLOAT_TAB_MSAPPS")
    if ($null -ne $imgTabMs) {
        $bloatPath = Join-Path $ModuleRoot "ico\bloat.png"
        if (Test-Path $bloatPath) {
            try {
                $absBloatPath = (Resolve-Path $bloatPath).Path
                $bitmap = New-Object System.Windows.Media.Imaging.BitmapImage
                $bitmap.BeginInit()
                $bitmap.CacheOption = [System.Windows.Media.Imaging.BitmapCacheOption]::OnLoad
                $bitmap.UriSource = New-Object System.Uri($absBloatPath)
                $bitmap.EndInit()
                $bitmap.Freeze()
                $imgTabMs.Source = $bitmap
            } catch {}
        }
    }
    $tabMsApps.Add_Checked({
        $global:SelectedDebloatTab = "TAB_DEBLOAT_MSAPPS"
        & $setDebloatSelector $this
        & $setDebloatSubTabVisibility $true
        & $setDebloatActionBarVisibility $false
        $subBtn = $ui.FindName($global:SelectedDebloatSubTab)
        if ($null -ne $subBtn) { & $setDebloatSubSelector $subBtn }
        Update-DebloatSubTabVisibility
        if (Get-Command Animate-SectionItems -ErrorAction SilentlyContinue) {
            $viewElem = $ui.FindName("VIEW_DEBLOAT")
            if ($null -ne $viewElem) { Animate-SectionItems $viewElem }
        }
    }.GetNewClosure())
}

$tabComponents = $ui.FindName("TAB_DEBLOAT_COMPONENTS")
if ($null -ne $tabComponents) {
    $tabComponents.Add_Checked({
        $global:SelectedDebloatTab = "TAB_DEBLOAT_COMPONENTS"
        & $setDebloatSelector $this
        & $setDebloatSubTabVisibility $false
        & $setDebloatActionBarVisibility $true
        Update-DebloatSubTabVisibility
        & $updateDebloatButtons
        if (Get-Command Animate-SectionItems -ErrorAction SilentlyContinue) {
            $viewElem = $ui.FindName("VIEW_DEBLOAT")
            if ($null -ne $viewElem) { Animate-SectionItems $viewElem }
        }
    }.GetNewClosure())
}

$tabTelemetry = $ui.FindName("TAB_DEBLOAT_TELEMETRY")
if ($null -ne $tabTelemetry) {
    $tabTelemetry.Add_Checked({
        $global:SelectedDebloatTab = "TAB_DEBLOAT_TELEMETRY"
        & $setDebloatSelector $this
        & $setDebloatSubTabVisibility $false
        & $setDebloatActionBarVisibility $true
        Update-DebloatSubTabVisibility
        & $updateDebloatButtons
        if (Get-Command Animate-SectionItems -ErrorAction SilentlyContinue) {
            $viewElem = $ui.FindName("VIEW_DEBLOAT")
            if ($null -ne $viewElem) { Animate-SectionItems $viewElem }
        }
    }.GetNewClosure())
}

$tabPrivacy = $ui.FindName("TAB_DEBLOAT_PRIVACY")
if ($null -ne $tabPrivacy) {
    $tabPrivacy.Add_Checked({
        $global:SelectedDebloatTab = "TAB_DEBLOAT_PRIVACY"
        & $setDebloatSelector $this
        & $setDebloatSubTabVisibility $false
        & $setDebloatActionBarVisibility $true
        Update-DebloatSubTabVisibility
        & $updateDebloatButtons
        if (Get-Command Animate-SectionItems -ErrorAction SilentlyContinue) {
            $viewElem = $ui.FindName("VIEW_DEBLOAT")
            if ($null -ne $viewElem) { Animate-SectionItems $viewElem }
        }
    }.GetNewClosure())
}

# Sync selector when view becomes visible
$viewDebloat = $ui.FindName("VIEW_DEBLOAT")
if ($null -ne $viewDebloat) {
    $viewDebloat.Add_IsVisibleChanged({
        if ($this.IsVisible) {
            $btn = $ui.FindName($global:SelectedDebloatTab)
            if ($null -ne $btn) { 
                & $setDebloatSelector $btn 
            }
            if ($global:SelectedDebloatTab -eq "TAB_DEBLOAT_MSAPPS") {
                & $setDebloatSubTabVisibility $true
                & $setDebloatActionBarVisibility $false
                $subBtn = $ui.FindName($global:SelectedDebloatSubTab)
                if ($null -ne $subBtn) {
                    & $setDebloatSubSelector $subBtn
                }
            } else {
                & $setDebloatSubTabVisibility $false
                & $setDebloatActionBarVisibility $true
                & $updateDebloatButtons
            }
        }
    }.GetNewClosure())
}

# Sub-tab selector bar function
$setDebloatSubSelector = {
    param($btn)
    if ($null -eq $btn) { return }
    $transform = $ui.FindName("DebloatSubSelectorTransform")
    $selector = $ui.FindName("DebloatSubTabSelector")
    $container = $ui.FindName("DEBLOAT_SUBTAB_CONTAINER")
    if ($null -eq $transform -or $null -eq $selector -or $null -eq $container) { return }
    if ($selector.Visibility -ne [System.Windows.Visibility]::Visible -and $selector.Visibility -ne 'Visible') { return }
    if ($btn.ActualWidth -eq 0) {
        $container.UpdateLayout()
    }
    if ($btn.ActualWidth -eq 0) { return }
    $pos = $btn.TranslatePoint((New-Object System.Windows.Point(0,0)), $container)
    $animation = New-Object System.Windows.Media.Animation.DoubleAnimation
    $animation.From = $transform.X
    $animation.To = $pos.X
    $animation.Duration = [TimeSpan]::FromMilliseconds(250)
    $animation.EasingFunction = New-Object System.Windows.Media.Animation.CubicEase
    $transform.BeginAnimation([System.Windows.Media.TranslateTransform]::XProperty, $animation)
    $widthAnimation = New-Object System.Windows.Media.Animation.DoubleAnimation
    $widthAnimation.From = $selector.Width
    $widthAnimation.To = $btn.ActualWidth
    $widthAnimation.Duration = [TimeSpan]::FromMilliseconds(250)
    $widthAnimation.EasingFunction = New-Object System.Windows.Media.Animation.CubicEase
    $selector.BeginAnimation([System.Windows.Controls.Border]::WidthProperty, $widthAnimation)
}

# Microsoft Apps Search Titles Mapping
$msAppTitles = @{
    1  = "microsoft edge"
    2  = "microsoft edge webview2 runtime"
    3  = "microsoft onedrive"
    4  = "microsoft store"
    5  = "microsoft copilot"
    6  = "windows web experience pack widgets"
    7  = "bing search"
    8  = "microsoft teams"
    9  = "outlook for windows"
    10 = "phone link"
    11 = "clipchamp"
    12 = "quick assist"
    13 = "mail and calendar"
    14 = "people"
    15 = "photos"
    16 = "calculator"
    17 = "alarms clock"
    18 = "camera"
    19 = "maps"
    20 = "voice recorder"
    21 = "feedback hub"
    22 = "snipping tool"
    23 = "sticky notes"
    24 = "paint 3d"
    25 = "microsoft solitaire collection"
    26 = "groove music"
    27 = "movies tv"
    28 = "skype"
    29 = "onenote for windows 10"
    30 = "office hub"
    31 = "microsoft to do"
    32 = "power automate desktop"
    33 = "dev home"
    34 = "3d builder"
    35 = "mixed reality portal"
    36 = "get help"
    37 = "tips"
    38 = "msn weather"
    39 = "msn news"
    40 = "msn finance"
    41 = "msn sports"
    42 = "xbox tcui"
    43 = "xbox app"
    44 = "gaming app"
    45 = "xbox game bar"
    46 = "xbox game overlay"
    47 = "xbox identity provider"
    48 = "xbox speech to text overlay"
}

# OEM Apps Search Titles Mapping
$oemAppTitles = @{
    1  = "hp support assistant"
    2  = "hp smart"
    3  = "hp jumpstart"
    4  = "dell supportassist"
    5  = "dell digital delivery"
    6  = "dell optimizer"
    7  = "lenovo vantage"
    8  = "lenovo hotkeys"
    9  = "myasus"
    10 = "asus armoury crate"
    11 = "samsung settings"
    12 = "samsung update"
    13 = "samsung flow"
    14 = "acer care center"
    15 = "msi center"
    16 = "razer cortex"
}

# Components Search Titles Mapping
$compAppTitles = @{
    1  = "disable background maintenance"
    2  = "disable automated update services"
    3  = "disable peripheral printing and accessory tasks"
    4  = "disable localization and time synchronization tasks"
    5  = "disable sensors broadcasts and mixed reality services"
    6  = "disable virtualization hypervisor and elam overhead"
    7  = "disable hyper-v and virtualization services"
    8  = "disable search indexing and web integration"
    9  = "disable uxd support and device caching"
    10 = "disable printer services for system environment"
    11 = "disable printer policies for windows"
    12 = "disable windows update and background servicing"
}

# Telemetry Search Titles Mapping
$telemAppTitles = @{
    1  = "disable telemetry data collection"
    2  = "disable error reporting and diagnostics"
    3  = "disable third-party and ai telemetry"
    4  = "disable usb telemetry and diagnostic subsystems"
    5  = "disable usb debugging and telemetry logging"
    6  = "disable usb hub diagnostics and debug logging"
    7  = "disable audio diagnostics telemetry and watchdog timers"
    8  = "disable general telemetry and diagnostic data collection"
    9  = "disable cloud and telemetry features for reduced overhead"
    10 = "disable wmplayer telemetry and optimize video playback for media subsystem"
    11 = "disable dwm heap logging"
}

# Privacy Search Titles Mapping
$privAppTitles = @{
    1  = "disable start menu tracking and app notifications"
    2  = "disable suggestions tips and windows spotlight for ui"
    3  = "disable microsoft copilot and ai features for shell subsystem"
    4  = "disable notifications and privacy intrusions"
}

# Custom sizes mapping for specific apps
$customLogoSizes = @{
    1  = 32  # Microsoft Edge
    2  = 32  # Microsoft Edge WebView2 Runtime
    6  = 34  # Windows Web Experience Pack / Widgets
    8  = 34  # Microsoft Teams
    18 = 32  # Camera
    19 = 30  # Maps
    24 = 32  # Paint 3D
    40 = 32  # MSN Finance
    41 = 32  # MSN Sports
}

$global:SelectedDebloatSubTab = "TAB_DEBLOAT_SUB_MSAPPS"

function Update-DebloatSubTabVisibility {
    $q = ""
    $inpSearch = $ui.FindName("INP_DEBLOAT_SEARCH")
    if ($null -ne $inpSearch -and $inpSearch.Text -ne "Search debloat items...") {
        $q = $inpSearch.Text.ToLower().Trim()
    }

    # Hide all items first
    1..48 | ForEach-Object { $item = $ui.FindName("ITEM_DEBLOAT_MS_$_"); if ($null -ne $item) { $item.Visibility = 'Collapsed' } }
    1..16 | ForEach-Object { $item = $ui.FindName("ITEM_DEBLOAT_OEM_$_"); if ($null -ne $item) { $item.Visibility = 'Collapsed' } }
    1..12 | ForEach-Object { $item = $ui.FindName("ITEM_DEBLOAT_COMP_$_"); if ($null -ne $item) { $item.Visibility = 'Collapsed' } }
    1..11 | ForEach-Object { $item = $ui.FindName("ITEM_DEBLOAT_TELEM_$_"); if ($null -ne $item) { $item.Visibility = 'Collapsed' } }
    1..4  | ForEach-Object { $item = $ui.FindName("ITEM_DEBLOAT_PRIV_$_"); if ($null -ne $item) { $item.Visibility = 'Collapsed' } }

    if ($global:SelectedDebloatTab -eq "TAB_DEBLOAT_COMPONENTS") {
        1..12 | ForEach-Object {
            $compItem = $ui.FindName("ITEM_DEBLOAT_COMP_$_")
            if ($null -ne $compItem) {
                $matched = ($q -eq '' -or ($compAppTitles.ContainsKey($_) -and $compAppTitles[$_].Contains($q)))
                if ($matched) { $compItem.Visibility = 'Visible' }
            }
        }
    } elseif ($global:SelectedDebloatTab -eq "TAB_DEBLOAT_TELEMETRY") {
        1..11 | ForEach-Object {
            $telemItem = $ui.FindName("ITEM_DEBLOAT_TELEM_$_")
            if ($null -ne $telemItem) {
                $matched = ($q -eq '' -or ($telemAppTitles.ContainsKey($_) -and $telemAppTitles[$_].Contains($q)))
                if ($matched) { $telemItem.Visibility = 'Visible' }
            }
        }
    } elseif ($global:SelectedDebloatTab -eq "TAB_DEBLOAT_PRIVACY") {
        1..4 | ForEach-Object {
            $privItem = $ui.FindName("ITEM_DEBLOAT_PRIV_$_")
            if ($null -ne $privItem) {
                $matched = ($q -eq '' -or ($privAppTitles.ContainsKey($_) -and $privAppTitles[$_].Contains($q)))
                if ($matched) { $privItem.Visibility = 'Visible' }
            }
        }
    } else {
        if ($global:SelectedDebloatSubTab -eq "TAB_DEBLOAT_SUB_MSAPPS") {
            1..48 | ForEach-Object {
                $msItem = $ui.FindName("ITEM_DEBLOAT_MS_$_")
                if ($null -ne $msItem) {
                    $matched = ($q -eq '' -or ($msAppTitles.ContainsKey($_) -and $msAppTitles[$_].Contains($q)))
                    if ($matched) { $msItem.Visibility = 'Visible' }
                }
            }
        } else {
            1..16 | ForEach-Object {
                $oemItem = $ui.FindName("ITEM_DEBLOAT_OEM_$_")
                if ($null -ne $oemItem) {
                    $matched = ($q -eq '' -or ($oemAppTitles.ContainsKey($_) -and $oemAppTitles[$_].Contains($q)))
                    if ($matched) { $oemItem.Visibility = 'Visible' }
                }
            }
        }
    }
}

$imgSubMs = $ui.FindName("IMG_DEBLOAT_SUB_MSAPPS")
if ($null -ne $imgSubMs) {
    $storeIconPath = Join-Path $ModuleRoot "ico\store.png"
    if (Test-Path $storeIconPath) {
        try {
            $absStorePath = (Resolve-Path $storeIconPath).Path
            $bitmap = New-Object System.Windows.Media.Imaging.BitmapImage
            $bitmap.BeginInit()
            $bitmap.CacheOption = [System.Windows.Media.Imaging.BitmapCacheOption]::OnLoad
            $bitmap.UriSource = New-Object System.Uri($absStorePath)
            $bitmap.EndInit()
            $bitmap.Freeze()
            $imgSubMs.Source = $bitmap
        } catch {}
    }
}

$imgSubOem = $ui.FindName("IMG_DEBLOAT_SUB_OEM")
if ($null -ne $imgSubOem) {
    $oemIconPath = Join-Path $ModuleRoot "ico\oem.png"
    if (Test-Path $oemIconPath) {
        try {
            $absOemPath = (Resolve-Path $oemIconPath).Path
            $bitmap = New-Object System.Windows.Media.Imaging.BitmapImage
            $bitmap.BeginInit()
            $bitmap.CacheOption = [System.Windows.Media.Imaging.BitmapCacheOption]::OnLoad
            $bitmap.UriSource = New-Object System.Uri($absOemPath)
            $bitmap.EndInit()
            $bitmap.Freeze()
            $imgSubOem.Source = $bitmap
        } catch {}
    }
}

$tabSubMsApps = $ui.FindName("TAB_DEBLOAT_SUB_MSAPPS")
if ($null -ne $tabSubMsApps) {
    $tabSubMsApps.Add_Checked({
        $global:SelectedDebloatSubTab = "TAB_DEBLOAT_SUB_MSAPPS"
        & $setDebloatSubSelector $this
        Update-DebloatSubTabVisibility
        $viewElem = $ui.FindName("VIEW_DEBLOAT")
        if ($null -ne $viewElem -and (Get-Command Animate-SectionItems -ErrorAction SilentlyContinue)) {
            Animate-SectionItems $viewElem
        }
    }.GetNewClosure())
}

$tabSubOem = $ui.FindName("TAB_DEBLOAT_SUB_OEM")
if ($null -ne $tabSubOem) {
    $tabSubOem.Add_Checked({
        $global:SelectedDebloatSubTab = "TAB_DEBLOAT_SUB_OEM"
        & $setDebloatSubSelector $this
        Update-DebloatSubTabVisibility
        $viewElem = $ui.FindName("VIEW_DEBLOAT")
        if ($null -ne $viewElem -and (Get-Command Animate-SectionItems -ErrorAction SilentlyContinue)) {
            Animate-SectionItems $viewElem
        }
    }.GetNewClosure())
}

$inpSearch = $ui.FindName("INP_DEBLOAT_SEARCH")
if ($null -ne $inpSearch) {
    $inpSearch.Add_GotKeyboardFocus({ 
        if ($this.Text -eq "Search debloat items...") { $this.Text = ""; $this.Foreground = "#FFF" } 
    }.GetNewClosure())
    $inpSearch.Add_LostKeyboardFocus({ 
        if ([string]::IsNullOrWhiteSpace($this.Text)) { $this.Text = "Search debloat items..."; $this.Foreground = "#949BAA" } 
    }.GetNewClosure())
    $inpSearch.Add_TextChanged({
        Update-DebloatSubTabVisibility
        $sv = $ui.FindName('SCROLL_DEBLOAT')
        if ($null -ne $sv) { $sv.ScrollToTop() }
    }.GetNewClosure())
}

# 1..48 Microsoft Apps Handlers
1..48 | ForEach-Object {
    $appId = $_
    $folderDir = switch ($appId) {
        1  { "01_microsoft_edge" }
        2  { "02_microsoft_edge_webview2_runtime" }
        3  { "03_microsoft_onedrive" }
        4  { "04_microsoft_store" }
        5  { "05_microsoft_copilot" }
        6  { "06_windows_web_experience_pack_widgets" }
        7  { "07_bing_search" }
        8  { "08_microsoft_teams" }
        9  { "09_outlook_for_windows" }
        10 { "10_phone_link" }
        11 { "11_clipchamp" }
        12 { "12_quick_assist" }
        13 { "13_mail_and_calendar" }
        14 { "14_people" }
        15 { "15_photos" }
        16 { "16_calculator" }
        17 { "17_alarms_and_clock" }
        18 { "18_camera" }
        19 { "19_maps" }
        20 { "20_voice_recorder" }
        21 { "21_feedback_hub" }
        22 { "22_snipping_tool" }
        23 { "23_sticky_notes" }
        24 { "24_paint_3d" }
        25 { "25_microsoft_solitaire_collection" }
        26 { "26_groove_music" }
        27 { "27_movies_and_tv" }
        28 { "28_skype" }
        29 { "29_onenote_for_windows_10" }
        30 { "30_office_hub" }
        31 { "31_microsoft_to_do" }
        32 { "32_power_automate_desktop" }
        33 { "33_dev_home" }
        34 { "34_3d_builder" }
        35 { "35_mixed_reality_portal" }
        36 { "36_get_help" }
        37 { "37_tips" }
        38 { "38_msn_weather" }
        39 { "39_msn_news" }
        40 { "40_msn_finance" }
        41 { "41_msn_sports" }
        42 { "42_xbox_tcui" }
        43 { "43_xbox_app" }
        44 { "44_gaming_app" }
        45 { "45_xbox_game_bar" }
        46 { "46_xbox_game_overlay" }
        47 { "47_xbox_identity_provider" }
        48 { "48_xbox_speech_to_text_overlay" }
    }

    $targetSize = if ($customLogoSizes.ContainsKey($appId)) { $customLogoSizes[$appId] } else { 28 }

    # Dynamic high quality logo loader from logo.png
    $msAppItemLogoPath = Join-Path $ModuleRoot "tweak\04_debloat\01_microsoftapp\$folderDir\logo.png"
    $imgLogo = $ui.FindName("IMG_LOGO_DEBLOAT_MS_$appId")
    $txtIcon = $ui.FindName("TXT_ICON_DEBLOAT_MS_$appId")
    if (Test-Path $msAppItemLogoPath) {
        try {
            $absLogoPath = (Resolve-Path $msAppItemLogoPath).Path
            $bitmap = New-Object System.Windows.Media.Imaging.BitmapImage
            $bitmap.BeginInit()
            $bitmap.CacheOption = [System.Windows.Media.Imaging.BitmapCacheOption]::OnLoad
            $bitmap.DecodePixelWidth = 256
            $bitmap.DecodePixelHeight = 256
            $bitmap.UriSource = New-Object System.Uri($absLogoPath)
            $bitmap.EndInit()
            $bitmap.Freeze()
            if ($null -ne $imgLogo) {
                [System.Windows.Media.RenderOptions]::SetBitmapScalingMode($imgLogo, [System.Windows.Media.BitmapScalingMode]::HighQuality)
                $imgLogo.Source = $bitmap
                $imgLogo.Width = $targetSize
                $imgLogo.Height = $targetSize
                $imgLogo.Stretch = [System.Windows.Media.Stretch]::Uniform
                $imgLogo.Visibility = [System.Windows.Visibility]::Visible
            }
            if ($null -ne $txtIcon) {
                $txtIcon.Visibility = [System.Windows.Visibility]::Collapsed
            }
        } catch {
            if ($null -ne $txtIcon) { $txtIcon.Visibility = [System.Windows.Visibility]::Visible }
        }
    } else {
        if ($null -ne $txtIcon) { $txtIcon.Visibility = [System.Windows.Visibility]::Visible }
    }

    # Dynamic description reader from description.txt
    $msAppDescPath = Join-Path $ModuleRoot "tweak\04_debloat\01_microsoftapp\$folderDir\description.txt"
    if (Test-Path $msAppDescPath) {
        $descTxt = (Get-Content $msAppDescPath -Raw -ErrorAction SilentlyContinue)
        if ($null -ne $descTxt) { $descTxt = $descTxt.Trim() }
        $tbDesc = $ui.FindName("TXT_DESC_DEBLOAT_MS_$appId")
        if ($null -ne $tbDesc -and -not [string]::IsNullOrWhiteSpace($descTxt)) {
            $tbDesc.Text = $descTxt
        }
    }

    # Info button hover/click styles
    $btnI = $ui.FindName("BTN_INFO_DEBLOAT_MS_$appId")
    if ($null -ne $btnI) {
        $btnI.Add_MouseEnter({ 
            $tb = [System.Windows.Controls.TextBlock]$this.Child
            if ($null -ne $tb) { $tb.Foreground = "#00B4DB" }
        }.GetNewClosure())
        $btnI.Add_MouseLeave({ 
            $tb = [System.Windows.Controls.TextBlock]$this.Child
            if ($null -ne $tb) { $tb.Foreground = "#949BAA" }
        }.GetNewClosure())
        $btnI.Add_PreviewMouseLeftButtonDown({
            $tb = [System.Windows.Controls.TextBlock]$this.Child
            if ($null -ne $tb) { $tb.Foreground = "#00B4DB" }
        }.GetNewClosure())
    }

    # Uninstall button (apply.cmd)
    $btnU = $ui.FindName("BTN_UNINSTALL_DEBLOAT_MS_$appId")
    if ($null -ne $btnU) {
        $btnU.Add_Click({
            $origContent = $this.Content
            $this.Content = "Processing..."
            [System.Windows.Threading.Dispatcher]::CurrentDispatcher.Invoke("Render", [Action]{})
            
            if (Get-Command Log-ProgramAction -ErrorAction SilentlyContinue) {
                Log-ProgramAction -Action "Uninstall App" -Details "Uninstalling Microsoft App ID: $appId ($folderDir)"
            }
            
            $cmdScript = Join-Path $ModuleRoot "tweak\04_debloat\01_microsoftapp\$folderDir\apply.cmd"
            if (Test-Path $cmdScript) {
                if (Get-Command Invoke-LoggedBat -ErrorAction SilentlyContinue) {
                    Invoke-LoggedBat -BatPath $cmdScript
                } else {
                    Start-Process cmd.exe -ArgumentList "/c `"$cmdScript`"" -Wait -WindowStyle Hidden
                }
            }
            
            if ($null -ne $global:PlatinumAppliedState) {
                $global:PlatinumAppliedState["debloat/ms_apps|$appId"] = $true
                if (Get-Command Save-TweakState -ErrorAction SilentlyContinue) { Save-TweakState }
            }

            Start-Sleep -Seconds 1
            $this.Content = $origContent
            if (Get-Command Show-CustomPopup -ErrorAction SilentlyContinue) {
                Show-CustomPopup "Application package forcefully uninstalled and removed." "Uninstalled" "Success"
            }
        }.GetNewClosure())
    }

    # Reinstall button (revert.cmd)
    $btnR = $ui.FindName("BTN_REINSTALL_DEBLOAT_MS_$appId")
    if ($null -ne $btnR) {
        $btnR.Add_Click({
            $origContent = $this.Content
            $this.Content = "Processing..."
            [System.Windows.Threading.Dispatcher]::CurrentDispatcher.Invoke("Render", [Action]{})
            
            if (Get-Command Log-ProgramAction -ErrorAction SilentlyContinue) {
                Log-ProgramAction -Action "Reinstall App" -Details "Reinstalling Microsoft App ID: $appId ($folderDir)"
            }
            
            $cmdScript = Join-Path $ModuleRoot "tweak\04_debloat\01_microsoftapp\$folderDir\revert.cmd"
            if (Test-Path $cmdScript) {
                if (Get-Command Invoke-LoggedBat -ErrorAction SilentlyContinue) {
                    Invoke-LoggedBat -BatPath $cmdScript
                } else {
                    Start-Process cmd.exe -ArgumentList "/c `"$cmdScript`"" -Wait -WindowStyle Hidden
                }
            }
            
            if ($null -ne $global:PlatinumAppliedState) {
                $global:PlatinumAppliedState["debloat/ms_apps|$appId"] = $false
                if (Get-Command Save-TweakState -ErrorAction SilentlyContinue) { Save-TweakState }
            }

            Start-Sleep -Seconds 1
            $this.Content = $origContent
            if (Get-Command Show-CustomPopup -ErrorAction SilentlyContinue) {
                Show-CustomPopup "Application components successfully reacquired and restored." "Re-installed" "Success"
            }
        }.GetNewClosure())
    }
}

# 1..16 OEM Apps Handlers
1..16 | ForEach-Object {
    $oemId = $_
    $folderDir = switch ($oemId) {
        1  { "01_hp_support_assistant" }
        2  { "02_hp_smart" }
        3  { "03_hp_jumpstart" }
        4  { "04_dell_supportassist" }
        5  { "05_dell_digital_delivery" }
        6  { "06_dell_optimizer" }
        7  { "07_lenovo_vantage" }
        8  { "08_lenovo_hotkeys" }
        9  { "09_myasus" }
        10 { "10_asus_armoury_crate" }
        11 { "11_samsung_settings" }
        12 { "12_samsung_update" }
        13 { "13_samsung_flow" }
        14 { "14_acer_care_center" }
        15 { "15_msi_center" }
        16 { "16_razer_cortex" }
    }

    # Dynamic high quality logo loader from logo.png
    $oemAppLogoPath = Join-Path $ModuleRoot "tweak\04_debloat\02_oemapp\$folderDir\logo.png"
    $imgLogo = $ui.FindName("IMG_LOGO_DEBLOAT_OEM_$oemId")
    $txtIcon = $ui.FindName("TXT_ICON_DEBLOAT_OEM_$oemId")
    if (Test-Path $oemAppLogoPath) {
        try {
            $absLogoPath = (Resolve-Path $oemAppLogoPath).Path
            $bitmap = New-Object System.Windows.Media.Imaging.BitmapImage
            $bitmap.BeginInit()
            $bitmap.CacheOption = [System.Windows.Media.Imaging.BitmapCacheOption]::OnLoad
            $bitmap.DecodePixelWidth = 256
            $bitmap.DecodePixelHeight = 256
            $bitmap.UriSource = New-Object System.Uri($absLogoPath)
            $bitmap.EndInit()
            $bitmap.Freeze()
            if ($null -ne $imgLogo) {
                [System.Windows.Media.RenderOptions]::SetBitmapScalingMode($imgLogo, [System.Windows.Media.BitmapScalingMode]::HighQuality)
                $imgLogo.Source = $bitmap
                $imgLogo.Width = 28
                $imgLogo.Height = 28
                $imgLogo.Stretch = [System.Windows.Media.Stretch]::Uniform
                $imgLogo.Visibility = [System.Windows.Visibility]::Visible
            }
            if ($null -ne $txtIcon) {
                $txtIcon.Visibility = [System.Windows.Visibility]::Collapsed
            }
        } catch {
            if ($null -ne $txtIcon) { $txtIcon.Visibility = [System.Windows.Visibility]::Visible }
        }
    } else {
        if ($null -ne $txtIcon) { $txtIcon.Visibility = [System.Windows.Visibility]::Visible }
    }

    # Dynamic description reader from description.txt
    $oemDescPath = Join-Path $ModuleRoot "tweak\04_debloat\02_oemapp\$folderDir\description.txt"
    if (Test-Path $oemDescPath) {
        $descTxt = (Get-Content $oemDescPath -Raw -ErrorAction SilentlyContinue)
        if ($null -ne $descTxt) { $descTxt = $descTxt.Trim() }
        $tbDesc = $ui.FindName("TXT_DESC_DEBLOAT_OEM_$oemId")
        if ($null -ne $tbDesc -and -not [string]::IsNullOrWhiteSpace($descTxt)) {
            $tbDesc.Text = $descTxt
        }
    }

    # Info button hover/click styles
    $btnI = $ui.FindName("BTN_INFO_DEBLOAT_OEM_$oemId")
    if ($null -ne $btnI) {
        $btnI.Add_MouseEnter({ 
            $tb = [System.Windows.Controls.TextBlock]$this.Child
            if ($null -ne $tb) { $tb.Foreground = "#00B4DB" }
        }.GetNewClosure())
        $btnI.Add_MouseLeave({ 
            $tb = [System.Windows.Controls.TextBlock]$this.Child
            if ($null -ne $tb) { $tb.Foreground = "#949BAA" }
        }.GetNewClosure())
        $btnI.Add_PreviewMouseLeftButtonDown({
            $tb = [System.Windows.Controls.TextBlock]$this.Child
            if ($null -ne $tb) { $tb.Foreground = "#00B4DB" }
        }.GetNewClosure())
    }

    # Uninstall button (apply.cmd)
    $btnU = $ui.FindName("BTN_UNINSTALL_DEBLOAT_OEM_$oemId")
    if ($null -ne $btnU) {
        $btnU.Add_Click({
            $origContent = $this.Content
            $this.Content = "Processing..."
            [System.Windows.Threading.Dispatcher]::CurrentDispatcher.Invoke("Render", [Action]{})
            
            if (Get-Command Log-ProgramAction -ErrorAction SilentlyContinue) {
                Log-ProgramAction -Action "Uninstall OEM App" -Details "Uninstalling OEM App ID: $oemId ($folderDir)"
            }
            
            $cmdScript = Join-Path $ModuleRoot "tweak\04_debloat\02_oemapp\$folderDir\apply.cmd"
            if (Test-Path $cmdScript) {
                if (Get-Command Invoke-LoggedBat -ErrorAction SilentlyContinue) {
                    Invoke-LoggedBat -BatPath $cmdScript
                } else {
                    Start-Process cmd.exe -ArgumentList "/c `"$cmdScript`"" -Wait -WindowStyle Hidden
                }
            }
            
            if ($null -ne $global:PlatinumAppliedState) {
                $global:PlatinumAppliedState["debloat/oem_apps|$oemId"] = $true
                if (Get-Command Save-TweakState -ErrorAction SilentlyContinue) { Save-TweakState }
            }

            Start-Sleep -Seconds 1
            $this.Content = $origContent
            if (Get-Command Show-CustomPopup -ErrorAction SilentlyContinue) {
                Show-CustomPopup "Application package forcefully uninstalled and removed." "Uninstalled" "Success"
            }
        }.GetNewClosure())
    }

    # Reinstall button (revert.cmd)
    $btnR = $ui.FindName("BTN_REINSTALL_DEBLOAT_OEM_$oemId")
    if ($null -ne $btnR) {
        $btnR.Add_Click({
            $origContent = $this.Content
            $this.Content = "Processing..."
            [System.Windows.Threading.Dispatcher]::CurrentDispatcher.Invoke("Render", [Action]{})
            
            if (Get-Command Log-ProgramAction -ErrorAction SilentlyContinue) {
                Log-ProgramAction -Action "Reinstall OEM App" -Details "Reinstalling OEM App ID: $oemId ($folderDir)"
            }
            
            $cmdScript = Join-Path $ModuleRoot "tweak\04_debloat\02_oemapp\$folderDir\revert.cmd"
            if (Test-Path $cmdScript) {
                if (Get-Command Invoke-LoggedBat -ErrorAction SilentlyContinue) {
                    Invoke-LoggedBat -BatPath $cmdScript
                } else {
                    Start-Process cmd.exe -ArgumentList "/c `"$cmdScript`"" -Wait -WindowStyle Hidden
                }
            }
            
            if ($null -ne $global:PlatinumAppliedState) {
                $global:PlatinumAppliedState["debloat/oem_apps|$oemId"] = $false
                if (Get-Command Save-TweakState -ErrorAction SilentlyContinue) { Save-TweakState }
            }

            Start-Sleep -Seconds 1
            $this.Content = $origContent
            if (Get-Command Show-CustomPopup -ErrorAction SilentlyContinue) {
                Show-CustomPopup "Application components successfully reacquired and restored." "Re-installed" "Success"
            }
        }.GetNewClosure())
    }
}

if ($null -eq $global:DebloatItemState) { $global:DebloatItemState = @{} }
$global:IsUpdatingDebloatUI = $false

$updateDebloatButtons = {
    if ($null -eq $ui) { return }
    $ac = 0
    $rc = 0
    if ($null -ne $global:DebloatItemState) {
        foreach ($key in $global:DebloatItemState.Keys) {
            $item = $global:DebloatItemState[$key]
            if ($null -ne $item.Toggle) {
                if ($item.Toggle.IsChecked -and -not $item.Applied) { $ac++ }
                if (-not $item.Toggle.IsChecked -and $item.Applied) { $rc++ }
            }
        }
    }
    $applyBtn  = $ui.FindName('BTN_APPLY_DEBLOAT_TWEAKS')
    $revertBtn = $ui.FindName('BTN_REVERT_DEBLOAT_TWEAKS')
    if ($null -ne $applyBtn) {
        $applyBtn.Content = "Apply Tweaks ($ac)"
        if (Get-Command Set-TweakButtonState -ErrorAction SilentlyContinue) {
            Set-TweakButtonState 'BTN_APPLY_DEBLOAT_TWEAKS' $ac
        }
    }
    if ($null -ne $revertBtn) {
        $revertBtn.Content = "Revert Tweaks ($rc)"
        if (Get-Command Set-TweakButtonState -ErrorAction SilentlyContinue) {
            Set-TweakButtonState 'BTN_REVERT_DEBLOAT_TWEAKS' $rc
        }
    }
}.GetNewClosure()

# 1..12 Components Handlers
1..12 | ForEach-Object {
    $compId = $_
    $folderDir = switch ($compId) {
        1  { "01_disable_background_maintenance" }
        2  { "02_disable_automated_update_services" }
        3  { "03_disable_peripheral_printing_and_accessory_tasks" }
        4  { "04_disable_localization_and_time_synchronization_tasks" }
        5  { "05_disable_sensors_broadcasts_and_mixed_reality_services" }
        6  { "06_disable_virtualization_hypervisor_and_elam_overhead" }
        7  { "07_disable_hyper_v_and_virtualization_services" }
        8  { "08_disable_search_indexing_and_web_integration" }
        9  { "09_disable_uxd_support_and_device_caching" }
        10 { "10_disable_printer_services_for_system_environment" }
        11 { "11_disable_printer_policies_for_windows" }
        12 { "12_disable_windows_update_and_background_servicing" }
    }

    # Dynamic description reader from description.txt
    $compDescPath = Join-Path $ModuleRoot "tweak\04_debloat\03_components\$folderDir\description.txt"
    if (Test-Path $compDescPath) {
        $descTxt = (Get-Content $compDescPath -Raw -ErrorAction SilentlyContinue)
        if ($null -ne $descTxt) { $descTxt = $descTxt.Trim() }
        $tbDesc = $ui.FindName("TXT_DESC_DEBLOAT_COMP_$compId")
        if ($null -ne $tbDesc -and -not [string]::IsNullOrWhiteSpace($descTxt)) {
            $tbDesc.Text = $descTxt
        }
    }

    # Info button hover/click styles
    $btnI = $ui.FindName("BTN_INFO_DEBLOAT_COMP_$compId")
    if ($null -ne $btnI) {
        $btnI.Add_MouseEnter({ 
            $tb = [System.Windows.Controls.TextBlock]$this.Child
            if ($null -ne $tb) { $tb.Foreground = "#00B4DB" }
        }.GetNewClosure())
        $btnI.Add_MouseLeave({ 
            $tb = [System.Windows.Controls.TextBlock]$this.Child
            if ($null -ne $tb) { $tb.Foreground = "#949BAA" }
        }.GetNewClosure())
        $btnI.Add_PreviewMouseLeftButtonDown({
            $tb = [System.Windows.Controls.TextBlock]$this.Child
            if ($null -ne $tb) { $tb.Foreground = "#00B4DB" }
        }.GetNewClosure())
    }

    # Register toggle switch into batch state
    $toggle = $ui.FindName("TOGGLE_DEBLOAT_COMP_$compId")
    if ($null -ne $toggle) {
        $key = "COMP_$compId"
        $global:DebloatItemState[$key] = @{
            Toggle    = $toggle
            ApplyCmd  = (Join-Path $ModuleRoot "tweak\04_debloat\03_components\$folderDir\apply.cmd")
            RevertCmd = (Join-Path $ModuleRoot "tweak\04_debloat\03_components\$folderDir\revert.cmd")
            Applied   = $false
            Name      = "Component ID: $compId ($folderDir)"
        }
        $toggle.Add_Checked({
            if ($global:IsUpdatingDebloatUI) { return }
            & $updateDebloatButtons
        }.GetNewClosure())
        $toggle.Add_Unchecked({
            if ($global:IsUpdatingDebloatUI) { return }
            & $updateDebloatButtons
        }.GetNewClosure())
    }
}

# 1..11 Telemetry Handlers
1..11 | ForEach-Object {
    $telemId = $_
    $folderDir = switch ($telemId) {
        1  { "01_disable_telemetry_data_collection" }
        2  { "02_disable_error_reporting_and_diagnostics" }
        3  { "03_disable_third_party_and_ai_telemetry" }
        4  { "04_disable_usb_telemetry_and_diagnostic_subsystems" }
        5  { "05_disable_usb_debugging_and_telemetry_logging" }
        6  { "06_disable_usb_hub_diagnostics_and_debug_logging" }
        7  { "07_disable_audio_diagnostics_telemetry_and_watchdog_timers" }
        8  { "08_disable_general_telemetry_and_diagnostic_data_collection" }
        9  { "09_disable_cloud_and_telemetry_features_for_reduced_overhead" }
        10 { "10_disable_wmplayer_telemetry_and_optimize_video_playback_for_media_subsystem" }
        11 { "11_disable_dwm_heap_logging" }
    }

    # Dynamic description reader from description.txt
    $telemDescPath = Join-Path $ModuleRoot "tweak\04_debloat\04_telemetry\$folderDir\description.txt"
    if (Test-Path $telemDescPath) {
        $descTxt = (Get-Content $telemDescPath -Raw -ErrorAction SilentlyContinue)
        if ($null -ne $descTxt) { $descTxt = $descTxt.Trim() }
        $tbDesc = $ui.FindName("TXT_DESC_DEBLOAT_TELEM_$telemId")
        if ($null -ne $tbDesc -and -not [string]::IsNullOrWhiteSpace($descTxt)) {
            $tbDesc.Text = $descTxt
        }
    }

    # Info button hover/click styles
    $btnI = $ui.FindName("BTN_INFO_DEBLOAT_TELEM_$telemId")
    if ($null -ne $btnI) {
        $btnI.Add_MouseEnter({ 
            $tb = [System.Windows.Controls.TextBlock]$this.Child
            if ($null -ne $tb) { $tb.Foreground = "#00B4DB" }
        }.GetNewClosure())
        $btnI.Add_MouseLeave({ 
            $tb = [System.Windows.Controls.TextBlock]$this.Child
            if ($null -ne $tb) { $tb.Foreground = "#949BAA" }
        }.GetNewClosure())
        $btnI.Add_PreviewMouseLeftButtonDown({
            $tb = [System.Windows.Controls.TextBlock]$this.Child
            if ($null -ne $tb) { $tb.Foreground = "#00B4DB" }
        }.GetNewClosure())
    }

    # Register toggle switch into batch state
    $toggle = $ui.FindName("TOGGLE_DEBLOAT_TELEM_$telemId")
    if ($null -ne $toggle) {
        $key = "TELEM_$telemId"
        $global:DebloatItemState[$key] = @{
            Toggle    = $toggle
            ApplyCmd  = (Join-Path $ModuleRoot "tweak\04_debloat\04_telemetry\$folderDir\apply.cmd")
            RevertCmd = (Join-Path $ModuleRoot "tweak\04_debloat\04_telemetry\$folderDir\revert.cmd")
            Applied   = $false
            Name      = "Telemetry ID: $telemId ($folderDir)"
        }
        $toggle.Add_Checked({
            if ($global:IsUpdatingDebloatUI) { return }
            & $updateDebloatButtons
        }.GetNewClosure())
        $toggle.Add_Unchecked({
            if ($global:IsUpdatingDebloatUI) { return }
            & $updateDebloatButtons
        }.GetNewClosure())
    }
}

# 1..4 Privacy Handlers
1..4 | ForEach-Object {
    $privId = $_
    $folderDir = switch ($privId) {
        1  { "01_disable_start_menu_tracking_and_app_notifications" }
        2  { "02_disable_suggestions_tips_and_windows_spotlight_for_ui" }
        3  { "03_disable_microsoft_copilot_and_ai_features_for_shell_subsystem" }
        4  { "04_disable_notifications_and_privacy_intrusions" }
    }

    # Dynamic description reader from description.txt
    $privDescPath = Join-Path $ModuleRoot "tweak\04_debloat\05_privacy\$folderDir\description.txt"
    if (Test-Path $privDescPath) {
        $descTxt = (Get-Content $privDescPath -Raw -ErrorAction SilentlyContinue)
        if ($null -ne $descTxt) { $descTxt = $descTxt.Trim() }
        $tbDesc = $ui.FindName("TXT_DESC_DEBLOAT_PRIV_$privId")
        if ($null -ne $tbDesc -and -not [string]::IsNullOrWhiteSpace($descTxt)) {
            $tbDesc.Text = $descTxt
        }
    }

    # Info button hover/click styles
    $btnI = $ui.FindName("BTN_INFO_DEBLOAT_PRIV_$privId")
    if ($null -ne $btnI) {
        $btnI.Add_MouseEnter({ 
            $tb = [System.Windows.Controls.TextBlock]$this.Child
            if ($null -ne $tb) { $tb.Foreground = "#00B4DB" }
        }.GetNewClosure())
        $btnI.Add_MouseLeave({ 
            $tb = [System.Windows.Controls.TextBlock]$this.Child
            if ($null -ne $tb) { $tb.Foreground = "#949BAA" }
        }.GetNewClosure())
        $btnI.Add_PreviewMouseLeftButtonDown({
            $tb = [System.Windows.Controls.TextBlock]$this.Child
            if ($null -ne $tb) { $tb.Foreground = "#00B4DB" }
        }.GetNewClosure())
    }

    # Register toggle switch into batch state
    $toggle = $ui.FindName("TOGGLE_DEBLOAT_PRIV_$privId")
    if ($null -ne $toggle) {
        $key = "PRIV_$privId"
        $global:DebloatItemState[$key] = @{
            Toggle    = $toggle
            ApplyCmd  = (Join-Path $ModuleRoot "tweak\04_debloat\05_privacy\$folderDir\apply.cmd")
            RevertCmd = (Join-Path $ModuleRoot "tweak\04_debloat\05_privacy\$folderDir\revert.cmd")
            Applied   = $false
            Name      = "Privacy ID: $privId ($folderDir)"
        }
        $toggle.Add_Checked({
            if ($global:IsUpdatingDebloatUI) { return }
            & $updateDebloatButtons
        }.GetNewClosure())
        $toggle.Add_Unchecked({
            if ($global:IsUpdatingDebloatUI) { return }
            & $updateDebloatButtons
        }.GetNewClosure())
    }
}

# Attach Apply and Revert button actions for Debloat
$btnApplyDebloat = $ui.FindName("BTN_APPLY_DEBLOAT_TWEAKS")
if ($null -ne $btnApplyDebloat) {
    $btnApplyDebloat.Add_Click({
        if ($null -eq $global:DebloatItemState) { return }
        $tabPrefix = switch ($global:SelectedDebloatTab) {
            "TAB_DEBLOAT_COMPONENTS" { "COMP_" }
            "TAB_DEBLOAT_TELEMETRY"  { "TELEM_" }
            "TAB_DEBLOAT_PRIVACY"    { "PRIV_" }
            default { "" }
        }
        if (-not $tabPrefix) { return }

        $appliedCount = 0
        foreach ($key in @($global:DebloatItemState.Keys)) {
            if ($key.StartsWith($tabPrefix)) {
                $item = $global:DebloatItemState[$key]
                if ($null -ne $item.Toggle -and $item.Toggle.IsChecked -and -not $item.Applied) {
                    $cmdScript = $item.ApplyCmd
                    if (Test-Path $cmdScript) {
                        if (Get-Command Log-ProgramAction -ErrorAction SilentlyContinue) {
                            Log-ProgramAction -Action "Enable Debloat Tweak" -Details $item.Name
                        }
                        if (Get-Command Invoke-LoggedBat -ErrorAction SilentlyContinue) {
                            Invoke-LoggedBat -BatPath $cmdScript
                        } else {
                            Start-Process cmd.exe -ArgumentList "/c `"$cmdScript`"" -Wait -WindowStyle Hidden
                        }
                        $item.Applied = $true
                        $stateKey = switch -Wildcard ($key) {
                            "COMP_*"  { "debloat/components|" + $key.Replace("COMP_","") }
                            "TELEM_*" { "debloat/telemetry|" + $key.Replace("TELEM_","") }
                            "PRIV_*"  { "debloat/privacy|" + $key.Replace("PRIV_","") }
                        }
                        if ($stateKey -and $null -ne $global:PlatinumAppliedState) {
                            $global:PlatinumAppliedState[$stateKey] = $true
                        }
                        $appliedCount++
                    }
                }
            }
        }
        if (Get-Command Save-TweakState -ErrorAction SilentlyContinue) { Save-TweakState }
        & $updateDebloatButtons
        if ($appliedCount -gt 0) {
            if (Get-Command Show-CustomPopup -ErrorAction SilentlyContinue) {
                Show-CustomPopup "Selected debloat tweaks ($appliedCount) applied successfully." "Tweaks Applied" "Success"
            }
        }
    }.GetNewClosure())
}

$btnRevertDebloat = $ui.FindName("BTN_REVERT_DEBLOAT_TWEAKS")
if ($null -ne $btnRevertDebloat) {
    $btnRevertDebloat.Add_Click({
        if ($null -eq $global:DebloatItemState) { return }
        $tabPrefix = switch ($global:SelectedDebloatTab) {
            "TAB_DEBLOAT_COMPONENTS" { "COMP_" }
            "TAB_DEBLOAT_TELEMETRY"  { "TELEM_" }
            "TAB_DEBLOAT_PRIVACY"    { "PRIV_" }
            default { "" }
        }
        if (-not $tabPrefix) { return }

        $revertedCount = 0
        foreach ($key in @($global:DebloatItemState.Keys)) {
            if ($key.StartsWith($tabPrefix)) {
                $item = $global:DebloatItemState[$key]
                if ($null -ne $item.Toggle -and -not $item.Toggle.IsChecked -and $item.Applied) {
                    $cmdScript = $item.RevertCmd
                    if (Test-Path $cmdScript) {
                        if (Get-Command Log-ProgramAction -ErrorAction SilentlyContinue) {
                            Log-ProgramAction -Action "Disable Debloat Tweak" -Details $item.Name
                        }
                        if (Get-Command Invoke-LoggedBat -ErrorAction SilentlyContinue) {
                            Invoke-LoggedBat -BatPath $cmdScript
                        } else {
                            Start-Process cmd.exe -ArgumentList "/c `"$cmdScript`"" -Wait -WindowStyle Hidden
                        }
                        $item.Applied = $false
                        $stateKey = switch -Wildcard ($key) {
                            "COMP_*"  { "debloat/components|" + $key.Replace("COMP_","") }
                            "TELEM_*" { "debloat/telemetry|" + $key.Replace("TELEM_","") }
                            "PRIV_*"  { "debloat/privacy|" + $key.Replace("PRIV_","") }
                        }
                        if ($stateKey -and $null -ne $global:PlatinumAppliedState) {
                            $global:PlatinumAppliedState[$stateKey] = $false
                        }
                        $revertedCount++
                    }
                }
            }
        }
        if (Get-Command Save-TweakState -ErrorAction SilentlyContinue) { Save-TweakState }
        & $updateDebloatButtons
        if ($revertedCount -gt 0) {
            if (Get-Command Show-CustomPopup -ErrorAction SilentlyContinue) {
                Show-CustomPopup "Selected debloat tweaks ($revertedCount) reverted successfully." "Tweaks Reverted" "Success"
            }
        }
    }.GetNewClosure())
}

function Update-DebloatStateUI {
    if ($null -eq $global:DebloatItemState) { return }
    $global:IsUpdatingDebloatUI = $true
    try {
        1..12 | ForEach-Object {
            $compId = $_
            $key = "COMP_$compId"
            $stateKey = "debloat/components|$compId"
            $isApplied = ($null -ne $global:PlatinumAppliedState) -and ($global:PlatinumAppliedState[$stateKey] -eq $true)
            $item = $global:DebloatItemState[$key]
            if ($null -ne $item) {
                $item.Applied = $isApplied
                if ($null -ne $item.Toggle) {
                    $item.Toggle.IsChecked = $isApplied
                }
            }
        }

        1..11 | ForEach-Object {
            $telemId = $_
            $key = "TELEM_$telemId"
            $stateKey = "debloat/telemetry|$telemId"
            $isApplied = ($null -ne $global:PlatinumAppliedState) -and ($global:PlatinumAppliedState[$stateKey] -eq $true)
            $item = $global:DebloatItemState[$key]
            if ($null -ne $item) {
                $item.Applied = $isApplied
                if ($null -ne $item.Toggle) {
                    $item.Toggle.IsChecked = $isApplied
                }
            }
        }

        1..4 | ForEach-Object {
            $privId = $_
            $key = "PRIV_$privId"
            $stateKey = "debloat/privacy|$privId"
            $isApplied = ($null -ne $global:PlatinumAppliedState) -and ($global:PlatinumAppliedState[$stateKey] -eq $true)
            $item = $global:DebloatItemState[$key]
            if ($null -ne $item) {
                $item.Applied = $isApplied
                if ($null -ne $item.Toggle) {
                    $item.Toggle.IsChecked = $isApplied
                }
            }
        }
    } finally {
        $global:IsUpdatingDebloatUI = $false
    }
    if ($updateDebloatButtons) {
        & $updateDebloatButtons
    }
}

& $updateDebloatButtons