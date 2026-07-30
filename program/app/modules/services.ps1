# Service Manager Module
$global:serviceCards = @()
$global:serviceGrid = $ui.FindName('SERVICE_OPTIONS_LIST')
for ($i=1; $i -le 16; $i++) { 
    $card = $ui.FindName("CARD_SERVICE_$i")
    if ($null -ne $card) { $global:serviceCards += $card }
}

$inpServiceSearch = $ui.FindName("INP_SERVICE_SEARCH")
if ($null -ne $inpServiceSearch) {
    $inpServiceSearch.Add_GotKeyboardFocus({ 
        if ($this.Text -eq "Search services...") { $this.Text = ""; $this.Foreground = "#FFF" } 
    })
    $inpServiceSearch.Add_LostKeyboardFocus({ 
        if ([string]::IsNullOrWhiteSpace($this.Text)) { $this.Text = "Search services..."; $this.Foreground = "#949BAA" } 
    })
    $inpServiceSearch.Add_TextChanged({
        $q = $this.Text.ToLower().Trim()
        if ($q -eq 'search services...') { $q = '' }
        $titles = @{
            1  = 'disable system core telemetry and diagnostics'
            2  = 'disable system maintenance and background activity'
            3  = 'disable windows update, store, and edge services'
            4  = 'disable network discovery and file sharing services'
            5  = 'disable virtualization and hyper-v services'
            6  = 'disable bluetooth, wi-fi, and device polling'
            7  = 'disable bluetooth subsystem and services'
            8  = 'disable printing, imaging, and legacy hardware'
            9  = 'disable security, defender, and authentication'
            10 = 'disable gaming, xbox, and peripheral services'
            11 = 'disable gamedvr and xbox game bar'
        }
        if ($null -ne $global:serviceGrid) {
            $global:serviceGrid.Children.Clear()
            for ($i=0; $i -lt $global:serviceCards.Count; $i++) {
                if ($q -eq '' -or ($titles.ContainsKey($i+1) -and $titles[$i+1].Contains($q))) {
                    $global:serviceGrid.Children.Add($global:serviceCards[$i])
                }
            }
        }
        $sv = $ui.FindName('SCROLL_SERVICE')
        if ($null -ne $sv) { $sv.ScrollToTop() }
    })
}

1..11 | ForEach-Object {
    $serviceId = $_
    $folderDir = switch ($serviceId) {
        1  { "01_telemetry_diagnostics" }
        2  { "02_system_maintenance" }
        3  { "03_windows_update_store_edge" }
        4  { "04_network_discovery_file_sharing" }
        5  { "05_virtualization_hyperv" }
        6  { "06_bluetooth_wifi_device_polling" }
        7  { "07_bluetooth_subsystem" }
        8  { "08_printing_imaging_legacy_hardware" }
        9  { "09_security_defender_authentication" }
        10 { "10_gaming_xbox_peripheral" }
        11 { "11_gamedvr_xbox_game_bar" }
    }

    # Load description dynamically from description.txt
    $descPath = "$ModuleRoot\tweak\03_services\$folderDir\description.txt"
    if (Test-Path $descPath) {
        $descTxt = (Get-Content $descPath -Raw).Trim()
        $tbDesc = $ui.FindName("TXT_DESC_SRV_$serviceId")
        if ($null -ne $tbDesc -and -not [string]::IsNullOrWhiteSpace($descTxt)) {
            $tbDesc.Text = $descTxt
        }
    }

    $bDis = $ui.FindName("BTN_DISABLE_SRV_$serviceId")
    if ($null -ne $bDis) {
        $bDis.Add_Click({
            $origContent = $this.Content
            $this.Content = "Processing..."
            [System.Windows.Threading.Dispatcher]::CurrentDispatcher.Invoke("Render", [Action]{})

            # Log the action
            if (Get-Command Log-ProgramAction -ErrorAction SilentlyContinue) {
                Log-ProgramAction -Action "Disable Service Group" -Details "Executing apply.cmd for service group ID: $serviceId ($folderDir)"
            }

            # Execute apply.cmd in target folder
            $cmdPath = "$ModuleRoot\tweak\03_services\$folderDir\apply.cmd"
            if (Test-Path $cmdPath) {
                if (Get-Command Invoke-LoggedBat -ErrorAction SilentlyContinue) {
                    Invoke-LoggedBat -BatPath $cmdPath
                } else {
                    Start-Process $cmdPath -Wait -WindowStyle Hidden
                }
            }

            if ($null -ne $global:PlatinumAppliedState) {
                $global:PlatinumAppliedState["services|$serviceId"] = $true
                if (Get-Command Save-TweakState -ErrorAction SilentlyContinue) { Save-TweakState }
            }

            Start-Sleep -Seconds 1
            $this.Content = $origContent
            if (Get-Command Show-CustomPopup -ErrorAction SilentlyContinue) {
                Show-CustomPopup "Target service group has been disabled." "Service Disabled" "Success"
            }
        }.GetNewClosure())
    }

    $bEn = $ui.FindName("BTN_ENABLE_SRV_$serviceId")
    if ($null -ne $bEn) {
        $bEn.Add_Click({
            $origContent = $this.Content
            $this.Content = "Processing..."
            [System.Windows.Threading.Dispatcher]::CurrentDispatcher.Invoke("Render", [Action]{})

            # Log the action
            if (Get-Command Log-ProgramAction -ErrorAction SilentlyContinue) {
                Log-ProgramAction -Action "Enable Service Group" -Details "Executing revert.cmd for service group ID: $serviceId ($folderDir)"
            }

            # Execute revert.cmd in target folder
            $cmdPath = "$ModuleRoot\tweak\03_services\$folderDir\revert.cmd"
            if (Test-Path $cmdPath) {
                if (Get-Command Invoke-LoggedBat -ErrorAction SilentlyContinue) {
                    Invoke-LoggedBat -BatPath $cmdPath
                } else {
                    Start-Process cmd.exe -ArgumentList "/c `"$cmdPath`"" -Wait -WindowStyle Hidden
                }
            }

            if ($null -ne $global:PlatinumAppliedState) {
                $global:PlatinumAppliedState["services|$serviceId"] = $false
                if (Get-Command Save-TweakState -ErrorAction SilentlyContinue) { Save-TweakState }
            }

            Start-Sleep -Seconds 1
            $this.Content = $origContent
            if (Get-Command Show-CustomPopup -ErrorAction SilentlyContinue) {
                Show-CustomPopup "Target service group has been re-enabled." "Service Re-enabled" "Success"
            }
        }.GetNewClosure())
    }
}

1..11 | ForEach-Object {
    $btnSrvInfo = $ui.FindName("BTN_INFO_SRV_$_")
    if ($null -ne $btnSrvInfo) {
        $btnSrvInfo.Add_MouseEnter({ 
            $tb = [System.Windows.Controls.TextBlock]$this.Child; if ($tb) { $tb.Foreground = "#00B4DB" }
        })
        $btnSrvInfo.Add_MouseLeave({ 
            $tb = [System.Windows.Controls.TextBlock]$this.Child; if ($tb) { $tb.Foreground = "#949BAA" }
        })
        $btnSrvInfo.Add_PreviewMouseLeftButtonDown({
            $tb = [System.Windows.Controls.TextBlock]$this.Child
            if ($tb) { $tb.Foreground = "#00B4DB" }
        })
    }
}
