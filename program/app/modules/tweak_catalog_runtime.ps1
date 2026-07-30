# ============================================================
# tweak_catalog_runtime.ps1
# Runtime engine per le sezioni tweak del Platinum+ Optimizer
# ============================================================

if ($null -eq $global:PlatinumAppliedState) { $global:PlatinumAppliedState = @{} }
if ($null -eq $global:PlatinumCatalogRenderers) { $global:PlatinumCatalogRenderers = @() }
if ($null -eq $global:PlatinumPendingToggleState) { $global:PlatinumPendingToggleState = @{} }

function Update-AllPlatinumCatalogSections {
    foreach ($r in $global:PlatinumCatalogRenderers) {
        if ($null -ne $r) {
            try { & $r } catch {}
        }
    }
}

# ----------------------------------------------------------
# Catalog loader
# ----------------------------------------------------------
function Get-PlatinumTweakCatalog {
    if ($global:PlatinumTweakCatalog) { return $global:PlatinumTweakCatalog }
    $catalogPath = Join-Path $ModuleRoot 'config\tweaks_catalog.json'
    if (-not (Test-Path $catalogPath)) {
        $global:PlatinumTweakCatalog = @()
        return $global:PlatinumTweakCatalog
    }
    $global:PlatinumTweakCatalog = Get-Content $catalogPath -Raw -Encoding UTF8 | ConvertFrom-Json
    return $global:PlatinumTweakCatalog
}

# ----------------------------------------------------------
# Flat state helpers  (key = "category|index")
# ----------------------------------------------------------
function Get-TweakAppliedState {
    param($Tweak)
    $key = "$($Tweak.category)|$($Tweak.index)"
    return $global:PlatinumAppliedState[$key] -eq $true
}

function Set-TweakAppliedState {
    param($Tweak, $Applied)
    $key = "$($Tweak.category)|$($Tweak.index)"
    $global:PlatinumAppliedState[$key] = $Applied
}

# ----------------------------------------------------------
# Script invoker
# ----------------------------------------------------------
function Invoke-PlatinumTweakScript {
    param([Parameter(Mandatory=$true)]$RelativePath)
    $full = Join-Path (Join-Path $ModuleRoot 'tweak') $RelativePath
    if (-not (Test-Path $full)) {
        Show-CustomPopup "Script not found: $RelativePath" "Missing Script" "Warning"
        return $false
    }
    if (Get-Command Invoke-LoggedBat -ErrorAction SilentlyContinue) {
        Invoke-LoggedBat -BatPath $full
    } else {
        Start-Process $full -Wait -WindowStyle Hidden
    }
    return $true
}

# ----------------------------------------------------------
# Tweak button state helper
# ----------------------------------------------------------
function Set-TweakButtonState {
    param([string]$BtnName, [int]$Count)
    $btn = $ui.FindName($BtnName)
    if ($null -eq $btn) { return }
    if ($Count -gt 0) {
        $btn.Opacity = 1; $btn.IsEnabled = $true
    } else {
        $btn.Opacity = 0.35; $btn.IsEnabled = $false
    }
}

# ----------------------------------------------------------
# Card builder
# ----------------------------------------------------------
function New-PlatinumTweakCard {
    param($Tweak, [scriptblock]$OnChanged, [string]$CardName = $null)

    $border = New-Object System.Windows.Controls.Border
    $border.Background     = [System.Windows.Media.BrushConverter]::new().ConvertFromString('#0F1318')
    $border.BorderBrush    = [System.Windows.Media.BrushConverter]::new().ConvertFromString('#1A1F2E')
    $border.BorderThickness = 1
    $border.CornerRadius   = 14
    $border.Margin         = '10,0,10,8'
    $border.Padding        = '20,18'
    $border.MinHeight      = 120
    $border.RenderTransform = New-Object System.Windows.Media.TranslateTransform
    if ($CardName) { $border.Name = $CardName }

    $grid = New-Object System.Windows.Controls.Grid
    $c1 = New-Object System.Windows.Controls.ColumnDefinition
    $c1.Width = [System.Windows.GridLength]::new(1, [System.Windows.GridUnitType]::Star)
    $c2 = New-Object System.Windows.Controls.ColumnDefinition
    $c2.Width = [System.Windows.GridLength]::Auto
    $grid.ColumnDefinitions.Add($c1) | Out-Null
    $grid.ColumnDefinitions.Add($c2) | Out-Null

    $stack = New-Object System.Windows.Controls.StackPanel
    $stack.Margin = '0,0,20,0'
    [System.Windows.Controls.Grid]::SetColumn($stack, 0)

    $titleRow = New-Object System.Windows.Controls.StackPanel
    $titleRow.Orientation = 'Horizontal'
    $titleRow.Margin = '0,0,0,4'

    $title = New-Object System.Windows.Controls.TextBlock
    $title.Text             = [string]$Tweak.shortTitle
    $title.Foreground       = [System.Windows.Media.BrushConverter]::new().ConvertFromString('#FFFFFF')
    $title.FontSize         = 14
    $title.FontWeight       = 'SemiBold'
    $title.Margin           = '0,0,8,0'
    $title.VerticalAlignment = 'Center'
    $title.TextWrapping     = 'Wrap'
    $titleRow.Children.Add($title) | Out-Null

    $info = New-Object System.Windows.Controls.Border
    $info.Width           = 18
    $info.Height          = 18
    $info.Background      = [System.Windows.Media.BrushConverter]::new().ConvertFromString('#14171E')
    $info.BorderBrush     = [System.Windows.Media.BrushConverter]::new().ConvertFromString('#1A1F2E')
    $info.BorderThickness = 1
    $info.CornerRadius    = 9
    $info.Cursor          = [System.Windows.Input.Cursors]::Hand
    $info.ToolTip         = [string]$Tweak.title
    $q = New-Object System.Windows.Controls.TextBlock
    $q.Text               = '?'
    $q.Foreground         = [System.Windows.Media.BrushConverter]::new().ConvertFromString('#7B8498')
    $q.FontSize           = 10
    $q.FontWeight         = 'Bold'
    $q.HorizontalAlignment = 'Center'
    $q.VerticalAlignment  = 'Center'
    $info.Child = $q
    $titleRow.Children.Add($info) | Out-Null

    $desc = New-Object System.Windows.Controls.TextBlock
    $desc.Text = [string]$Tweak.shortDescription
    $desc.Foreground   = [System.Windows.Media.BrushConverter]::new().ConvertFromString('#7B8498')
    $desc.FontSize     = 12
    $desc.TextWrapping = 'Wrap'
    $desc.LineHeight   = 17

    $stack.Children.Add($titleRow) | Out-Null
    $stack.Children.Add($desc)     | Out-Null

    $toggle = New-Object System.Windows.Controls.CheckBox
    try { $toggle.Style = $ui.FindResource('ToggleSwitchStyle') } catch {}
    $toggle.VerticalAlignment = 'Center'
    [System.Windows.Controls.Grid]::SetColumn($toggle, 1)

    $isApplied = Get-TweakAppliedState $Tweak
    $key = "$($Tweak.category)|$($Tweak.index)"

    if ($null -ne $global:PlatinumPendingToggleState -and $global:PlatinumPendingToggleState.ContainsKey($key)) {
        $toggle.IsChecked = [bool]$global:PlatinumPendingToggleState[$key]
    } else {
        $toggle.IsChecked = $isApplied
    }

    $cardObj = [pscustomobject]@{ Card = $border; Toggle = $toggle; Tweak = $Tweak; Applied = $isApplied; Updating = $false }

    $toggle.Add_Checked({
        if ($cardObj.Updating) { return }
        $cardObj.Updating = $true
        if ($null -ne $global:PlatinumPendingToggleState) {
            $global:PlatinumPendingToggleState[$key] = $true
        }
        if ($OnChanged) { & $OnChanged }
        $cardObj.Updating = $false
    }.GetNewClosure())

    $toggle.Add_Unchecked({
        if ($cardObj.Updating) { return }
        $cardObj.Updating = $true
        if ($null -ne $global:PlatinumPendingToggleState) {
            $global:PlatinumPendingToggleState[$key] = $false
        }
        if ($OnChanged) { & $OnChanged }
        $cardObj.Updating = $false
    }.GetNewClosure())

    $grid.Children.Add($stack)  | Out-Null
    $grid.Children.Add($toggle) | Out-Null
    $border.Child = $grid
    return $cardObj
}

# ----------------------------------------------------------
# Initialize a tweak catalog section (System/RAM/Disk/Net/Input)
# ----------------------------------------------------------
function Initialize-PlatinumCatalogSection {
    param(
        [string]$Name,
        [string[]]$Categories,
        [string]$LeftPanelName,
        [string]$RightPanelName,
        [string]$SearchName,
        [string]$ApplyButtonName,
        [string]$RevertButtonName,
        [hashtable]$TabButtons = $null,
        [string]$TitleName = $null
    )

    # Ensure UI is available before proceeding
    if ($null -eq $ui) {
        Write-Host "WARNING: UI not available when initializing $Name section. Skipping." -ForegroundColor Yellow
        return
    }

    $stateName = "PlatinumCatalog_$($Name)"
    Set-Variable -Scope Global -Name $stateName -Value (
        [pscustomobject]@{ Items = @(); Category = $Categories[0]; Search = '' }
    )

    $updateButtons = {
        if ($null -eq $ui) { return }
        $state = (Get-Variable -Scope Global -Name $stateName).Value
        $applyCount  = @($state.Items | Where-Object { $_.Toggle.IsChecked  -and -not $_.Applied }).Count
        $revertCount = @($state.Items | Where-Object { -not $_.Toggle.IsChecked -and $_.Applied }).Count
        $apply  = $ui.FindName($ApplyButtonName)
        $revert = $ui.FindName($RevertButtonName)
        if ($apply)  { $apply.Content  = "Apply Tweaks ($applyCount)";  Set-TweakButtonState $ApplyButtonName  $applyCount }
        if ($revert) { $revert.Content = "Revert Tweaks ($revertCount)"; Set-TweakButtonState $RevertButtonName $revertCount }
    }.GetNewClosure()

    $render = {
        if ($null -eq $ui) { return }
        $state = (Get-Variable -Scope Global -Name $stateName).Value
        $left  = $ui.FindName($LeftPanelName)
        $right = $ui.FindName($RightPanelName)
        if ($null -eq $left -or $null -eq $right) { return }
        $left.Children.Clear(); $right.Children.Clear()
        $state.Items = @()
        $catalog = Get-PlatinumTweakCatalog
        $wanted  = if ($TabButtons) { @($state.Category) } else { $Categories }
        $items   = @($catalog | Where-Object { $wanted -contains $_.category })
        if ($state.Search) {
            $q = $state.Search.ToLower()
            $items = @($items | Where-Object { $_.title.ToLower().Contains($q) -or $_.shortDescription.ToLower().Contains($q) })
        }
        if ($TitleName) {
            $titleEl = $ui.FindName($TitleName)
            if ($titleEl) { $titleEl.Text = (($state.Category -replace '_',' ' -replace '/',' / ').ToUpper()) }
        }
        $cardIndex = 0
        foreach ($tw in $items) {
            $cardName = "CARD_$($Name)_$cardIndex"
            $card = New-PlatinumTweakCard $tw $updateButtons $cardName
            $state.Items += $card
            $cardIndex++
        }
        $half = [math]::Ceiling($state.Items.Count / 2)
        for ($i = 0; $i -lt $state.Items.Count; $i++) {
            if ($i -lt $half) { $left.Children.Add($state.Items[$i].Card)  | Out-Null }
            else               { $right.Children.Add($state.Items[$i].Card) | Out-Null }
        }
        & $updateButtons
    }.GetNewClosure()

    $global:PlatinumCatalogRenderers += $render

    # Search box
    if ($null -ne $ui) {
        $search = $ui.FindName($SearchName)
        if ($search) {
            $placeholder = [string]$search.Text
            $search.Add_GotKeyboardFocus({
                if ($this.Text -eq $placeholder) { $this.Text = ''; $this.Foreground = '#FFF' }
            }.GetNewClosure())
            $search.Add_LostKeyboardFocus({
                if ([string]::IsNullOrWhiteSpace($this.Text)) { $this.Text = $placeholder; $this.Foreground = '#949BAA' }
            }.GetNewClosure())
            $search.Add_TextChanged({
                $state = (Get-Variable -Scope Global -Name $stateName).Value
                $txt = $this.Text.Trim()
                $state.Search = if ($txt -eq $placeholder) { '' } else { $txt }
                & $render
            }.GetNewClosure())
        }
    }

    # Tab buttons (RadioButton style, e.g. System Tweaks)
    if ($null -ne $ui -and $TabButtons) {
        # Global variable to track selected tab for this section
        $varName = "SelectedTab_$($Name)"
        Set-Variable -Scope Global -Name $varName -Value $Categories[0]
        
        foreach ($catKey in $TabButtons.Keys) {
            $btnName = $TabButtons[$catKey]
            $btn = $ui.FindName($btnName)
            if ($btn) {
                $btn.Add_Checked({
                    $state = (Get-Variable -Scope Global -Name $stateName).Value
                    $state.Category = $catKey
                    Set-Variable -Scope Global -Name $varName -Value $catKey
                    & $render
                }.GetNewClosure())
            }
        }
    }

    # Apply button
    if ($null -ne $ui) {
        $applyBtn = $ui.FindName($ApplyButtonName)
        if ($applyBtn) {
            $applyBtn.Add_Click({
                $state = (Get-Variable -Scope Global -Name $stateName).Value
                $toApply = @($state.Items | Where-Object { $_.Toggle.IsChecked -and -not $_.Applied })
                if ($toApply.Count -eq 0) { return }
                $appliedCount = 0
                foreach ($item in $toApply) {
                    if (Invoke-PlatinumTweakScript $item.Tweak.applyPath) {
                        $item.Applied = $true
                        Set-TweakAppliedState $item.Tweak $true
                        $k = "$($item.Tweak.category)|$($item.Tweak.index)"
                        if ($null -ne $global:PlatinumPendingToggleState) { $global:PlatinumPendingToggleState.Remove($k) }
                        $appliedCount++
                    }
                }
                & $updateButtons
                Save-TweakState
                if ($appliedCount -gt 0) {
                    Show-CustomPopup "Selected tweaks ($appliedCount) applied successfully." "Tweaks Applied" "Success"
                }
            }.GetNewClosure())
        }
    }

    # Revert button
    if ($null -ne $ui) {
        $revertBtn = $ui.FindName($RevertButtonName)
        if ($revertBtn) {
            $revertBtn.Add_Click({
                $state = (Get-Variable -Scope Global -Name $stateName).Value
                $toRevert = @($state.Items | Where-Object { -not $_.Toggle.IsChecked -and $_.Applied })
                if ($toRevert.Count -eq 0) { return }
                $revertedCount = 0
                foreach ($item in $toRevert) {
                    if (Invoke-PlatinumTweakScript $item.Tweak.revertPath) {
                        $item.Applied = $false
                        Set-TweakAppliedState $item.Tweak $false
                        $k = "$($item.Tweak.category)|$($item.Tweak.index)"
                        if ($null -ne $global:PlatinumPendingToggleState) { $global:PlatinumPendingToggleState.Remove($k) }
                        $revertedCount++
                    }
                }
                & $updateButtons
                Save-TweakState
                if ($revertedCount -gt 0) {
                    Show-CustomPopup "Selected tweaks ($revertedCount) reverted successfully." "Tweaks Reverted" "Success"
                }
            }.GetNewClosure())
        }
    }

    if ($null -ne $ui) {
        & $render
    }
}
