. "$ModuleRoot\modules\tweak_catalog_runtime.ps1"

function Load-CpuTweakCategory {
    param([string]$Category, [string]$Title)

    $titleEl = $ui.FindName('TXT_CPU_SUBCAT_TITLE')
    if ($titleEl) { $titleEl.Text = $Title.ToUpper() }

    $left  = $ui.FindName('CPU_LEFT_PANEL')
    $right = $ui.FindName('CPU_RIGHT_PANEL')
    if ($left)  { $left.Children.Clear() }
    if ($right) { $right.Children.Clear() }

    $catalog = Get-PlatinumTweakCatalog
    $items   = @($catalog | Where-Object { $_.category -eq $Category })

    $applyBtn  = $ui.FindName('BTN_APPLY_CPU_TWEAKS')
    $revertBtn = $ui.FindName('BTN_REVERT_CPU_TWEAKS')
    $global:CurrentCpuCards = @()

    $global:UpdateCpuButtons = {
        $ac = @($global:CurrentCpuCards | Where-Object { $_.Toggle.IsChecked  -and -not $_.Applied }).Count
        $rc = @($global:CurrentCpuCards | Where-Object { -not $_.Toggle.IsChecked -and $_.Applied }).Count
        if ($applyBtn)  { $applyBtn.Content  = "Apply Tweaks ($ac)";  Set-TweakButtonState 'BTN_APPLY_CPU_TWEAKS'  $ac }
        if ($revertBtn) { $revertBtn.Content = "Revert Tweaks ($rc)"; Set-TweakButtonState 'BTN_REVERT_CPU_TWEAKS' $rc }
    }.GetNewClosure()

    if ($items.Count -eq 0) {
        [System.Windows.Controls.Grid]::SetColumnSpan($left, 3)
        $tb = New-Object System.Windows.Controls.TextBlock
        $tb.Text = "Coming soon..."
        $tb.Foreground = [System.Windows.Media.BrushConverter]::new().ConvertFromString('#7B8498')
        $tb.FontSize = 22
        $tb.FontWeight = 'SemiBold'
        $tb.HorizontalAlignment = 'Center'
        $tb.VerticalAlignment = 'Center'
        $tb.Margin = '0,80,0,80'
        $left.Children.Add($tb) | Out-Null
    } else {
        [System.Windows.Controls.Grid]::SetColumnSpan($left, 1)
        foreach ($tw in $items) {
            $card = New-PlatinumTweakCard $tw $global:UpdateCpuButtons
            $global:CurrentCpuCards += $card
        }

        $half = [math]::Ceiling($global:CurrentCpuCards.Count / 2)
        for ($i = 0; $i -lt $global:CurrentCpuCards.Count; $i++) {
            if ($i -lt $half) { $left.Children.Add($global:CurrentCpuCards[$i].Card)  | Out-Null }
            else               { $right.Children.Add($global:CurrentCpuCards[$i].Card) | Out-Null }
        }
    }
    & $global:UpdateCpuButtons

    $mainView = $ui.FindName('VIEW_CPUTWEAKS_MAIN')
    $listView = $ui.FindName('VIEW_CPU_TWEAKLIST')
    if ($mainView) {
        $mainView.BeginAnimation([System.Windows.UIElement]::OpacityProperty, $null)
        $mainView.Opacity = 0
        $mainView.Visibility = 'Collapsed'
    }
    if ($listView) {
        $listView.Visibility = 'Visible'
        $listView.BeginAnimation([System.Windows.UIElement]::OpacityProperty, $null)
        if ($listView.RenderTransform -is [System.Windows.Media.TranslateTransform]) {
            $listView.RenderTransform.BeginAnimation([System.Windows.Media.TranslateTransform]::YProperty, $null)
            $animY = New-Object System.Windows.Media.Animation.DoubleAnimation -Property @{ From = 15; To = 0; Duration = "0:0:0.300"; EasingFunction = (New-Object System.Windows.Media.Animation.CubicEase -Property @{ EasingMode = 'EaseOut' }) }
            $listView.RenderTransform.BeginAnimation([System.Windows.Media.TranslateTransform]::YProperty, $animY)
        }
        $animOp = New-Object System.Windows.Media.Animation.DoubleAnimation -Property @{ From = 0; To = 1; Duration = "0:0:0.250" }
        $listView.BeginAnimation([System.Windows.UIElement]::OpacityProperty, $animOp)
        if (Get-Command Animate-SectionItems -ErrorAction SilentlyContinue) {
            Animate-SectionItems -viewElem $listView
        }
    }
}

# Categoria buttons (Border -> MouseLeftButtonDown)
$btnCpuGeneral = $ui.FindName('BTN_CAT_CPU_GENERAL')
$btnCpuAmd     = $ui.FindName('BTN_CAT_CPU_AMD')
$btnCpuIntel   = $ui.FindName('BTN_CAT_CPU_INTEL')

if ($btnCpuGeneral) { $btnCpuGeneral.Add_MouseLeftButtonDown({ Load-CpuTweakCategory 'cpu_tweaks/general' 'General CPU Tweaks' }) }
if ($btnCpuAmd)     { $btnCpuAmd.Add_MouseLeftButtonDown({     Load-CpuTweakCategory 'cpu_tweaks/amd'     'AMD CPU Tweaks' }) }
if ($btnCpuIntel)   { $btnCpuIntel.Add_MouseLeftButtonDown({   Load-CpuTweakCategory 'cpu_tweaks/intel'   'Intel CPU Tweaks' }) }

# Back button (Button -> Click)
$btnCpuBack = $ui.FindName('BTN_CPU_BACK')
if ($btnCpuBack) {
    $btnCpuBack.Add_Click({
        $mainView = $ui.FindName('VIEW_CPUTWEAKS_MAIN')
        $listView = $ui.FindName('VIEW_CPU_TWEAKLIST')
        if ($listView) {
            $listView.BeginAnimation([System.Windows.UIElement]::OpacityProperty, $null)
            $listView.Opacity = 0
            $listView.Visibility = 'Collapsed'
        }
        if ($mainView) {
            $mainView.Visibility = 'Visible'
            $mainView.BeginAnimation([System.Windows.UIElement]::OpacityProperty, $null)
            if ($mainView.RenderTransform -is [System.Windows.Media.TranslateTransform]) {
                $mainView.RenderTransform.BeginAnimation([System.Windows.Media.TranslateTransform]::YProperty, $null)
                $animY = New-Object System.Windows.Media.Animation.DoubleAnimation -Property @{ From = -15; To = 0; Duration = "0:0:0.300"; EasingFunction = (New-Object System.Windows.Media.Animation.CubicEase -Property @{ EasingMode = 'EaseOut' }) }
                $mainView.RenderTransform.BeginAnimation([System.Windows.Media.TranslateTransform]::YProperty, $animY)
            }
            $animOp = New-Object System.Windows.Media.Animation.DoubleAnimation -Property @{ From = 0; To = 1; Duration = "0:0:0.250" }
            $mainView.BeginAnimation([System.Windows.UIElement]::OpacityProperty, $animOp)
            if (Get-Command Animate-SectionItems -ErrorAction SilentlyContinue) {
                Animate-SectionItems -viewElem $mainView
            }
        }
    })
}

# Ricerca
$cpuSearchBox = $ui.FindName('INP_CPUTWEAKS_SEARCH')
if ($cpuSearchBox) {
    $cpuPh = [string]$cpuSearchBox.Text
    $cpuSearchBox.Add_GotKeyboardFocus({
        if ($this.Text -eq $cpuPh) { $this.Text = ''; $this.Foreground = '#FFF' }
    }.GetNewClosure())
    $cpuSearchBox.Add_LostKeyboardFocus({
        if ([string]::IsNullOrWhiteSpace($this.Text)) { $this.Text = $cpuPh; $this.Foreground = '#949BAA' }
    }.GetNewClosure())
    $cpuSearchBox.Add_TextChanged({
        $txt = $this.Text.Trim()
        if ($txt -eq $cpuPh -or [string]::IsNullOrWhiteSpace($txt)) { return }
        $left  = $ui.FindName('CPU_LEFT_PANEL')
        $right = $ui.FindName('CPU_RIGHT_PANEL')
        if ($left)  { $left.Children.Clear() }
        if ($right) { $right.Children.Clear() }
        $q = $txt.ToLower()
        $found = @(Get-PlatinumTweakCatalog | Where-Object {
            $_.category -like 'cpu_tweaks/*' -and
            ($_.title.ToLower().Contains($q) -or $_.shortDescription.ToLower().Contains($q))
        })
        $global:CurrentCpuCards = @()
        foreach ($tw in $found) {
            $card = New-PlatinumTweakCard $tw $global:UpdateCpuButtons
            $global:CurrentCpuCards += $card
        }
        $half = [math]::Ceiling($global:CurrentCpuCards.Count / 2)
        for ($i = 0; $i -lt $global:CurrentCpuCards.Count; $i++) {
            if ($i -lt $half) { $left.Children.Add($global:CurrentCpuCards[$i].Card)  | Out-Null }
            else               { $right.Children.Add($global:CurrentCpuCards[$i].Card) | Out-Null }
        }
        if ($global:UpdateCpuButtons) { & $global:UpdateCpuButtons }
        $mainView = $ui.FindName('VIEW_CPUTWEAKS_MAIN')
        $listView = $ui.FindName('VIEW_CPU_TWEAKLIST')
        if ($mainView) { $mainView.Visibility = 'Collapsed' }
        if ($listView) { $listView.Visibility = 'Visible'; $listView.Opacity = 1 }
    }.GetNewClosure())
}

# Apply / Revert (Button -> Click)
$cpuApply = $ui.FindName('BTN_APPLY_CPU_TWEAKS')
if ($cpuApply) {
    $cpuApply.Add_Click({
        if ($null -eq $global:CurrentCpuCards) { return }
        $toApply = @($global:CurrentCpuCards | Where-Object { $_.Toggle.IsChecked -and -not $_.Applied })
        if ($toApply.Count -eq 0) { return }
        $appliedCount = 0
        foreach ($item in $toApply) {
            if (Invoke-PlatinumTweakScript $item.Tweak.applyPath) {
                $item.Applied = $true; Set-TweakAppliedState $item.Tweak $true
                $k = "$($item.Tweak.category)|$($item.Tweak.index)"
                if ($null -ne $global:PlatinumPendingToggleState) { $global:PlatinumPendingToggleState.Remove($k) }
                $appliedCount++
            }
        }
        if ($global:UpdateCpuButtons) { & $global:UpdateCpuButtons }
        Save-TweakState
        if ($appliedCount -gt 0) {
            Show-CustomPopup "Selected CPU tweaks ($appliedCount) applied successfully." "Tweaks Applied" "Success"
        }
    })
}
$cpuRevert = $ui.FindName('BTN_REVERT_CPU_TWEAKS')
if ($cpuRevert) {
    $cpuRevert.Add_Click({
        if ($null -eq $global:CurrentCpuCards) { return }
        $toRevert = @($global:CurrentCpuCards | Where-Object { -not $_.Toggle.IsChecked -and $_.Applied })
        if ($toRevert.Count -eq 0) { return }
        $revertedCount = 0
        foreach ($item in $toRevert) {
            if (Invoke-PlatinumTweakScript $item.Tweak.revertPath) {
                $item.Applied = $false; Set-TweakAppliedState $item.Tweak $false
                $k = "$($item.Tweak.category)|$($item.Tweak.index)"
                if ($null -ne $global:PlatinumPendingToggleState) { $global:PlatinumPendingToggleState.Remove($k) }
                $revertedCount++
            }
        }
        if ($global:UpdateCpuButtons) { & $global:UpdateCpuButtons }
        Save-TweakState
        if ($revertedCount -gt 0) {
            Show-CustomPopup "Selected CPU tweaks ($revertedCount) reverted successfully." "Tweaks Reverted" "Success"
        }
    })
}
