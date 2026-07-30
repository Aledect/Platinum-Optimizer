. "$ModuleRoot\modules\tweak_catalog_runtime.ps1"

function Load-GpuTweakCategory {
    param([string]$Category, [string]$Title)

    $titleEl = $ui.FindName('TXT_GPU_SUBCAT_TITLE')
    if ($titleEl) { $titleEl.Text = $Title.ToUpper() }

    $left  = $ui.FindName('GPU_LEFT_PANEL')
    $right = $ui.FindName('GPU_RIGHT_PANEL')
    if ($left)  { $left.Children.Clear() }
    if ($right) { $right.Children.Clear() }

    $catalog = Get-PlatinumTweakCatalog
    $items   = @($catalog | Where-Object { $_.category -eq $Category })

    $applyBtn  = $ui.FindName('BTN_APPLY_GPU_TWEAKS')
    $revertBtn = $ui.FindName('BTN_REVERT_GPU_TWEAKS')
    $global:CurrentGpuCards = @()

    $global:UpdateGpuButtons = {
        $ac = @($global:CurrentGpuCards | Where-Object { $_.Toggle.IsChecked  -and -not $_.Applied }).Count
        $rc = @($global:CurrentGpuCards | Where-Object { -not $_.Toggle.IsChecked -and $_.Applied }).Count
        if ($applyBtn)  { $applyBtn.Content  = "Apply Tweaks ($ac)";  Set-TweakButtonState 'BTN_APPLY_GPU_TWEAKS'  $ac }
        if ($revertBtn) { $revertBtn.Content = "Revert Tweaks ($rc)"; Set-TweakButtonState 'BTN_REVERT_GPU_TWEAKS' $rc }
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
            $card = New-PlatinumTweakCard $tw $global:UpdateGpuButtons
            $global:CurrentGpuCards += $card
        }

        $half = [math]::Ceiling($global:CurrentGpuCards.Count / 2)
        for ($i = 0; $i -lt $global:CurrentGpuCards.Count; $i++) {
            if ($i -lt $half) { $left.Children.Add($global:CurrentGpuCards[$i].Card)  | Out-Null }
            else               { $right.Children.Add($global:CurrentGpuCards[$i].Card) | Out-Null }
        }
    }
    & $global:UpdateGpuButtons

    $mainView = $ui.FindName('VIEW_GPUTWEAKS_MAIN')
    $listView = $ui.FindName('VIEW_GPU_TWEAKLIST')
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
$btnGpuGeneral = $ui.FindName('BTN_CAT_GPU_GENERAL')
$btnGpuNvidia  = $ui.FindName('BTN_CAT_GPU_NVIDIA')
$btnGpuAmd     = $ui.FindName('BTN_CAT_GPU_AMD')
$btnGpuIntel   = $ui.FindName('BTN_CAT_GPU_INTEL')

if ($btnGpuGeneral) { $btnGpuGeneral.Add_MouseLeftButtonDown({ Load-GpuTweakCategory 'gpu_tweaks/general' 'General GPU Tweaks' }) }
if ($btnGpuNvidia)  { $btnGpuNvidia.Add_MouseLeftButtonDown({  Load-GpuTweakCategory 'gpu_tweaks/nvidia'  'NVIDIA GPU Tweaks' }) }
if ($btnGpuAmd)     { $btnGpuAmd.Add_MouseLeftButtonDown({     Load-GpuTweakCategory 'gpu_tweaks/amd'     'AMD GPU Tweaks' }) }
if ($btnGpuIntel)   { $btnGpuIntel.Add_MouseLeftButtonDown({   Load-GpuTweakCategory 'gpu_tweaks/intel'   'Intel GPU Tweaks' }) }

# Back button (Button -> Click)
$btnGpuBack = $ui.FindName('BTN_GPU_BACK')
if ($btnGpuBack) {
    $btnGpuBack.Add_Click({
        $mainView = $ui.FindName('VIEW_GPUTWEAKS_MAIN')
        $listView = $ui.FindName('VIEW_GPU_TWEAKLIST')
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
$gpuSearchBox = $ui.FindName('INP_GPUTWEAKS_SEARCH')
if ($gpuSearchBox) {
    $gpuPh = [string]$gpuSearchBox.Text
    $gpuSearchBox.Add_GotKeyboardFocus({
        if ($this.Text -eq $gpuPh) { $this.Text = ''; $this.Foreground = '#FFF' }
    }.GetNewClosure())
    $gpuSearchBox.Add_LostKeyboardFocus({
        if ([string]::IsNullOrWhiteSpace($this.Text)) { $this.Text = $gpuPh; $this.Foreground = '#949BAA' }
    }.GetNewClosure())
    $gpuSearchBox.Add_TextChanged({
        $txt = $this.Text.Trim()
        if ($txt -eq $gpuPh -or [string]::IsNullOrWhiteSpace($txt)) { return }
        $left  = $ui.FindName('GPU_LEFT_PANEL')
        $right = $ui.FindName('GPU_RIGHT_PANEL')
        if ($left)  { $left.Children.Clear() }
        if ($right) { $right.Children.Clear() }
        $q = $txt.ToLower()
        $found = @(Get-PlatinumTweakCatalog | Where-Object {
            $_.category -like 'gpu_tweaks/*' -and
            ($_.title.ToLower().Contains($q) -or $_.shortDescription.ToLower().Contains($q))
        })
        $global:CurrentGpuCards = @()
        foreach ($tw in $found) {
            $card = New-PlatinumTweakCard $tw $global:UpdateGpuButtons
            $global:CurrentGpuCards += $card
        }
        $half = [math]::Ceiling($global:CurrentGpuCards.Count / 2)
        for ($i = 0; $i -lt $global:CurrentGpuCards.Count; $i++) {
            if ($i -lt $half) { $left.Children.Add($global:CurrentGpuCards[$i].Card)  | Out-Null }
            else               { $right.Children.Add($global:CurrentGpuCards[$i].Card) | Out-Null }
        }
        if ($global:UpdateGpuButtons) { & $global:UpdateGpuButtons }
        $mainView = $ui.FindName('VIEW_GPUTWEAKS_MAIN')
        $listView = $ui.FindName('VIEW_GPU_TWEAKLIST')
        if ($mainView) { $mainView.Visibility = 'Collapsed' }
        if ($listView) { $listView.Visibility = 'Visible'; $listView.Opacity = 1 }
    }.GetNewClosure())
}

# Apply / Revert (Button -> Click)
$gpuApply = $ui.FindName('BTN_APPLY_GPU_TWEAKS')
if ($gpuApply) {
    $gpuApply.Add_Click({
        if ($null -eq $global:CurrentGpuCards) { return }
        $toApply = @($global:CurrentGpuCards | Where-Object { $_.Toggle.IsChecked -and -not $_.Applied })
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
        if ($global:UpdateGpuButtons) { & $global:UpdateGpuButtons }
        Save-TweakState
        if ($appliedCount -gt 0) {
            Show-CustomPopup "Selected GPU tweaks ($appliedCount) applied successfully." "Tweaks Applied" "Success"
        }
    })
}
$gpuRevert = $ui.FindName('BTN_REVERT_GPU_TWEAKS')
if ($gpuRevert) {
    $gpuRevert.Add_Click({
        if ($null -eq $global:CurrentGpuCards) { return }
        $toRevert = @($global:CurrentGpuCards | Where-Object { -not $_.Toggle.IsChecked -and $_.Applied })
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
        if ($global:UpdateGpuButtons) { & $global:UpdateGpuButtons }
        Save-TweakState
        if ($revertedCount -gt 0) {
            Show-CustomPopup "Selected GPU tweaks ($revertedCount) reverted successfully." "Tweaks Reverted" "Success"
        }
    })
}
