. "$ModuleRoot\modules\tweak_catalog_runtime.ps1"
Initialize-PlatinumCatalogSection -Name 'DiskState' -Categories @('disk_tweaks/ssd', 'disk_tweaks/storage', 'disk_tweaks/filesystem') -LeftPanelName 'DISK_LEFT_PANEL' -RightPanelName 'DISK_RIGHT_PANEL' -SearchName 'INP_DISKTWEAKS_SEARCH' -ApplyButtonName 'BTN_APPLY_DISK_TWEAKS' -RevertButtonName 'BTN_REVERT_DISK_TWEAKS' -TabButtons @{ 'disk_tweaks/ssd' = 'TAB_DISK_SSD'; 'disk_tweaks/storage' = 'TAB_DISK_STORAGE'; 'disk_tweaks/filesystem' = 'TAB_DISK_FILESYSTEM' }

# Selector bar function
$setDiskSelector = {
    param($btn)
    $transform = $ui.FindName("DiskSelectorTransform")
    $selector = $ui.FindName("DiskTabSelector")
    $container = $ui.FindName("DISK_TAB_CONTAINER")
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
$ui.FindName("TAB_DISK_SSD").Add_Checked({
    & $setDiskSelector $this
    if (Get-Command Animate-SectionItems -ErrorAction SilentlyContinue) {
            $viewElem = $ui.FindName("VIEW_DISKTWEAKS")
            if ($null -ne $viewElem) { Animate-SectionItems $viewElem }
    }
}.GetNewClosure())
$ui.FindName("TAB_DISK_STORAGE").Add_Checked({
    & $setDiskSelector $this
    if (Get-Command Animate-SectionItems -ErrorAction SilentlyContinue) {
            $viewElem = $ui.FindName("VIEW_DISKTWEAKS")
            if ($null -ne $viewElem) { Animate-SectionItems $viewElem }
    }
}.GetNewClosure())
$ui.FindName("TAB_DISK_FILESYSTEM").Add_Checked({
    & $setDiskSelector $this
    if (Get-Command Animate-SectionItems -ErrorAction SilentlyContinue) {
            $viewElem = $ui.FindName("VIEW_DISKTWEAKS")
            if ($null -ne $viewElem) { Animate-SectionItems $viewElem }
    }
}.GetNewClosure())

# Sync selector when view becomes visible
$ui.FindName("VIEW_DISKTWEAKS").Add_IsVisibleChanged({
    if ($this.IsVisible) {
            $selectedCategory = $global:SelectedTab_DiskState
            $tabMap = @{
                'disk_tweaks/ssd' = 'TAB_DISK_SSD'
                'disk_tweaks/storage' = 'TAB_DISK_STORAGE'
                'disk_tweaks/filesystem' = 'TAB_DISK_FILESYSTEM'
            }
            $btn = $ui.FindName($tabMap[$selectedCategory])
            if ($null -ne $btn) { 
                # Small delay to ensure layout is complete
                Start-Sleep -Milliseconds 50
                & $setDiskSelector $btn 
            }
    }
}.GetNewClosure())
