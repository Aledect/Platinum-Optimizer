. "$ModuleRoot\modules\tweak_catalog_runtime.ps1"

function New-CleanupTweakCard {
    param($Tweak, [string]$CardName = $null)

    $border = New-Object System.Windows.Controls.Border
    $border.Background      = [System.Windows.Media.BrushConverter]::new().ConvertFromString('#0F1318')
    $border.BorderBrush     = [System.Windows.Media.BrushConverter]::new().ConvertFromString('#1A1F2E')
    $border.BorderThickness = 1
    $border.CornerRadius    = 14
    $border.Margin          = '10,0,10,8'
    $border.Padding         = '20,18'
    $border.MinHeight       = 120
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
    $title.Text              = [string]$Tweak.shortTitle
    $title.Foreground        = [System.Windows.Media.BrushConverter]::new().ConvertFromString('#FFFFFF')
    $title.FontSize          = 14
    $title.FontWeight        = 'SemiBold'
    $title.Margin            = '0,0,8,0'
    $title.VerticalAlignment  = 'Center'
    $title.TextWrapping      = 'Wrap'
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
    $desc.Text         = [string]$Tweak.shortDescription
    $desc.Foreground   = [System.Windows.Media.BrushConverter]::new().ConvertFromString('#7B8498')
    $desc.FontSize     = 12
    $desc.TextWrapping = 'Wrap'
    $desc.LineHeight   = 17

    $stack.Children.Add($titleRow) | Out-Null
    $stack.Children.Add($desc)     | Out-Null

    $btnClean = New-Object System.Windows.Controls.Button
    $btnClean.Content   = "Clean"
    try { $btnClean.Style = $ui.FindResource('PrimaryBlueBtn') } catch {}
    $btnClean.Height            = 38
    $btnClean.Width             = 100
    $btnClean.FontSize          = 13
    $btnClean.FontWeight        = 'Bold'
    $btnClean.VerticalAlignment = 'Center'
    $btnClean.Cursor            = [System.Windows.Input.Cursors]::Hand
    [System.Windows.Controls.Grid]::SetColumn($btnClean, 1)

    $btnClean.Add_Click({
        $btnClean.Content   = "Cleaning..."
        $btnClean.IsEnabled = $false
        [System.Windows.Forms.Application]::DoEvents()

        if (Invoke-PlatinumTweakScript $Tweak.applyPath) {
            Set-TweakAppliedState $Tweak $true
            Save-TweakState
            if (Get-Command Show-CustomPopup -ErrorAction SilentlyContinue) {
                Show-CustomPopup "Cleanup operation '$($Tweak.shortTitle)' completed successfully." "Cleanup Completed" "Success"
            }
        }
        $btnClean.Content   = "Clean"
        $btnClean.IsEnabled = $true
    }.GetNewClosure())

    $grid.Children.Add($stack)    | Out-Null
    $grid.Children.Add($btnClean) | Out-Null
    $border.Child = $grid

    return [pscustomobject]@{ Card = $border; Button = $btnClean; Tweak = $Tweak }
}

function Render-CleanupSection {
    if ($null -eq $ui) { return }
    $left  = $ui.FindName('CLEANUP_LEFT_PANEL')
    $right = $ui.FindName('CLEANUP_RIGHT_PANEL')
    if ($null -eq $left -or $null -eq $right) { return }
    $left.Children.Clear(); $right.Children.Clear()

    $catalog = Get-PlatinumTweakCatalog
    $items   = @($catalog | Where-Object { $_.category -eq 'system_tweaks/cleanup' })

    $searchBox = $ui.FindName('INP_CLEANUP_SEARCH')
    if ($searchBox) {
        $q = $searchBox.Text.Trim()
        if ($q -and $q -ne 'Search cleanup tweaks...') {
            $ql = $q.ToLower()
            $items = @($items | Where-Object { $_.title.ToLower().Contains($ql) -or $_.shortDescription.ToLower().Contains($ql) })
        }
    }

    $cards = @()
    $index = 0
    foreach ($tw in $items) {
        $card = New-CleanupTweakCard $tw "CARD_CLEANUP_$index"
        $cards += $card
        $index++
    }

    $half = [math]::Ceiling($cards.Count / 2)
    for ($i = 0; $i -lt $cards.Count; $i++) {
        if ($i -lt $half) { $left.Children.Add($cards[$i].Card)  | Out-Null }
        else               { $right.Children.Add($cards[$i].Card) | Out-Null }
    }
}

if ($null -ne $ui) {
    # Register with global catalog renderers so state updates sync
    $global:PlatinumCatalogRenderers += { Render-CleanupSection }.GetNewClosure()

    # Search Box event handlers
    $cleanupSearch = $ui.FindName('INP_CLEANUP_SEARCH')
    if ($cleanupSearch) {
        $ph = [string]$cleanupSearch.Text
        $cleanupSearch.Add_GotKeyboardFocus({
            if ($this.Text -eq $ph) { $this.Text = ''; $this.Foreground = '#FFF' }
        }.GetNewClosure())
        $cleanupSearch.Add_LostKeyboardFocus({
            if ([string]::IsNullOrWhiteSpace($this.Text)) { $this.Text = $ph; $this.Foreground = '#949BAA' }
        }.GetNewClosure())
        $cleanupSearch.Add_TextChanged({
            Render-CleanupSection
        }.GetNewClosure())
    }

    # Clean All button
    $cleanAllBtn = $ui.FindName('BTN_APPLY_CLEANUP_TWEAKS')
    if ($cleanAllBtn) {
        $cleanAllBtn.Content   = "Clean All"
        $cleanAllBtn.IsEnabled = $true
        $cleanAllBtn.Opacity   = 1.0
        $cleanAllBtn.Add_Click({
            $cleanAllBtn.Content   = "Cleaning All..."
            $cleanAllBtn.IsEnabled = $false
            [System.Windows.Forms.Application]::DoEvents()

            $catalog = Get-PlatinumTweakCatalog
            $items   = @($catalog | Where-Object { $_.category -eq 'system_tweaks/cleanup' })
            $cleanedCount = 0

            foreach ($tw in $items) {
                if (Invoke-PlatinumTweakScript $tw.applyPath) {
                    Set-TweakAppliedState $tw $true
                    $cleanedCount++
                }
            }

            Save-TweakState
            $cleanAllBtn.Content   = "Clean All"
            $cleanAllBtn.IsEnabled = $true

            if ($cleanedCount -gt 0) {
                Show-CustomPopup "All cleanup tasks ($cleanedCount) executed successfully." "Cleanup Completed" "Success"
            }
        }.GetNewClosure())
    }

    # Hide revert button since individual Clean buttons perform cleanup actions
    $revertBtn = $ui.FindName('BTN_REVERT_CLEANUP_TWEAKS')
    if ($revertBtn) {
        $revertBtn.Visibility = 'Collapsed'
    }

    Render-CleanupSection
}
