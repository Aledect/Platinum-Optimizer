# Animation Engine
$script:ActiveNavButton = $null

function Invoke-SidebarWheelScroll {
    param(
        $Sender,
        [System.Windows.Input.MouseWheelEventArgs]$EventArgs
    )

    $scroll = $ui.FindName("NAV_SCROLL")
    if ($null -eq $scroll -or $scroll.ScrollableHeight -le 0) { return }

    $nextOffset = $scroll.VerticalOffset - ($EventArgs.Delta / 3.0)
    if ($nextOffset -lt 0) { $nextOffset = 0 }
    if ($nextOffset -gt $scroll.ScrollableHeight) { $nextOffset = $scroll.ScrollableHeight }

    $scroll.ScrollToVerticalOffset($nextOffset)
    $EventArgs.Handled = $true

    if ($script:ActiveNavButton) {
        Set-Selector $script:ActiveNavButton -SkipBringIntoView
    }
}

function Register-SidebarScrollHandlers {
    $scroll = $ui.FindName("NAV_SCROLL")
    $container = $ui.FindName("NAV_CONTAINER")
    if ($null -eq $scroll) { return }

    $wheelHandler = {
        param($sender, $e)
        if ($e.Handled) { return }
        Invoke-SidebarWheelScroll -Sender $sender -EventArgs $e
    }

    $scroll.Add_PreviewMouseWheel($wheelHandler)
    if ($container) { $container.Add_PreviewMouseWheel($wheelHandler) }

    $scroll.Add_ScrollChanged({
        if ($script:ActiveNavButton) {
            Set-Selector $script:ActiveNavButton -SkipBringIntoView
        }
    })
}

function Set-Selector {
    param(
        $btn,
        [switch]$SkipBringIntoView
    )
    $transform = $ui.FindName("SelectorTransform")
    if ($null -eq $transform) { return }

    $script:ActiveNavButton = $btn
    $selectorHost = $ui.FindName("NAV_CONTAINER")
    if ($null -eq $selectorHost) { return }

    if (-not $SkipBringIntoView) {
        try { if ($btn) { $btn.BringIntoView() } } catch {}
    }

    $pos = $btn.TranslatePoint((New-Object System.Windows.Point(0,0)), $selectorHost)
    $targetY = $pos.Y + ($btn.ActualHeight / 2) - 12
    # Smoother slide animation
    $anim = New-Object System.Windows.Media.Animation.DoubleAnimation -Property @{ To = $targetY; Duration = "0:0:0.250"; EasingFunction = (New-Object System.Windows.Media.Animation.CubicEase -Property @{ EasingMode = 'EaseOut' }) }
    $transform.BeginAnimation([System.Windows.Media.TranslateTransform]::YProperty, $anim)
}

function Update-NavSelection {
    param($activeBtn)
    $navButtons = @("NAV_HOME", "NAV_RESTORE", "NAV_BUGFIX", "NAV_DRIVER", "NAV_DEBLOAT", "NAV_SERVICE", "NAV_SYS_TWEAKS", "NAV_CLEANUP", "NAV_CPU", "NAV_GPU", "NAV_RAM", "NAV_DISK", "NAV_NET", "NAV_INPUT", "NAV_GAME", "NAV_ABOUT")
    foreach ($name in $navButtons) {
        $btn = $ui.FindName($name)
        if ($null -ne $btn) {
            if ($btn -eq $activeBtn) {
                $btn.Background = [System.Windows.Media.BrushConverter]::new().ConvertFromString("#0F1520")
                $btn.Foreground = [System.Windows.Media.BrushConverter]::new().ConvertFromString("#00B4DB")
            } else {
                $btn.Background = [System.Windows.Media.BrushConverter]::new().ConvertFromString("Transparent")
                $btn.Foreground = [System.Windows.Media.BrushConverter]::new().ConvertFromString("#7B8498")
            }
        }
    }
}

function Get-VisualChildren {
    param($parent)
    $children = @()
    if ($null -eq $parent) { return $children }
    
    if ($parent.Children) {
        foreach ($child in $parent.Children) {
            $children += $child
            $children += Get-VisualChildren -parent $child
        }
    } elseif ($parent.Content) {
        $child = $parent.Content
        $children += $child
        $children += Get-VisualChildren -parent $child
    }
    return $children
}

function Animate-SectionItems {
    param($viewElem)
    if ($null -eq $viewElem) { return }
    
    $allChildren = Get-VisualChildren -parent $viewElem
    $itemsToAnimate = @()
    foreach ($child in $allChildren) {
        if ($child.Visibility -eq [System.Windows.Visibility]::Visible -and $child.Name -and ($child.Name.StartsWith("ITEM_") -or $child.Name.StartsWith("CARD_") -or $child.Name.StartsWith("BTN_CAT_"))) {
            $itemsToAnimate += $child
        }
    }
    
    if ($itemsToAnimate.Count -eq 0) { return }
    
    $delayMs = 25
    $index = 0
    foreach ($item in $itemsToAnimate) {
        $item.BeginAnimation([System.Windows.UIElement]::OpacityProperty, $null)
        if ($item.RenderTransform -and $item.RenderTransform -is [System.Windows.Media.TranslateTransform]) {
            $item.RenderTransform.BeginAnimation([System.Windows.Media.TranslateTransform]::YProperty, $null)
        }
        
        $animDelay = $index * $delayMs
        $index++
        if ($animDelay -gt 350) { $animDelay = 350 }
        
        $beginTime = [TimeSpan]::FromMilliseconds($animDelay)
        
        # Opacity animation (fade in)
        $animOp = New-Object System.Windows.Media.Animation.DoubleAnimation
        $animOp.From = 0
        $animOp.To = 1
        $animOp.Duration = "0:0:0.250"
        $animOp.BeginTime = $beginTime
        
        # Position animation (slide up slightly)
        $animY = New-Object System.Windows.Media.Animation.DoubleAnimation
        $animY.From = 14
        $animY.To = 0
        $animY.Duration = "0:0:0.250"
        $animY.BeginTime = $beginTime
        $animY.EasingFunction = New-Object System.Windows.Media.Animation.CubicEase -Property @{ EasingMode = 'EaseOut' }
        
        $item.Opacity = 0
        if ($item.RenderTransform -and $item.RenderTransform -is [System.Windows.Media.TranslateTransform]) {
            $item.RenderTransform.Y = 14
            $item.RenderTransform.BeginAnimation([System.Windows.Media.TranslateTransform]::YProperty, $animY)
        }
        $item.BeginAnimation([System.Windows.UIElement]::OpacityProperty, $animOp)
    }
}

function Show-View {
    param($view, $title = $null)
    $views = @("MAIN", "OTHER", "BACKUP", "BUGFIX", "SERVICES", "DEBLOAT", "SYSTWEAKS", "CLEANUP", "CPUTWEAKS", "RAMTWEAKS", "GPUTWEAKS", "NETTWEAKS", "INPUTTWEAKS", "ABOUT", "DISKTWEAKS")
    
    foreach ($v in $views) {
        $elemName = "VIEW_$v"
        $elem = $ui.FindName($elemName)
        if ($null -ne $elem) {
            if ($v -eq $view) {
                # Fast slide-up show
                $elem.Visibility = 'Visible'
                $elem.BeginAnimation([System.Windows.UIElement]::OpacityProperty, $null)
                if ($elem.RenderTransform) {
                    $elem.RenderTransform.BeginAnimation([System.Windows.Media.TranslateTransform]::YProperty, $null)
                }
                $animY = New-Object System.Windows.Media.Animation.DoubleAnimation -Property @{ From = 15; To = 0; Duration = "0:0:0.300"; EasingFunction = (New-Object System.Windows.Media.Animation.CubicEase -Property @{ EasingMode = 'EaseOut' }) }
                $elem.RenderTransform.BeginAnimation([System.Windows.Media.TranslateTransform]::YProperty, $animY)
                $animOp = New-Object System.Windows.Media.Animation.DoubleAnimation -Property @{ From = 0; To = 1; Duration = "0:0:0.250" }
                $elem.BeginAnimation([System.Windows.UIElement]::OpacityProperty, $animOp)
                
                if (Get-Command Update-AllPlatinumCatalogSections -ErrorAction SilentlyContinue) {
                    Update-AllPlatinumCatalogSections
                }
                # Run cascade animations for non-home views
                if ($v -ne "MAIN") {
                    Animate-SectionItems -viewElem $elem
                }
            } else {
                # Fast hide
                $elem.Visibility = 'Hidden'
                $elem.BeginAnimation([System.Windows.UIElement]::OpacityProperty, $null)
                if ($elem.RenderTransform) {
                    $elem.RenderTransform.BeginAnimation([System.Windows.Media.TranslateTransform]::YProperty, $null)
                }
                $elem.Opacity = 0
            }
        }
    }
    if ($title) { 
        $txt = $ui.FindName("TXT_OTHER_TITLE")
        if ($null -ne $txt) { $txt.Text = $title }
    }
}