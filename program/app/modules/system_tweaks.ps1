. "$ModuleRoot\modules\tweak_catalog_runtime.ps1"
Initialize-PlatinumCatalogSection -Name 'SysState' -Categories @('system_tweaks/kernel', 'system_tweaks/customization', 'system_tweaks/security', 'system_tweaks/power', 'system_tweaks/boot') -LeftPanelName 'SYS_LEFT_PANEL' -RightPanelName 'SYS_RIGHT_PANEL' -SearchName 'INP_SYSTWEAKS_SEARCH' -ApplyButtonName 'BTN_APPLY_TWEAKS' -RevertButtonName 'BTN_REVERT_TWEAKS' -TabButtons @{ 'system_tweaks/kernel' = 'TAB_SYSTWEAKS_KERNEL'; 'system_tweaks/customization' = 'TAB_SYSTWEAKS_CUSTOMIZATION'; 'system_tweaks/security' = 'TAB_SYSTWEAKS_SECURITY'; 'system_tweaks/power' = 'TAB_SYSTWEAKS_POWER'; 'system_tweaks/boot' = 'TAB_SYSTWEAKS_BOOT' }

# Selector bar function
$setSysTweaksSelector = {
    param($btn)
    $transform = $ui.FindName("SysTweaksSelectorTransform")
    $selector = $ui.FindName("SysTweaksTabSelector")
    $container = $ui.FindName("SYSTWEAKS_TAB_CONTAINER")
    if ($null -eq $transform -or $null -eq $selector -or $null -eq $container) { return }
    if ($btn.ActualWidth -eq 0) { return }
    $pos = $btn.TranslatePoint((New-Object System.Windows.Point(0,0)), $container)
    $targetX = $pos.X
    $targetW = $btn.ActualWidth
    $ease = New-Object System.Windows.Media.Animation.QuarticEase -Property @{ EasingMode = 'EaseOut' }
    $animX = New-Object System.Windows.Media.Animation.DoubleAnimation -Property @{ To = $targetX; Duration = "0:0:0.25"; EasingFunction = $ease }
    $animW = New-Object System.Windows.Media.Animation.DoubleAnimation -Property @{ To = $targetW; Duration = "0:0:0.25"; EasingFunction = $ease }
    $transform.BeginAnimation([System.Windows.Media.TranslateTransform]::XProperty, $animX)
    $selector.BeginAnimation([System.Windows.FrameworkElement]::WidthProperty, $animW)
}.GetNewClosure()

# Add selector bar and animation to tab buttons
$ui.FindName("TAB_SYSTWEAKS_KERNEL").Add_Checked({
    & $setSysTweaksSelector $this
    if (Get-Command Animate-SectionItems -ErrorAction SilentlyContinue) {
            $viewElem = $ui.FindName("VIEW_SYSTWEAKS")
            if ($null -ne $viewElem) { Animate-SectionItems $viewElem }
    }
}.GetNewClosure())
$ui.FindName("TAB_SYSTWEAKS_CUSTOMIZATION").Add_Checked({
    & $setSysTweaksSelector $this
    if (Get-Command Animate-SectionItems -ErrorAction SilentlyContinue) {
            $viewElem = $ui.FindName("VIEW_SYSTWEAKS")
            if ($null -ne $viewElem) { Animate-SectionItems $viewElem }
    }
}.GetNewClosure())
$ui.FindName("TAB_SYSTWEAKS_SECURITY").Add_Checked({
    & $setSysTweaksSelector $this
    if (Get-Command Animate-SectionItems -ErrorAction SilentlyContinue) {
            $viewElem = $ui.FindName("VIEW_SYSTWEAKS")
            if ($null -ne $viewElem) { Animate-SectionItems $viewElem }
    }
}.GetNewClosure())
$ui.FindName("TAB_SYSTWEAKS_POWER").Add_Checked({
    & $setSysTweaksSelector $this
    if (Get-Command Animate-SectionItems -ErrorAction SilentlyContinue) {
            $viewElem = $ui.FindName("VIEW_SYSTWEAKS")
            if ($null -ne $viewElem) { Animate-SectionItems $viewElem }
    }
}.GetNewClosure())
$ui.FindName("TAB_SYSTWEAKS_BOOT").Add_Checked({
    & $setSysTweaksSelector $this
    if (Get-Command Animate-SectionItems -ErrorAction SilentlyContinue) {
            $viewElem = $ui.FindName("VIEW_SYSTWEAKS")
            if ($null -ne $viewElem) { Animate-SectionItems $viewElem }
    }
}.GetNewClosure())

# Sync selector when view becomes visible
$ui.FindName("VIEW_SYSTWEAKS").Add_IsVisibleChanged({
    if ($this.IsVisible) {
            $selectedCategory = $global:SelectedTab_SysState
            $tabMap = @{
                'system_tweaks/kernel' = 'TAB_SYSTWEAKS_KERNEL'
                'system_tweaks/customization' = 'TAB_SYSTWEAKS_CUSTOMIZATION'
                'system_tweaks/security' = 'TAB_SYSTWEAKS_SECURITY'
                'system_tweaks/power' = 'TAB_SYSTWEAKS_POWER'
                'system_tweaks/boot' = 'TAB_SYSTWEAKS_BOOT'
            }
            $btn = $ui.FindName($tabMap[$selectedCategory])
            if ($null -ne $btn) { 
                # Small delay to ensure layout is complete
                Start-Sleep -Milliseconds 50
                & $setSysTweaksSelector $btn 
            }
    }
}.GetNewClosure())
