. "$ModuleRoot\modules\tweak_catalog_runtime.ps1"
Initialize-PlatinumCatalogSection -Name 'NetState' -Categories @('network_tweaks/tcpip', 'network_tweaks/wifi', 'network_tweaks/adapter') -LeftPanelName 'NET_LEFT_PANEL' -RightPanelName 'NET_RIGHT_PANEL' -SearchName 'INP_NETTWEAKS_SEARCH' -ApplyButtonName 'BTN_APPLY_NET_TWEAKS' -RevertButtonName 'BTN_REVERT_NET_TWEAKS' -TabButtons @{ 'network_tweaks/tcpip' = 'TAB_NET_TCPIP'; 'network_tweaks/wifi' = 'TAB_NET_WIFI'; 'network_tweaks/adapter' = 'TAB_NET_ADAPTER' }

# Selector bar function
$setNetSelector = {
    param($btn)
    $transform = $ui.FindName("NetSelectorTransform")
    $selector = $ui.FindName("NetTabSelector")
    $container = $ui.FindName("NET_TAB_CONTAINER")
    if ($null -eq $transform -or $null -eq $selector -or $null -eq $container) { return }
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

# Add selector bar and animation to tab buttons
$ui.FindName("TAB_NET_TCPIP").Add_Checked({
    & $setNetSelector $this
    if (Get-Command Animate-SectionItems -ErrorAction SilentlyContinue) {
            $viewElem = $ui.FindName("VIEW_NETTWEAKS")
            if ($null -ne $viewElem) { Animate-SectionItems $viewElem }
    }
}.GetNewClosure())
$ui.FindName("TAB_NET_WIFI").Add_Checked({
    & $setNetSelector $this
    if (Get-Command Animate-SectionItems -ErrorAction SilentlyContinue) {
            $viewElem = $ui.FindName("VIEW_NETTWEAKS")
            if ($null -ne $viewElem) { Animate-SectionItems $viewElem }
    }
}.GetNewClosure())
$ui.FindName("TAB_NET_ADAPTER").Add_Checked({
    & $setNetSelector $this
    if (Get-Command Animate-SectionItems -ErrorAction SilentlyContinue) {
            $viewElem = $ui.FindName("VIEW_NETTWEAKS")
            if ($null -ne $viewElem) { Animate-SectionItems $viewElem }
    }
}.GetNewClosure())

# Sync selector when view becomes visible
$ui.FindName("VIEW_NETTWEAKS").Add_IsVisibleChanged({
    if ($this.IsVisible) {
            $selectedCategory = $global:SelectedTab_NetState
            $tabMap = @{
                'network_tweaks/tcpip' = 'TAB_NET_TCPIP'
                'network_tweaks/wifi' = 'TAB_NET_WIFI'
                'network_tweaks/adapter' = 'TAB_NET_ADAPTER'
            }
            $btn = $ui.FindName($tabMap[$selectedCategory])
            if ($null -ne $btn) { 
                # Small delay to ensure layout is complete
                Start-Sleep -Milliseconds 50
                & $setNetSelector $btn 
            }
    }
}.GetNewClosure())
