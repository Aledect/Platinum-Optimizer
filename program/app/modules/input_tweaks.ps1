. "$ModuleRoot\modules\tweak_catalog_runtime.ps1"
Initialize-PlatinumCatalogSection -Name 'InputState' -Categories @('input_tweaks/mouse', 'input_tweaks/keyboard', 'input_tweaks/usb', 'input_tweaks/touch') -LeftPanelName 'INPUT_LEFT_PANEL' -RightPanelName 'INPUT_RIGHT_PANEL' -SearchName 'INP_INPUTTWEAKS_SEARCH' -ApplyButtonName 'BTN_APPLY_INPUT_TWEAKS' -RevertButtonName 'BTN_REVERT_INPUT_TWEAKS' -TabButtons @{ 'input_tweaks/mouse' = 'TAB_INPUT_MOUSE'; 'input_tweaks/keyboard' = 'TAB_INPUT_KEYBOARD'; 'input_tweaks/usb' = 'TAB_INPUT_USB'; 'input_tweaks/touch' = 'TAB_INPUT_TOUCH' }

# Selector bar function
$setInputSelector = {
    param($btn)
    $transform = $ui.FindName("InputSelectorTransform")
    $selector = $ui.FindName("InputTabSelector")
    $container = $ui.FindName("INPUT_TAB_CONTAINER")
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
$tabMouse = $ui.FindName("TAB_INPUT_MOUSE")
if ($tabMouse) {
    $tabMouse.Add_Checked({
        & $setInputSelector $this
        if (Get-Command Animate-SectionItems -ErrorAction SilentlyContinue) {
                $viewElem = $ui.FindName("VIEW_INPUTTWEAKS")
                if ($null -ne $viewElem) { Animate-SectionItems $viewElem }
        }
    }.GetNewClosure())
}
$tabKeyboard = $ui.FindName("TAB_INPUT_KEYBOARD")
if ($tabKeyboard) {
    $tabKeyboard.Add_Checked({
        & $setInputSelector $this
        if (Get-Command Animate-SectionItems -ErrorAction SilentlyContinue) {
                $viewElem = $ui.FindName("VIEW_INPUTTWEAKS")
                if ($null -ne $viewElem) { Animate-SectionItems $viewElem }
        }
    }.GetNewClosure())
}
$tabUsb = $ui.FindName("TAB_INPUT_USB")
if ($tabUsb) {
    $tabUsb.Add_Checked({
        & $setInputSelector $this
        if (Get-Command Animate-SectionItems -ErrorAction SilentlyContinue) {
                $viewElem = $ui.FindName("VIEW_INPUTTWEAKS")
                if ($null -ne $viewElem) { Animate-SectionItems $viewElem }
        }
    }.GetNewClosure())
}
$tabTouch = $ui.FindName("TAB_INPUT_TOUCH")
if ($tabTouch) {
    $tabTouch.Add_Checked({
        & $setInputSelector $this
        if (Get-Command Animate-SectionItems -ErrorAction SilentlyContinue) {
                $viewElem = $ui.FindName("VIEW_INPUTTWEAKS")
                if ($null -ne $viewElem) { Animate-SectionItems $viewElem }
        }
    }.GetNewClosure())
}

# Sync selector when view becomes visible
$viewInput = $ui.FindName("VIEW_INPUTTWEAKS")
if ($viewInput) {
    $viewInput.Add_IsVisibleChanged({
        if ($this.IsVisible) {
                $selectedCategory = $global:SelectedTab_InputState
                $tabMap = @{
                    'input_tweaks/mouse' = 'TAB_INPUT_MOUSE'
                    'input_tweaks/keyboard' = 'TAB_INPUT_KEYBOARD'
                    'input_tweaks/usb' = 'TAB_INPUT_USB'
                    'input_tweaks/touch' = 'TAB_INPUT_TOUCH'
                }
                $btn = $ui.FindName($tabMap[$selectedCategory])
                if ($null -ne $btn) { 
                    # Small delay to ensure layout is complete
                    Start-Sleep -Milliseconds 50
                    & $setInputSelector $btn 
                }
        }
    }.GetNewClosure())
}
