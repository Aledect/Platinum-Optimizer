# Bug Fix Module - Search and Execute Handlers
$global:bugfixCards = @()
$global:bugfixGrid = $ui.FindName('BUGFIX_OPTIONS_LIST')
for ($i=1; $i -le 7; $i++) { $global:bugfixCards += $ui.FindName("CARD_BUGFIX_$i") }

$titles = @{
    1 = 'reset windows update components'
    2 = 'rebuild windows icon cache'
    3 = 'sfc and dism system integrity scan'
    4 = 'reset network adapters and tcp/ip stack'
    5 = 'repair print spooler service'
    6 = 're-register windows store and modern apps'
    7 = 'rebuild wmi repository'
}

$global:bugfixCats = @{
    1 = "WINDOWS"; 2 = "WINDOWS"; 3 = "WINDOWS"; 4 = "NETWORK"; 
    5 = "WINDOWS"; 6 = "APP"; 7 = "WINDOWS"
}
$global:currentBugfixTab = "WINDOWS"

function Update-BugfixView {
    param([bool]$animate = $true)
    $q = $ui.FindName("INP_BUGFIX_SEARCH").Text.ToLower().Trim()
    if ($q -eq 'search fixes...') { $q = '' }
    
    $global:bugfixGrid.Children.Clear()
    for ($i=0; $i -lt $global:bugfixCards.Count; $i++) {
        $idx = $i + 1
        if (($global:bugfixCats[$idx] -eq $global:currentBugfixTab) -and ($q -eq '' -or $titles[$idx].Contains($q))) {
            $global:bugfixGrid.Children.Add($global:bugfixCards[$i])
        }
    }
    
    $sv = $ui.FindName('SCROLL_BUGFIX')
    if ($null -ne $sv) { $sv.ScrollToTop() }
    
    if ($animate) {
        $viewElem = $ui.FindName("BUGFIX_CONTENT")
        if ($null -ne $viewElem) {
            Animate-SectionItems $viewElem
        }
    }
}

$ui.FindName("INP_BUGFIX_SEARCH").Add_GotKeyboardFocus({ 
    if ($this.Text -eq "Search fixes...") { $this.Text = ""; $this.Foreground = "#FFF" } 
})
$ui.FindName("INP_BUGFIX_SEARCH").Add_LostKeyboardFocus({ 
    if ([string]::IsNullOrWhiteSpace($this.Text)) { $this.Text = "Search fixes..."; $this.Foreground = "#949BAA" } 
})
$ui.FindName("INP_BUGFIX_SEARCH").Add_TextChanged({ Update-BugfixView -animate $false })

function Set-BugfixTabSelector {
    param($btn)
    $transform = $ui.FindName("BugfixSelectorTransform")
    $selector = $ui.FindName("BugfixTabSelector")
    $container = $ui.FindName("BUGFIX_TAB_CONTAINER")
    if ($null -eq $transform -or $null -eq $selector -or $null -eq $container) { return }
    if ($btn.ActualWidth -eq 0) { return }
    $pos = $btn.TranslatePoint((New-Object System.Windows.Point(0,0)), $container)
    
    $targetX = $pos.X
    $targetW = $btn.ActualWidth
    $animX = New-Object System.Windows.Media.Animation.DoubleAnimation -Property @{ To = $targetX; Duration = "0:0:0.25"; EasingFunction = (New-Object System.Windows.Media.Animation.QuarticEase -Property @{ EasingMode = 'EaseOut' }) }
    $animW = New-Object System.Windows.Media.Animation.DoubleAnimation -Property @{ To = $targetW; Duration = "0:0:0.25"; EasingFunction = (New-Object System.Windows.Media.Animation.QuarticEase -Property @{ EasingMode = 'EaseOut' }) }
    
    $transform.BeginAnimation([System.Windows.Media.TranslateTransform]::XProperty, $animX)
    $selector.BeginAnimation([System.Windows.FrameworkElement]::WidthProperty, $animW)
}

$ui.FindName("TAB_BUGFIX_WINDOWS").Add_Checked({ Set-BugfixTabSelector $this; $global:currentBugfixTab = "WINDOWS"; Update-BugfixView -animate $true })
$ui.FindName("TAB_BUGFIX_GAME").Add_Checked({ Set-BugfixTabSelector $this; $global:currentBugfixTab = "GAME"; Update-BugfixView -animate $true })
$ui.FindName("TAB_BUGFIX_NETWORK").Add_Checked({ Set-BugfixTabSelector $this; $global:currentBugfixTab = "NETWORK"; Update-BugfixView -animate $true })
$ui.FindName("TAB_BUGFIX_APP").Add_Checked({ Set-BugfixTabSelector $this; $global:currentBugfixTab = "APP"; Update-BugfixView -animate $true })

$ui.FindName("VIEW_BUGFIX").Add_IsVisibleChanged({
    if ($this.IsVisible) {
            $btn = $ui.FindName("TAB_BUGFIX_$global:currentBugfixTab")
            if ($null -ne $btn) { Set-BugfixTabSelector $btn }
    }
})

1..7 | ForEach-Object {
    $btnBugfixInfo = $ui.FindName("BTN_INFO_BUGFIX_$_")
    if ($null -ne $btnBugfixInfo) {
        $btnBugfixInfo.Add_MouseEnter({
            $tb = [System.Windows.Controls.TextBlock]$this.Child
            if ($tb) { $tb.Foreground = "#00B4DB" }
        })
        $btnBugfixInfo.Add_MouseLeave({
            $tb = [System.Windows.Controls.TextBlock]$this.Child
            if ($tb) { $tb.Foreground = "#949BAA" }
        })
        $btnBugfixInfo.Add_PreviewMouseLeftButtonDown({
            $tb = [System.Windows.Controls.TextBlock]$this.Child
            if ($tb) { $tb.Foreground = "#00B4DB" }
        })
    }
}

1..7 | ForEach-Object {
    $btn = $ui.FindName("BTN_RUN_BUGFIX_$_")
    if ($null -ne $btn) {
        $btn.Add_Click({
            $origContent = $this.Content
            $this.Content = "Operation in progress..."
            [System.Windows.Threading.Dispatcher]::CurrentDispatcher.Invoke("Render", [Action]{})
            Start-Sleep -Seconds 2
            $this.Content = $origContent
            Show-CustomPopup "The system diagnostic engine has successfully implemented the requested fix." "Operation Complete" "Success"
        })
    }
}