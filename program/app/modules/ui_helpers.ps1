# UI Helper Functions
function Get-PrimaryEthernetAdapter {
    try {
        $virtualPattern = '(Hyper-V|Virtual|VMware|VirtualBox|vEthernet|Loopback|TAP-WIN|TAP|Tunnel|Bluetooth|Wi-?Fi|Wireless|WAN Miniport|Npcap|Kernel Debugger|Pseudo|Default Switch|Host-Only)'

        $adapters = @(Get-NetAdapter -ErrorAction SilentlyContinue | Where-Object {
            if ($_.MediaType -and $_.MediaType -ne '802.3') { return $false }
            if ($_.Virtual -eq $true) { return $false }
            if ($_.Name -match $virtualPattern) { return $false }
            if ($_.InterfaceDescription -match $virtualPattern) { return $false }
            if ($_.Status -eq 'NotPresent') { return $false }
            $true
        })

        if ($adapters.Count -eq 0) { return $null }

        return $adapters | Sort-Object @{ Expression = { if ($_.Status -eq 'Up') { 0 } else { 1 } } }, InterfaceIndex | Select-Object -First 1
    } catch {
        return $null
    }
}

function Get-PrimaryWirelessAdapter {
    try {
        $virtualPattern = '(Hyper-V|Virtual|VMware|VirtualBox|vEthernet|Loopback|TAP-WIN|TAP|Tunnel|Bluetooth|WAN Miniport|Npcap|Kernel Debugger|Pseudo|Default Switch|Host-Only)'

        $adapters = @(Get-NetAdapter -ErrorAction SilentlyContinue | Where-Object {
            if ($_.Virtual -eq $true) { return $false }
            if ($_.Name -match $virtualPattern) { return $false }
            if ($_.InterfaceDescription -match $virtualPattern) { return $false }
            if ($_.Status -eq 'NotPresent') { return $false }
            if ($_.MediaType -match '802\.11|Native802') { return $true }
            if ($_.Name -match 'Wi-?Fi|Wireless') { return $true }
            if ($_.InterfaceDescription -match 'Wi-?Fi|Wireless') { return $true }
            $false
        })

        if ($adapters.Count -eq 0) { return $null }

        return $adapters | Sort-Object @{ Expression = { if ($_.Status -eq 'Up') { 0 } else { 1 } } }, InterfaceIndex | Select-Object -First 1
    } catch {
        return $null
    }
}

function Get-PrimaryNetworkAdapter {
    $eth = Get-PrimaryEthernetAdapter
    $wifi = Get-PrimaryWirelessAdapter

    if ($eth -and $eth.Status -eq 'Up') {
        return [PSCustomObject]@{ Adapter = $eth; ConnectionType = 'Ethernet' }
    }
    if ($wifi -and $wifi.Status -eq 'Up') {
        return [PSCustomObject]@{ Adapter = $wifi; ConnectionType = 'Wireless' }
    }
    if ($eth) {
        return [PSCustomObject]@{ Adapter = $eth; ConnectionType = 'Ethernet' }
    }
    if ($wifi) {
        return [PSCustomObject]@{ Adapter = $wifi; ConnectionType = 'Wireless' }
    }
    return $null
}

function Show-CustomPopup([string]$Message, [string]$Title="System Alert", [string]$Tone="Default", [switch]$ShowContinue) {
    $ui.FindName("MODAL_TITLE").Text = $Title
    $ui.FindName("MODAL_MESSAGE").Text = $Message

    $subtitle = $ui.FindName("MODAL_SUBTITLE")
    $iconBox  = $ui.FindName("MODAL_ICON_BOX")
    $iconImage = $ui.FindName("MODAL_ICON_IMAGE")

    # Helper: load a bitmap from a global path variable
    function Set-ModalIcon([string]$icoPath) {
        if ($iconImage -and $icoPath -and (Test-Path $icoPath)) {
            $bmp = [System.Windows.Media.Imaging.BitmapImage]::new()
            $bmp.BeginInit()
            $bmp.UriSource = [System.Uri]::new($icoPath)
            $bmp.CacheOption = [System.Windows.Media.Imaging.BitmapCacheOption]::OnLoad
            $bmp.EndInit()
            $iconImage.Source = $bmp
        } elseif ($iconImage) {
            $iconImage.Source = $null
        }
    }

    if ($iconBox) { $iconBox.Background = "#111620"; $iconBox.BorderBrush = "#1A2030" }

    switch ($Tone) {
        "Success" {
            if ($subtitle) { $subtitle.Text = "Platinum+ Notification" }
            Set-ModalIcon $global:Check1Ico   # check1.png
        }
        "Error" {
            if ($subtitle) { $subtitle.Text = "Platinum+ Notification" }
            Set-ModalIcon $global:ErrorIco    # error.png
        }
        "Warning" {
            if ($subtitle) { $subtitle.Text = "Platinum+ Notification" }
            Set-ModalIcon $global:AlertIco    # alert.png
        }
        "Sync" {
            if ($subtitle) { $subtitle.Text = "Backup & Restore status" }
            Set-ModalIcon $null
        }
        "CpuWarning" {
            if ($subtitle) { $subtitle.Text = "CPU Tweaks status" }
            Set-ModalIcon $global:AlertIco
        }
        default {
            if ($subtitle) { $subtitle.Text = "Platinum+ Notification" }
            Set-ModalIcon $null
        }
    }

    $btnContinue = $ui.FindName("BTN_MODAL_CONTINUE")
    $btnOk = $ui.FindName("BTN_MODAL_OK")
    if ($btnContinue -and $btnOk) {
        if ($ShowContinue) {
            $btnContinue.Visibility = 'Visible'
            $btnOk.Content = "Close"
        } else {
            $btnContinue.Visibility = 'Collapsed'
            $btnOk.Content = "Okay"
        }
    }

    $overlay = $ui.FindName("MODAL_OVERLAY")
    $card = $ui.FindName("MODAL_CARD")
    if (-not $overlay) { return }
    $overlay.BeginAnimation([System.Windows.UIElement]::OpacityProperty, $null)
    $overlay.Visibility = 'Visible'

    try {
        $overlay.Opacity = 0
        $fade = New-Object System.Windows.Media.Animation.DoubleAnimation
        $fade.From = 0
        $fade.To = 1
        $fade.Duration = [TimeSpan]::FromMilliseconds(160)

        $ease = New-Object System.Windows.Media.Animation.CubicEase
        $ease.EasingMode = [System.Windows.Media.Animation.EasingMode]::EaseOut
        $fade.EasingFunction = $ease
        $overlay.BeginAnimation([System.Windows.UIElement]::OpacityProperty, $fade)

        if ($card -and $card.RenderTransform -is [System.Windows.Media.TranslateTransform]) {
            $card.RenderTransform.Y = 12
            $slide = New-Object System.Windows.Media.Animation.DoubleAnimation
            $slide.From = 12
            $slide.To = 0
            $slide.Duration = [TimeSpan]::FromMilliseconds(180)
            $slide.EasingFunction = $ease
            $card.RenderTransform.BeginAnimation([System.Windows.Media.TranslateTransform]::YProperty, $slide)
        }
    } catch {
        $overlay.Opacity = 1
    }
}

function Hide-CustomPopup {
    $overlay = $ui.FindName("MODAL_OVERLAY")
    $card = $ui.FindName("MODAL_CARD")

    if (-not $overlay -or $overlay.Visibility -ne 'Visible') { return }
    $overlayRef = $overlay

    try {
        $overlay.BeginAnimation([System.Windows.UIElement]::OpacityProperty, $null)
        $fade = New-Object System.Windows.Media.Animation.DoubleAnimation
        $fade.From = $overlay.Opacity
        $fade.To = 0
        $fade.Duration = [TimeSpan]::FromMilliseconds(150)

        $ease = New-Object System.Windows.Media.Animation.CubicEase
        $ease.EasingMode = [System.Windows.Media.Animation.EasingMode]::EaseIn
        $fade.EasingFunction = $ease
        $fade.Add_Completed({
            $overlayRef.Visibility = [System.Windows.Visibility]::Hidden
            $overlayRef.Opacity = 0
        }.GetNewClosure())
        $overlay.BeginAnimation([System.Windows.UIElement]::OpacityProperty, $fade)

        if ($card -and $card.RenderTransform -is [System.Windows.Media.TranslateTransform]) {
            $slide = New-Object System.Windows.Media.Animation.DoubleAnimation
            $slide.From = $card.RenderTransform.Y
            $slide.To = 8
            $slide.Duration = [TimeSpan]::FromMilliseconds(150)
            $slide.EasingFunction = $ease
            $card.RenderTransform.BeginAnimation([System.Windows.Media.TranslateTransform]::YProperty, $slide)
        }
    } catch {
        $overlay.Visibility = 'Hidden'
        $overlay.Opacity = 0
    }
}

function Initialize-LocalBurntToast {
    if ($global:BurntToastReady) { return $true }
    if (-not $global:BurntToastModulePath -or -not (Test-Path -LiteralPath $global:BurntToastModulePath)) { return $false }

    try {
        Import-Module -Name $global:BurntToastModulePath -Force -ErrorAction Stop
        $global:BurntToastReady = $true
        return $true
    } catch {
        $global:BurntToastReady = $false
        return $false
    }
}

function Show-CustomToast([string]$Message, [string]$Title="Notification", [string]$Tone="Default") {
    if (-not (Initialize-LocalBurntToast)) { return }

    $splat = @{
        Text             = @($Title, $Message)
        Silent           = $true
        UniqueIdentifier = ($Title -replace '[^a-zA-Z0-9_.-]', '_')
        ExpirationTime   = (Get-Date).AddMinutes(5)
    }

    if ($global:NotificationIco -and (Test-Path -LiteralPath $global:NotificationIco)) {
        $splat.AppLogo = $global:NotificationIco
    }

    try {
        New-BurntToastNotification @splat -ErrorAction Stop | Out-Null
    } catch {}
}

function Hide-CustomToast {
    # Native Windows toast notifications are dismissed by Windows.
}

function Show-ConfirmationDialog([string]$Message, [string]$Title="Confirm") {
    Add-Type -AssemblyName PresentationFramework
    $result = [System.Windows.MessageBox]::Show($Message, $Title, "YesNo", "Warning")
    return $result -eq "Yes"
}

function Load-AppBackups {
    $ui.FindName("BTN_DO_APPLY_RP").Opacity = 0.4; $ui.FindName("BTN_DO_APPLY_RP").IsEnabled = $false
    $ui.FindName("BTN_DO_DEL_RP").Opacity = 0.4; $ui.FindName("BTN_DO_DEL_RP").IsEnabled = $false
    $ui.FindName("BTN_DO_APPLY_REG").Opacity = 0.4; $ui.FindName("BTN_DO_APPLY_REG").IsEnabled = $false
    $ui.FindName("BTN_DO_DEL_REG").Opacity = 0.4; $ui.FindName("BTN_DO_DEL_REG").IsEnabled = $false

    $rpList = $ui.FindName("LIST_RP")
    if ($rpList) {
        $rpList.Items.Clear()
        $rpPath = "$PSScriptRoot\..\tweak\01_backup\restore_point\restore"
        if (Test-Path $rpPath) {
            $rps = Get-ChildItem -Path $rpPath -Filter "*.txt" | Sort-Object LastWriteTime -Descending
            foreach ($r in $rps) { $rpList.Items.Add($r.Name) | Out-Null }
        }
    }
    
    $regList = $ui.FindName("LIST_REG")
    if ($regList) {
        $regList.Items.Clear()
        $regPath = "$PSScriptRoot\..\tweak\01_backup\registry_backup\registry"
        if (Test-Path $regPath) {
            $regs = Get-ChildItem -Path $regPath -Filter "*.reg" | Sort-Object LastWriteTime -Descending
            foreach ($r in $regs) { $regList.Items.Add($r.Name) | Out-Null }
        }
    }
}

function Set-TweakButtonState([string]$btnName, [int]$count) {
    $btn = $ui.FindName($btnName)
    if ($null -ne $btn) {
        if ($count -gt 0) {
            $btn.IsEnabled = $true
            $btn.Opacity = 1.0
        } else {
            $btn.IsEnabled = $false
            $btn.Opacity = 0.4
        }
    }
}
