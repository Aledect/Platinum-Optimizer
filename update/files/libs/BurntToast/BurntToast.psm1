# Helper function to inject arbitrary objects into a pipeline stream
function Add-PipelineObject {
    [cmdletBinding()]
    param (
        [Parameter(Mandatory,
                   ValueFromPipeline)]
        [Object[]] $InputObject,

        [Parameter(Mandatory)]
        [scriptblock] $Process
    )

    Process {
        $_
    }

    End {
        $Process.Invoke()
    }
}
function Get-BTScriptBlockHash {
    <#
        .SYNOPSIS
        Returns a normalized SHA256 hash for a ScriptBlock.

        .DESCRIPTION
        Converts the ScriptBlock to string, collapses whitespace, trims, lowercases, and returns SHA256 hash.
        Used to uniquely identify ScriptBlocks for event registration scenarios.

        .PARAMETER ScriptBlock
        The [scriptblock] to hash.

        .INPUTS
        System.Management.Automation.ScriptBlock

        .OUTPUTS
        String (SHA256 hex)

        .EXAMPLE
        $hash = Get-BTScriptBlockHash { Write-Host 'Hello' }
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [scriptblock]$ScriptBlock
    )
    process {
        # Remove all whitespace and semicolons for robust logical identity
        $normalized = ($ScriptBlock.ToString() -replace '[\s;]+', '').ToLowerInvariant()
        $bytes = [System.Text.Encoding]::UTF8.GetBytes($normalized)
        $sha = [System.Security.Cryptography.SHA256]::Create()
        $hashBytes = $sha.ComputeHash($bytes)
        -join ($hashBytes | ForEach-Object { $_.ToString('x2') })
    }
}
function Optimize-BTImageSource {
    param (
        [Parameter(Mandatory)]
        [String] $Source,

        [Switch] $ForceRefresh
    )

    if ([bool]([System.Uri]$Source).IsUnc -or ([System.Uri]$Source).Scheme -like 'http*') {
        $RemoteFileName = $Source -replace '/|:|\\', '-'

        $NewFilePath = '{0}\{1}' -f $Env:TEMP, $RemoteFileName

        if (!(Test-Path -Path $NewFilePath) -or $ForceRefresh) {
            if ([bool]([System.Uri]$Source).IsUnc) {
                Copy-Item -Path $Source -Destination $NewFilePath -Force
            } else {
                Invoke-WebRequest -Uri $Source -OutFile $NewFilePath
            }
        }

        $NewFilePath
    } else {
        try {
            (Get-Item -Path $Source -ErrorAction Stop).FullName
        } catch {
            Write-Warning -Message "The image source '$Source' doesn't exist, failed back to icon."
        }
    }
}
function Get-BTHeader {
    <#
        .SYNOPSIS
        Shows and filters all toast notification headers in the Action Center.

        .DESCRIPTION
        The Get-BTHeader function returns all the unique toast notification headers currently present in the Action Center (notifications which have not been dismissed by the user).
        You can filter by a specific toast notification identifier, header title, or header id.

        .PARAMETER ToastUniqueIdentifier
        The unique identifier (string) of a toast notification. Only headers belonging to the notification with this identifier will be returned.

        .PARAMETER Title
        Filters headers by a specific title (string).

        .PARAMETER Id
        Filters headers to only those with the specified header id (string).

        .INPUTS
        None. You cannot pipe input to this function.

        .OUTPUTS
        Microsoft.Toolkit.Uwp.Notifications.ToastHeader

        .EXAMPLE
        Get-BTHeader
        Returns all unique toast notification headers in the Action Center.

        .EXAMPLE
        Get-BTHeader -ToastUniqueIdentifier 'Toast001'
        Returns headers for toasts with the specified unique identifier.

        .EXAMPLE
        Get-BTHeader -Title "Stack Overflow Questions"
        Returns headers with a specific title.

        .EXAMPLE
        Get-BTHeader -Id "001"
        Returns the header with the matching id.

        .LINK
        https://github.com/Windos/BurntToast/blob/main/Help/Get-BTHeader.md
    #>

    [cmdletBinding(DefaultParametersetName = 'All',
                   HelpUri='https://github.com/Windos/BurntToast/blob/main/Help/Get-BTHeader.md')]
    param (
        [Parameter(Mandatory,
                   ParametersetName = 'ByToastId')]
        [Alias('ToastId')]
        [string] $ToastUniqueIdentifier,

        [Parameter(Mandatory,
                   ParametersetName = 'ByTitle')]
        [string] $Title,

        [Parameter(Mandatory,
                   ParametersetName = 'ById')]
        [Alias('HeaderId')]
        [string] $Id
    )

    $HistoryParams = @{}
    if ($PSCmdlet.ParameterSetName -eq 'ByToastId') { $HistoryParams['UniqueIdentifier'] = $ToastUniqueIdentifier}

    $HeaderIds = New-Object -TypeName "System.Collections.ArrayList"

    # Union all of the possible Toast Notifications
    Get-BTHistory @HistoryParams | `
    Add-PipelineObject -Process {
        Get-BTHistory @HistoryParams -ScheduledToast
    } | `
    # Only select those that actually have a valid definition
    Where-Object { $null -ne $_.Content } | `
    # Find unique Header nodes in the notifications
    ForEach-Object -Process {
        $HeaderNode = $_.Content.SelectSingleNode('//*/header')
        if ($null -ne $HeaderNode -and $null -ne $HeaderNode.GetAttribute('id') -and $HeaderIds -notcontains $HeaderNode.GetAttribute('id')) {
            $HeaderIds.Add($HeaderNode.GetAttribute('id')) | Out-Null
            $HeaderNode
        }
    } | `
    # Filter header by title, when specified
    Where-Object { $PSCmdlet.ParameterSetName -ne 'ByTitle' -or $_.GetAttribute('title') -eq $Title } | `
    # Filter header by id, when specified
    Where-Object { $PSCmdlet.ParameterSetName -ne 'ById' -or $_.GetAttribute('id') -eq $Id } | `
    # Convert the XML definition into an actual ToastHeader object
    ForEach-Object -Process {
        $Header = [Microsoft.Toolkit.Uwp.Notifications.ToastHeader]::new($HeaderNode.GetAttribute('id'), $HeaderNode.GetAttribute('title'), $HeaderNode.GetAttribute('arguments'))
        $Header.ActivationType = $HeaderNode.GetAttribute('activationType')
        $Header
    }
}
function Get-BTHistory {
    <#
        .SYNOPSIS
        Shows all toast notifications in the Action Center or scheduled notifications.

        .DESCRIPTION
        The Get-BTHistory function returns all toast notifications that are in the Action Center and have not been dismissed by the user.
        You can retrieve a specific toast notification with a unique identifier, or include scheduled notifications (either scheduled outright or snoozed).
        The objects returned include tag and group information which can be used with Remove-BTNotification to remove specific notifications.

        .PARAMETER UniqueIdentifier
        Returns only toasts with a matching tag or group specified by the provided unique identifier (string).

        .PARAMETER ScheduledToast
        Switch. If provided, returns scheduled toast notifications instead of those currently in the Action Center.

        .INPUTS
        None. You cannot pipe input to this function.

        .OUTPUTS
        Microsoft.Toolkit.Uwp.Notifications.ToastNotification
        Microsoft.Toolkit.Uwp.Notifications.ScheduledToastNotification

        .EXAMPLE
        Get-BTHistory
        Returns all toast notifications in the Action Center.

        .EXAMPLE
        Get-BTHistory -ScheduledToast
        Returns scheduled toast notifications.

        .EXAMPLE
        Get-BTHistory -UniqueIdentifier 'Toast001'
        Returns toasts with the matching unique identifier in their tag or group.

        .LINK
        https://github.com/Windos/BurntToast/blob/main/Help/Get-BTHistory.md
    #>

    [cmdletBinding(HelpUri='https://github.com/Windos/BurntToast/blob/main/Help/Get-BTHistory.md')]
    param (
        [string] $UniqueIdentifier,

        [switch] $ScheduledToast
    )

    if ($Script:ActionsSupported) {
        Write-Warning -Message 'The output from this function in some versions of PowerShell is not useful. Unfortunately this is expected at this time.'
    }

    $Toasts = if ($ScheduledToast) {
        [Microsoft.Toolkit.Uwp.Notifications.ToastNotificationManagerCompat]::CreateToastNotifier().GetScheduledToastNotifications()
    } else {
        [Microsoft.Toolkit.Uwp.Notifications.ToastNotificationManagerCompat]::History.GetHistory()
    }

    if ($UniqueIdentifier) {
        $Toasts | Where-Object {$_.Tag -eq $UniqueIdentifier -or $_.Group -eq $UniqueIdentifier}
    } else {
        $Toasts
    }
}
function New-BTAction {
    <#
        .SYNOPSIS
        Creates an action set for a Toast Notification.

        .DESCRIPTION
        The New-BTAction function creates a Toast action object (IToastActions), defining the controls displayed at the bottom of a Toast Notification.
        Actions can be custom (buttons, context menu items, and input controls) or system handled (Snooze and Dismiss).

        .PARAMETER Buttons
        Button objects created with New-BTButton. Up to five may be included, or fewer if context menu items are also included.

        .PARAMETER ContextMenuItems
        Right-click context menu item objects created with New-BTContextMenuItem. Up to five may be included, or fewer if Buttons are included.

        .PARAMETER Inputs
        Input objects created via New-BTText and New-BTSelectionBoxItem. Up to five can be included.

        .PARAMETER SnoozeAndDismiss
        Switch. Creates a system-handled set of Snooze and Dismiss buttons, only available in the 'SnoozeAndDismiss' parameter set. Cannot be used with custom actions.

        .INPUTS
        None. You cannot pipe input to this function.

        .OUTPUTS
        Microsoft.Toolkit.Uwp.Notifications.IToastActions

        .EXAMPLE
        New-BTAction -SnoozeAndDismiss
        Creates an action set using the system handled snooze and dismiss modal.

        .EXAMPLE
        New-BTAction -Buttons (New-BTButton -Content 'Google' -Arguments 'https://google.com')
        Creates an action set with a single button that opens Google.

        .EXAMPLE
        $Button = New-BTButton -Content 'Google' -Arguments 'https://google.com'
        $ContextMenuItem = New-BTContextMenuItem -Content 'Bing' -Arguments 'https://bing.com'
        New-BTAction -Buttons $Button -ContextMenuItems $ContextMenuItem
        Creates an action set with both a clickable button and a context menu item.

        .EXAMPLE
        New-BTAction -Inputs (New-BTText -Content "Add comment")
        Creates an action set allowing user textual input in the notification.

        .LINK
        https://github.com/Windos/BurntToast/blob/main/Help/New-BTAction.md
    #>

    [CmdletBinding(DefaultParametersetName = 'Custom Actions',
                   SupportsShouldProcess   = $true,
                   HelpUri = 'https://github.com/Windos/BurntToast/blob/main/Help/New-BTAction.md')]
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.IToastActions])]
    param (
        [ValidateCount(0, 5)]
        [Parameter(ParameterSetName = 'Custom Actions')]
        [Microsoft.Toolkit.Uwp.Notifications.IToastButton[]] $Buttons,

        [ValidateCount(0, 5)]
        [Parameter(ParameterSetName = 'Custom Actions')]
        [Microsoft.Toolkit.Uwp.Notifications.ToastContextMenuItem[]] $ContextMenuItems,

        [ValidateCount(0, 5)]
        [Parameter(ParameterSetName = 'Custom Actions')]
        [Microsoft.Toolkit.Uwp.Notifications.IToastInput[]] $Inputs,

        [Parameter(Mandatory,
                   ParameterSetName = 'SnoozeAndDismiss')]
        [switch] $SnoozeAndDismiss
    )

    begin {
        if (($ContextMenuItems.Length + $Buttons.Length) -gt 5) {
            throw "You have included too many buttons and context menu items. The maximum combined number of these elements is five."
        }
    }
    process {
        if ($SnoozeAndDismiss) {
            $ToastActions = [Microsoft.Toolkit.Uwp.Notifications.ToastActionsSnoozeAndDismiss]::new()
        } else {
            $ToastActions = [Microsoft.Toolkit.Uwp.Notifications.ToastActionsCustom]::new()

            if ($Buttons) {
                foreach ($Button in $Buttons) {
                    $ToastActions.Buttons.Add($Button)
                }
            }

            if ($ContextMenuItems) {
                foreach ($ContextMenuItem in $ContextMenuItems) {
                    $ToastActions.ContextMenuItems.Add($ContextMenuItem)
                }
            }

            if ($Inputs) {
                foreach ($Input in $Inputs) {
                    $ToastActions.Inputs.Add($Input)
                }
            }
        }

        if($PSCmdlet.ShouldProcess("returning: [$($ToastActions.GetType().Name)] with $($ToastActions.Inputs.Count) Inputs, $($ToastActions.Buttons.Count) Buttons, and $($ToastActions.ContextMenuItems.Count) ContextMenuItems")) {
            $ToastActions
        }
    }
}
function New-BTAudio {
    <#
        .SYNOPSIS
        Creates a new Audio object for Toast Notifications.

        .DESCRIPTION
        The New-BTAudio function creates an audio object for Toast Notifications.
        You can use this function to select a built-in notification sound (including alarms/calls), specify a custom audio file, or indicate that the notification should be silent.

        .PARAMETER Source
        URI string. Specifies the sound to play with the Toast Notification.
        Accepts Microsoft notification sound URIs such as ms-winsoundevent:Notification.IM or a file path for custom audio.

        .PARAMETER Loop
        Switch. Specifies that the selected sound should loop, if its duration is shorter than the toast it accompanies.

        .PARAMETER Silent
        Switch. Makes the toast silent (no sound).

        .INPUTS
        None. You cannot pipe input to this function.

        .OUTPUTS
        Microsoft.Toolkit.Uwp.Notifications.ToastAudio

        .EXAMPLE
        New-BTAudio -Source ms-winsoundevent:Notification.SMS
        Creates an audio object which will cause a Toast Notification to play the standard Microsoft 'SMS' sound.

        .EXAMPLE
        New-BTAudio -Source 'C:\Music\FavSong.mp3'
        Creates an audio object which will cause a Toast Notification to play the specified song or audio file.

        .EXAMPLE
        New-BTAudio -Silent
        Creates an audio object which will cause a Toast Notification to be silent.

        .LINK
        https://github.com/Windos/BurntToast/blob/main/Help/New-BTAudio.md
    #>

    [CmdletBinding(DefaultParameterSetName = 'StandardSound',
                   SupportsShouldProcess   = $true,
                   HelpUri = 'https://github.com/Windos/BurntToast/blob/main/Help/New-BTAudio.md')]
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.ToastAudio])]
    param (
        [Parameter(Mandatory,
                   ParameterSetName = 'StandardSound')]
        [ValidateSet('ms-winsoundevent:Notification.Default',
                     'ms-winsoundevent:Notification.IM',
                     'ms-winsoundevent:Notification.Mail',
                     'ms-winsoundevent:Notification.Reminder',
                     'ms-winsoundevent:Notification.SMS',
                     'ms-winsoundevent:Notification.Looping.Alarm',
                     'ms-winsoundevent:Notification.Looping.Alarm2',
                     'ms-winsoundevent:Notification.Looping.Alarm3',
                     'ms-winsoundevent:Notification.Looping.Alarm4',
                     'ms-winsoundevent:Notification.Looping.Alarm5',
                     'ms-winsoundevent:Notification.Looping.Alarm6',
                     'ms-winsoundevent:Notification.Looping.Alarm7',
                     'ms-winsoundevent:Notification.Looping.Alarm8',
                     'ms-winsoundevent:Notification.Looping.Alarm9',
                     'ms-winsoundevent:Notification.Looping.Alarm10',
                     'ms-winsoundevent:Notification.Looping.Call',
                     'ms-winsoundevent:Notification.Looping.Call2',
                     'ms-winsoundevent:Notification.Looping.Call3',
                     'ms-winsoundevent:Notification.Looping.Call4',
                     'ms-winsoundevent:Notification.Looping.Call5',
                     'ms-winsoundevent:Notification.Looping.Call6',
                     'ms-winsoundevent:Notification.Looping.Call7',
                     'ms-winsoundevent:Notification.Looping.Call8',
                     'ms-winsoundevent:Notification.Looping.Call9',
                     'ms-winsoundevent:Notification.Looping.Call10')]
        [uri] $Source,

        [Parameter(ParameterSetName = 'StandardSound')]
        [switch] $Loop,

        [Parameter(Mandatory,
                   ParameterSetName = 'Silent')]
        [switch] $Silent
    )

    $Audio = [Microsoft.Toolkit.Uwp.Notifications.ToastAudio]::new()

    if ($Source) {
        $Audio.Src = $Source
    }

    $Audio.Loop = $Loop
    $Audio.Silent = $Silent

    if($PSCmdlet.ShouldProcess("returning: [$($Audio.GetType().Name)]:Src=$($Audio.Src):Loop=$($Audio.Loop):Silent=$($Audio.Silent)")) {
        $Audio
    }
}
function New-BTBinding {
    <#
        .SYNOPSIS
        Creates a new Generic Toast Binding object.

        .DESCRIPTION
        The New-BTBinding function creates a new Generic Toast Binding, in which you provide text, images, columns, progress bars, and more, controlling the visual appearance of the notification.

        .PARAMETER Children
        Array of binding children elements to include, such as Text, Image, Group, or Progress Bar objects, created by other BurntToast functions (New-BTText, New-BTImage, New-BTProgressBar, etc).

        .PARAMETER Column
        Array of AdaptiveSubgroup elements (columns), created via New-BTColumn, to display content side by side within the binding.

        .PARAMETER AddImageQuery
        Switch. Allows Windows to append a query string to image URIs for scale and language support; only needed for remote images.

        .PARAMETER AppLogoOverride
        An optional override for the logo displayed in the notification, created with New-BTImage using the AppLogoOverride switch.

        .PARAMETER Attribution
        Optional attribution text. Only supported on modern versions of Windows.

        .PARAMETER BaseUri
        A URI that is combined with relative image URIs for images in the notification.

        .PARAMETER HeroImage
        Optional hero image object, created with New-BTImage using the HeroImage switch.

        .PARAMETER Language
        String specifying the locale (e.g. "en-US" or "fr-FR") for the binding and contained text.

        .INPUTS
        None. You cannot pipe input to this function.

        .OUTPUTS
        Microsoft.Toolkit.Uwp.Notifications.ToastBindingGeneric

        .EXAMPLE
        $text1 = New-BTText -Content 'This is a test'
        $image1 = New-BTImage -Source 'C:\BurntToast\Media\BurntToast.png'
        $binding = New-BTBinding -Children $text1, $image1
        Combines text and image into a binding for use in a visual toast.

        .EXAMPLE
        $progress = New-BTProgressBar -Title 'Updating' -Status 'Running' -Value 0.4
        $binding = New-BTBinding -Children $progress
        Includes a progress bar element in the binding.

        .EXAMPLE
        $col1 = New-BTColumn -Children (New-BTText -Text 'a')
        $col2 = New-BTColumn -Children (New-BTText -Text 'b')
        $binding = New-BTBinding -Column $col1, $col2
        Uses two columns to display content side by side.

        .LINK
        https://github.com/Windos/BurntToast/blob/main/Help/New-BTBinding.md
    #>

    [CmdletBinding(SupportsShouldProcess = $true,
                   HelpUri = 'https://github.com/Windos/BurntToast/blob/main/Help/New-BTBinding.md')]
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.ToastBindingGeneric])]
    param (
        [Microsoft.Toolkit.Uwp.Notifications.IToastBindingGenericChild[]] $Children,

        [Microsoft.Toolkit.Uwp.Notifications.AdaptiveSubgroup[]] $Column,

        [switch] $AddImageQuery,

        [Microsoft.Toolkit.Uwp.Notifications.ToastGenericAppLogo] $AppLogoOverride,

        [string] $Attribution,

        [uri] $BaseUri,

        [Microsoft.Toolkit.Uwp.Notifications.ToastGenericHeroImage] $HeroImage,

        [string] $Language
    )

    $Binding = [Microsoft.Toolkit.Uwp.Notifications.ToastBindingGeneric]::new()

    if ($Children) {
        foreach ($Child in $Children) {
            $Binding.Children.Add($Child)
        }
    }

    if ($Column) {
        $AdaptiveGroup = [Microsoft.Toolkit.Uwp.Notifications.AdaptiveGroup]::new()

        foreach ($Group in $Column) {
            $AdaptiveGroup.Children.Add($Group)
        }

        $Binding.Children.Add($AdaptiveGroup)
    }

    if ($AddImageQuery) {
        $Binding.AddImageQuery = $AddImageQuery
    }

    if ($AppLogoOverride) {
        $Binding.AppLogoOverride = $AppLogoOverride
    }

    if ($Attribution) {
        $AttribText = [Microsoft.Toolkit.Uwp.Notifications.ToastGenericAttributionText]::new()
        $AttribText.Text = $Attribution

        if ($Language) {
            $AttribText.Language = $Language
        }

        $Binding.Attribution = $AttribText
    }

    if ($BaseUri) {
        $Binding.BaseUri = $BaseUri
    }

    if ($HeroImage) {
        $Binding.HeroImage = $HeroImage
    }

    if ($Language) {
        $Binding.Language = $Language
    }

    if($PSCmdlet.ShouldProcess("returning: [$($Binding.GetType().Name)]:Children=$($Binding.Children.Count):AddImageQuery=$($Binding.AddImageQuery.Count):AppLogoOverride=$($Binding.AppLogoOverride.Count):Attribution=$($Binding.Attribution.Count):BaseUri=$($Binding.BaseUri.Count):HeroImage=$($Binding.HeroImage.Count):Language=$($Binding.Language.Count)")) {
        $Binding
    }
}
function New-BTButton {
    <#
        .SYNOPSIS
        Creates a new clickable button for a Toast Notification, with optional color styling.

        .DESCRIPTION
        The New-BTButton function creates a new button for a Toast Notification. Up to five buttons can be added to a single Toast notification.
        Buttons may have display text, an icon, an optional activation type, argument string, serve as system managed Dismiss/Snooze buttons, and may optionally be rendered with colored button styles by specifying -Color.

        If -Color is set to 'Green' or 'Red', the button will be displayed with a "Success" (green) or "Critical" (red) style in supported environments.

        .PARAMETER Snooze
        Switch. Creates a system-handled snooze button. When paired with a selection box on the toast, the snooze time is customizable.

        .PARAMETER Dismiss
        Switch. Creates a system-handled dismiss button.

        .PARAMETER Content
        String. The text to display on this button. For system buttons, this overrides the default label.

        .PARAMETER Arguments
        String. App-defined string to pass when the button is pressed. Often a URI or file path to open.

        .PARAMETER ActivationType
        Enum. Defines the activation type that triggers when the button is pressed. Defaults to Protocol.

        .PARAMETER ImageUri
        String. Path or URI of an image icon to display next to the button label.

        .PARAMETER Id
        String. Specifies an ID associated with another toast control (textbox or selection box). For standard buttons, this aligns the button next to a control, for snooze buttons it associates with a selection box.

        .PARAMETER Color
        String. Optional. If specified as 'Green' or 'Red', the button will be visually styled as "Success" (green) or "Critical" (red) where supported. Use for indicating primary/positive or destructive actions.

        .INPUTS
        None. You cannot pipe input to this function.

        .OUTPUTS
        Microsoft.Toolkit.Uwp.Notifications.ToastButton
        Microsoft.Toolkit.Uwp.Notifications.ToastButtonDismiss
        Microsoft.Toolkit.Uwp.Notifications.ToastButtonSnooze

        .EXAMPLE
        New-BTButton -Dismiss
        Creates a button which mimics the act of 'swiping away' the Toast when clicked.

        .EXAMPLE
        New-BTButton -Snooze
        Creates a snooze button with system default snooze duration.

        .EXAMPLE
        New-BTButton -Snooze -Content 'Sleep' -Id 'TimeSelection'
        Snooze button using the label 'Sleep' and referencing a selection box control.

        .EXAMPLE
        New-BTButton -Content 'Blog' -Arguments 'https://king.geek.nz'
        Regular button that opens a URL when clicked.

        .EXAMPLE
        $pic = 'C:\temp\example.png'
        New-BTButton -Content 'View Picture' -Arguments $pic -ImageUri $pic
        Button with a picture to the left, launches the image file.

        .EXAMPLE
        New-BTButton -Content 'Approve' -Arguments 'approve' -Color 'Green'
        Creates a button with a green "Success" style intended for positive actions like approval.

        .EXAMPLE
        New-BTButton -Content 'Delete' -Arguments 'delete' -Color 'Red'
        Creates a button with a red "Critical" style indicating a destructive action.

        .LINK
        https://github.com/Windos/BurntToast/blob/main/Help/New-BTButton.md
    #>

    [CmdletBinding(DefaultParametersetName = 'Button',
                   SupportsShouldProcess   = $true,
                   HelpUri = 'https://github.com/Windos/BurntToast/blob/main/Help/New-BTButton.md')]
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.ToastButton], ParameterSetName = 'Button')]
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.ToastButtonDismiss], ParameterSetName = 'Dismiss')]
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.ToastButtonSnooze], ParameterSetName = 'Snooze')]

    param (
        [Parameter(Mandatory,
                   ParameterSetName = 'Snooze')]
        [switch] $Snooze,

        [Parameter(Mandatory,
                   ParameterSetName = 'Dismiss')]
        [switch] $Dismiss,

        [Parameter(Mandatory,
                   ParameterSetName = 'Button')]
        [Parameter(ParameterSetName = 'Dismiss')]
        [Parameter(ParameterSetName = 'Snooze')]
        [string] $Content,

        [Parameter(Mandatory,
                   ParameterSetName = 'Button')]
        [string] $Arguments,

        [Parameter(ParameterSetName = 'Button')]
        [Microsoft.Toolkit.Uwp.Notifications.ToastActivationType] $ActivationType = [Microsoft.Toolkit.Uwp.Notifications.ToastActivationType]::Protocol,

        [Parameter(ParameterSetName = 'Button')]
        [Parameter(ParameterSetName = 'Snooze')]
        [string] $ImageUri,

        [Parameter(ParameterSetName = 'Button')]
        [Parameter(ParameterSetName = 'Snooze')]
        [alias('TextBoxId', 'SelectionBoxId')]
        [string] $Id,

        [ValidateSet('Green', 'Red')]
        [string] $Color
    )

    switch ($PsCmdlet.ParameterSetName) {
        'Button' {
            $Button = [Microsoft.Toolkit.Uwp.Notifications.ToastButton]::new($Content, $Arguments)

            $Button.ActivationType = $ActivationType

            if ($Id) {
                $Button.TextBoxId = $Id
            }

            if ($ImageUri) {
                $Button.ImageUri = $ImageUri
            }
        }
        'Snooze' {

            if ($Content) {
                $Button = [Microsoft.Toolkit.Uwp.Notifications.ToastButtonSnooze]::new($Content)
            } else {
                $Button = [Microsoft.Toolkit.Uwp.Notifications.ToastButtonSnooze]::new()
            }

            if ($Id) {
                $Button.SelectionBoxId = $Id
            }

            if ($ImageUri) {
                $Button.ImageUri = $ImageUri
            }
        }
        'Dismiss' {
            if ($Content) {
                $Button = [Microsoft.Toolkit.Uwp.Notifications.ToastButtonDismiss]::new($Content)
            } else {
                $Button = [Microsoft.Toolkit.Uwp.Notifications.ToastButtonDismiss]::new()
            }
        }
    }

    if ($Color) {
        $Button = $Button.SetHintActionId($Color)
    }

    switch ($Button.GetType().Name) {
        ToastButton { if($PSCmdlet.ShouldProcess("returning: [$($Button.GetType().Name)]:Content=$($Button.Content):Arguments=$($Button.Arguments):ActivationType=$($Button.ActivationType):ImageUri=$($Button.ImageUri):TextBoxId=$($Button.TextBoxId)")) { $Button }}
        ToastButtonSnooze { if($PSCmdlet.ShouldProcess("returning: [$($Button.GetType().Name)]:CustomContent=$($Button.CustomContent):ImageUri=$($Button.ImageUri):SelectionBoxId=$($Button.SelectionBoxId)")) { $Button } }
        ToastButtonDismiss { if($PSCmdlet.ShouldProcess("returning: [$($Button.GetType().Name)]:CustomContent=$($Button.CustomContent):ImageUri=$($Button.ImageUri)")) { $Button } }
    }
}
function New-BTColumn {
    <#
        .SYNOPSIS
        Creates a new column (Adaptive Subgroup) for Toast Notifications.

        .DESCRIPTION
        The New-BTColumn function creates a column (Adaptive Subgroup) for Toast Notifications.
        Columns contain text and images and are provided to the Column parameter of New-BTBinding or New-BurntToastNotification.
        Content is arranged vertically and multiple columns can be combined for side-by-side layout.

        .PARAMETER Children
        Array. Elements (such as Adaptive Text or Image objects) for display in this column, created via New-BTText or New-BTImage.

        .PARAMETER Weight
        Int. The relative width of this column compared to others in the toast.

        .PARAMETER TextStacking
        Enum. Controls vertical alignment of the content; accepts values from AdaptiveSubgroupTextStacking.

        .INPUTS
        int
        Microsoft.Toolkit.Uwp.Notifications.IAdaptiveSubgroupChild
        Microsoft.Toolkit.Uwp.Notifications.AdaptiveSubgroupTextStacking
        You cannot pipe input to this function.

        .OUTPUTS
        Microsoft.Toolkit.Uwp.Notifications.AdaptiveSubgroup

        .EXAMPLE
        $labels = New-BTText -Text 'Title:' -Style Base
        $values = New-BTText -Text 'Example' -Style BaseSubtle
        $col1 = New-BTColumn -Children $labels -Weight 4
        $col2 = New-BTColumn -Children $values -Weight 6
        New-BTBinding -Column $col1, $col2

        .EXAMPLE
        $label = New-BTText -Text 'Now Playing'
        $col = New-BTColumn -Children $label
        New-BTBinding -Children $label -Column $col

        .LINK
        https://github.com/Windos/BurntToast/blob/main/Help/New-BTColumn.md
    #>

    [CmdletBinding(SupportsShouldProcess = $true, HelpUri = 'https://github.com/Windos/BurntToast/blob/main/Help/New-BTColumn.md')]
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.AdaptiveSubgroup])]
    param (
        [Parameter()]
        [Microsoft.Toolkit.Uwp.Notifications.IAdaptiveSubgroupChild[]] $Children,

        [int] $Weight,

        [Microsoft.Toolkit.Uwp.Notifications.AdaptiveSubgroupTextStacking] $TextStacking
    )

    $AdaptiveSubgroup = [Microsoft.Toolkit.Uwp.Notifications.AdaptiveSubgroup]::new()

    if ($Children) {
        foreach ($Child in $Children) {
            $AdaptiveSubgroup.Children.Add($Child)
        }
    }

    if ($Weight) {
        $AdaptiveSubgroup.HintWeight = $Weight
    }

    if ($TextStacking) {
        $AdaptiveSubgroup.HintTextStacking = $TextStacking
    }

    if ($PSCmdlet.ShouldProcess("Create AdaptiveSubgroup column")) {
        $AdaptiveSubgroup
    }
}
function New-BTContent {
    <#
        .SYNOPSIS
        Creates a new Toast Content object (base element for displaying a toast).

        .DESCRIPTION
        The New-BTContent function creates a new ToastContent object, the root config for a toast, containing the toast's visual, actions, audio, header, scenario, etc.

        .PARAMETER Actions
        Contains one or more custom actions (buttons, context menus, input fields), created via New-BTAction.

        .PARAMETER ActivationType
        Enum. Specifies what activation type is used when the user clicks the toast body.

        .PARAMETER Audio
        Adds audio properties for the toast, as created by New-BTAudio.

        .PARAMETER Duration
        Enum. How long the toast notification is displayed (Short/Long).

        .PARAMETER Header
        ToastHeader object, created via New-BTHeader, categorizing the toast in Action Center.

        .PARAMETER Launch
        String. Data passed to the activation context when a toast is clicked.

        .PARAMETER Scenario
        Enum. Tells Windows to treat the toast as an alarm, reminder, or more (ToastScenario).
        If the IncomingCall scenario is selected then any main body text on the toast notification, that is no longer than a single line in length, will be center aligned.
        Will be ignored if toast is submitted with `-Urgent` switch on the Submit-BTNotification function, as the Urgent scenario takes precedence but cannot be set via this parameter.

        .PARAMETER Visual
        Required. ToastVisual object, created by New-BTVisual, representing the core content of the toast.

        .PARAMETER ToastPeople
        ToastPeople object, representing recipient/persons (optional, used for group chat/etc).

        .PARAMETER CustomTimestamp
        DateTime. Optional timestamp for when the toast is considered created (affects Action Center sort order).

        .INPUTS
        None. You cannot pipe input to this function.

        .OUTPUTS
        Microsoft.Toolkit.Uwp.Notifications.ToastContent

        .EXAMPLE
        $binding = New-BTBinding -Children (New-BTText -Content 'Title')
        $visual = New-BTVisual -BindingGeneric $binding
        New-BTContent -Visual $visual

        .EXAMPLE
        $content = New-BTContent -Visual $visual -ActivationType Protocol -Launch 'https://example.com'
        Toast opens a browser to a URL when clicked.

        .LINK
        https://github.com/Windos/BurntToast/blob/main/Help/New-BTContent.md
    #>

    [CmdletBinding(SupportsShouldProcess = $true,
                   HelpUri = 'https://github.com/Windos/BurntToast/blob/main/Help/New-BTContent.md')]
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.ToastContent])]
    param (
        [Microsoft.Toolkit.Uwp.Notifications.IToastActions] $Actions,

        [Microsoft.Toolkit.Uwp.Notifications.ToastActivationType] $ActivationType,

        [Microsoft.Toolkit.Uwp.Notifications.ToastAudio] $Audio,

        [Microsoft.Toolkit.Uwp.Notifications.ToastDuration] $Duration,

        [Microsoft.Toolkit.Uwp.Notifications.ToastHeader] $Header,

        [string] $Launch,

        [Microsoft.Toolkit.Uwp.Notifications.ToastScenario] $Scenario,

        [Parameter(Mandatory)]
        [Microsoft.Toolkit.Uwp.Notifications.ToastVisual] $Visual,

        [Microsoft.Toolkit.Uwp.Notifications.ToastPeople] $ToastPeople,

        [datetime] $CustomTimestamp
    )

    $ToastContent = [Microsoft.Toolkit.Uwp.Notifications.ToastContent]::new()

    if ($Actions) {
        $ToastContent.Actions = $Actions
    }

    if ($ActivationType) {
        $ToastContent.ActivationType = $ActivationType
    }

    if ($Audio) {
        $ToastContent.Audio = $Audio
    }

    if ($Duration) {
        $ToastContent.Duration = $Duration
    }

    if ($Header) {
        $ToastContent.Header = $Header
    }

    if ($Launch) {
        $ToastContent.Launch = $Launch
    }

    if ($Scenario) {
        $ToastContent.Scenario = $Scenario
    }

    if ($Visual) {
        $ToastContent.Visual = $Visual
    }

    if ($Actions) {
        $ToastContent.Actions = $Actions
    }

    if ($ToastPeople) {
        $ToastContent.HintPeople = $ToastPeople
    }

    if ($CustomTimestamp) {
        $ToastContent.DisplayTimestamp = $CustomTimestamp
    }

    if($PSCmdlet.ShouldProcess( "returning: [$($ToastContent.GetType().Name)] with XML: $($ToastContent.GetContent())" )) {
        $ToastContent
    }
}
function New-BTContextMenuItem {
    <#
        .SYNOPSIS
        Creates a Context Menu Item object.

        .DESCRIPTION
        The New-BTContextMenuItem function creates a context menu item (ToastContextMenuItem) for a Toast Notification, typically added via New-BTAction.

        .PARAMETER Content
        The text string to display to the user for this menu item.

        .PARAMETER Arguments
        App-defined string that is returned if the context menu item is selected. Routinely a URI, file path, or app context string.

        .PARAMETER ActivationType
        Enum. Controls the type of activation for this menu item. Defaults to Foreground if not specified.

        .INPUTS
        None. You cannot pipe input to this function.

        .OUTPUTS
        Microsoft.Toolkit.Uwp.Notifications.ToastContextMenuItem

        .EXAMPLE
        New-BTContextMenuItem -Content 'Website' -Arguments 'https://example.com' -ActivationType Protocol
        Creates a menu item labeled "Website" that opens a URL on right-click.

        .LINK
        https://github.com/Windos/BurntToast/blob/main/Help/New-BTContextMenuItem.md
    #>

    [CmdletBinding(SupportsShouldProcess = $true,
                   HelpUri = 'https://github.com/Windos/BurntToast/blob/main/Help/New-BTContextMenuItem.md')]
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.ToastContextMenuItem])]

    param (
        [Parameter(Mandatory)]
        [string] $Content,

        [Parameter(Mandatory)]
        [string] $Arguments,

        [Parameter()]
        [Microsoft.Toolkit.Uwp.Notifications.ToastActivationType] $ActivationType
    )

    $MenuItem = [Microsoft.Toolkit.Uwp.Notifications.ToastContextMenuItem]::new($Content, $Arguments)

    if ($ActivationType) {
        $MenuItem.ActivationType = $ActivationType
    }

    if($PSCmdlet.ShouldProcess("returning: [$($MenuItem.GetType().Name)]:Content=$($MenuItem.Content):Arguments=$($MenuItem.Arguments):ActivationType=$($MenuItem.ActivationType)")) {
        $MenuItem
    }
}
function New-BTHeader {
    <#
        .SYNOPSIS
        Creates a new toast notification header.

        .DESCRIPTION
        The New-BTHeader function creates a toast notification header (ToastHeader) for a Toast Notification. Headers are displayed at the top and used for categorization or grouping in Action Center.

        .PARAMETER Id
        Unique string identifying this header instance. Used for replacement or updating by reuse.

        .PARAMETER Title
        The text displayed to the user as the header.

        .PARAMETER Arguments
        String data passed to Activation if the header itself is clicked.

        .PARAMETER ActivationType
        Enum specifying the activation type (defaults to Protocol).

        .INPUTS
        None. You cannot pipe input to this function.

        .OUTPUTS
        Microsoft.Toolkit.Uwp.Notifications.ToastHeader

        .EXAMPLE
        New-BTHeader -Title 'First Category'
        Creates a header titled 'First Category' for categorizing toasts.

        .EXAMPLE
        New-BTHeader -Id '001' -Title 'Stack Overflow Questions' -Arguments 'http://stackoverflow.com/'
        Creates a header with ID '001' and links activation to a URL.

        .LINK
        https://github.com/Windos/BurntToast/blob/main/Help/New-BTHeader.md
    #>

    [CmdletBinding(SupportsShouldProcess = $true,
                   HelpUri = 'https://github.com/Windos/BurntToast/blob/main/Help/New-BTHeader.md')]

    param (
        [Parameter()]
        [string] $Id = 'ID' + (New-Guid).ToString().Replace('-','').ToUpper(),

        [Parameter(Mandatory)]
        [string] $Title,

        [Parameter()]
        [string] $Arguments,

        [Parameter()]
        [Microsoft.Toolkit.Uwp.Notifications.ToastActivationType] $ActivationType = [Microsoft.Toolkit.Uwp.Notifications.ToastActivationType]::Protocol
    )

    $Header = [Microsoft.Toolkit.Uwp.Notifications.ToastHeader]::new($Id, ($Title -replace '\x01'), $Arguments)

    if ($ActivationType) {
        $Header.ActivationType = $ActivationType
    }

    if($PSCmdlet.ShouldProcess("returning: [$($Header.GetType().Name)]:Id=$($Header.Id):Title=$($Header.Title):Arguments=$($Header.Arguments):ActivationType=$($Header.ActivationType)")) {
        $Header
    }
}
function New-BTImage {
    <#
        .SYNOPSIS
        Creates a new Image Element for Toast Notifications.

        .DESCRIPTION
        The New-BTImage function creates an image element for Toast Notifications, which can be a standard, app logo, or hero image. You can specify the image source, cropping, alt text, alignment, and additional display properties.

        .PARAMETER Source
        String. URI or file path of the image. Can be from your app, local filesystem, or the internet (must be <200KB for remote).

        .PARAMETER AlternateText
        String. Description of the image for assistive technology.

        .PARAMETER AppLogoOverride
        Switch. Marks this image as the logo, to be shown as the app logo on the toast.

        .PARAMETER HeroImage
        Switch. Marks this image as the hero image, to be prominently displayed.

        .PARAMETER Align
        Enum. Horizontal alignment (only supported within groups).

        .PARAMETER Crop
        Enum. Specifies cropping of the image (e.g., Circle for logos).

        .PARAMETER RemoveMargin
        Switch. Removes default 8px margin around the image.

        .PARAMETER AddImageQuery
        Switch. Allows Windows to append scaling/language query string to the URI.

        .PARAMETER IgnoreCache
        Switch. Forces image to be refreshed (when used with Optimize-BTImageSource).

        .INPUTS
        None. You cannot pipe input to this function.

        .OUTPUTS
        Microsoft.Toolkit.Uwp.Notifications.AdaptiveImage
        Microsoft.Toolkit.Uwp.Notifications.ToastGenericAppLogo
        Microsoft.Toolkit.Uwp.Notifications.ToastGenericHeroImage

        .EXAMPLE
        $image1 = New-BTImage -Source 'C:\Media\BurntToast.png'
        Standard image for a toast body.

        .EXAMPLE
        $image2 = New-BTImage -Source 'C:\Media\BurntToast.png' -AppLogoOverride -Crop Circle
        Cropped circular logo for use on the toast.

        .EXAMPLE
        $image3 = New-BTImage -Source 'C:\Media\BurntToast.png' -HeroImage
        Hero image for the toast header.

        .LINK
        https://github.com/Windos/BurntToast/blob/main/Help/New-BTImage.md
    #>

    [CmdletBinding(DefaultParameterSetName = 'Image',
                   SupportsShouldProcess   = $true,
                   HelpUri = 'https://github.com/Windos/BurntToast/blob/main/Help/New-BTImage.md')]
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.AdaptiveImage], ParameterSetName = 'Image')]
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.ToastGenericAppLogo], ParameterSetName = 'AppLogo')]
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.ToastGenericHeroImage], ParameterSetName = 'Hero')]

    param (
        [string] $Source = $Script:DefaultImage,

        [string] $AlternateText,

        [Parameter(Mandatory,
            ParameterSetName = 'AppLogo')]
        [switch] $AppLogoOverride,

        [Parameter(Mandatory,
            ParameterSetName = 'Hero')]
        [switch] $HeroImage,

        [Parameter(ParameterSetName = 'Image')]
        [Microsoft.Toolkit.Uwp.Notifications.AdaptiveImageAlign] $Align,

        [Parameter(ParameterSetName = 'Image')]
        [Parameter(ParameterSetName = 'AppLogo')]
        [Microsoft.Toolkit.Uwp.Notifications.AdaptiveImageCrop] $Crop,

        [Parameter(ParameterSetName = 'Image')]
        [switch] $RemoveMargin,

        [switch] $AddImageQuery,

        [switch] $IgnoreCache
    )

    switch ($PsCmdlet.ParameterSetName) {
        'Image' {
            $Image = [Microsoft.Toolkit.Uwp.Notifications.AdaptiveImage]::new()

            if ($Align) {
                $Image.HintAlign = $Align
            }

            if ($Crop) {
                $Image.HintCrop = $Crop
            }

            $Image.HintRemoveMargin = $RemoveMargin
        }
        'AppLogo' {
            $Image = [Microsoft.Toolkit.Uwp.Notifications.ToastGenericAppLogo]::new()

            if ($Crop) {
                $Image.HintCrop = $Crop
            }
        }
        'Hero' {
            $Image = [Microsoft.Toolkit.Uwp.Notifications.ToastGenericHeroImage]::new()
        }
    }

    if ($Source) {
        $Image.Source = if ($IgnoreCache) {
            Optimize-BTImageSource -Source $Source -ForceRefresh
        } else {
            Optimize-BTImageSource -Source $Source
        }

    }

    if ($AlternateText) {
        $Image.AlternateText = $AlternateText
    }

    if ($AddImageQuery) {
        $Image.AddImageQuery = $AddImageQuery
    }

    switch ($Image.GetType().Name) {
        AdaptiveImage { if($PSCmdlet.ShouldProcess("returning: [$($Image.GetType().Name)]:Source=$($Image.Source):AlternateText=$($Image.AlternateText):HintCrop=$($Image.HintCrop):HintRemoveMargin=$($Image.HintRemoveMargin):HintAlign=$($Image.HintAlign):AddImageQuery=$($Image.AddImageQuery)")) { $Image } }
        ToastGenericAppLogo { if($PSCmdlet.ShouldProcess("returning: [$($Image.GetType().Name)]:Source=$($Image.Source):AlternateText=$($Image.AlternateText):HintCrop=$($Image.HintCrop):AddImageQuery=$($Image.AddImageQuery)")) { $Image } }
        ToastGenericHeroImage { if($PSCmdlet.ShouldProcess("returning: [$($Image.GetType().Name)]:Source=$($Image.Source):AlternateText=$($Image.AlternateText):AddImageQuery=$($Image.AddImageQuery)")) { $Image } }
    }
}
function New-BTInput {
    <#
        .SYNOPSIS
        Creates an input element (text box or selection box) for a Toast notification.

        .DESCRIPTION
        The New-BTInput function creates a ToastTextBox for user-typed input or a ToastSelectionBox for user selection, for interaction via toasts.
        Use the Text parameter set for a type-in input, and the Selection parameter set with a set of options for pick list behavior.

        .PARAMETER Id
        Mandatory. Developer-provided ID for referencing this input/result.

        .PARAMETER Title
        Text to display above the input box or selection.

        .PARAMETER PlaceholderContent
        String placeholder to show when the text box is empty (Text set only).

        .PARAMETER DefaultInput
        Default text to pre-fill in the text box.

        .PARAMETER DefaultSelectionBoxItemId
        ID of the default selection item (must match the Id of one of the provided SelectionBoxItems).

        .PARAMETER Items
        Array of ToastSelectionBoxItem objects to populate the pick list (Selection set).

        .INPUTS
        None. You cannot pipe input to this function.

        .OUTPUTS
        Microsoft.Toolkit.Uwp.Notifications.ToastTextBox
        Microsoft.Toolkit.Uwp.Notifications.ToastSelectionBox

        .EXAMPLE
        New-BTInput -Id 'Reply001' -Title 'Type a reply:'
        Creates a text input field on the toast.

        .EXAMPLE
        New-BTInput -Id 'Choice' -DefaultSelectionBoxItemId 'Item2' -Items $Sel1, $Sel2
        Creates a selection (dropdown) input with two options.

        .LINK
        https://github.com/Windos/BurntToast/blob/main/Help/New-BTInput.md
    #>

    [CmdletBinding(DefaultParametersetName = 'Text',
                   SupportsShouldProcess   = $true,
                   HelpUri = 'https://github.com/Windos/BurntToast/blob/main/Help/New-BTInput.md')]
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.ToastTextBox], ParametersetName = 'Text')]
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.ToastSelectionBox], ParametersetName = 'Text')]

    param (
        [Parameter(Mandatory)]
        [string] $Id,

        [Parameter()]
        [string] $Title,

        [Parameter(ParametersetName = 'Text')]
        [string] $PlaceholderContent,

        [Parameter(ParametersetName = 'Text')]
        [string] $DefaultInput,

        [Parameter(ParametersetName = 'Selection')]
        [string] $DefaultSelectionBoxItemId,

        [Parameter(Mandatory,
                   ParametersetName = 'Selection')]
        [Microsoft.Toolkit.Uwp.Notifications.ToastSelectionBoxItem[]] $Items
    )

    switch ($PsCmdlet.ParameterSetName) {
        'Text' {
            $ToastInput = [Microsoft.Toolkit.Uwp.Notifications.ToastTextBox]::new($Id)

            if ($PlaceholderContent) {
                $ToastInput.PlaceholderContent = $PlaceholderContent
            }

            if ($DefaultInput) {
                $ToastInput.DefaultInput = $DefaultInput
            }
        }
        'Selection' {
            $ToastInput = [Microsoft.Toolkit.Uwp.Notifications.ToastSelectionBox]::new($Id)

            if ($DefaultSelectionBoxItemId) {
                $ToastInput.DefaultSelectionBoxItemId = $DefaultSelectionBoxItemId
            }

            foreach ($Item in $Items) {
                $ToastInput.Items.Add($Item)
            }
        }
    }

    if ($Title) {
        $ToastInput.Title = $Title
    }

    switch ($ToastInput.GetType().Name) {
        ToastTextBox { if($PSCmdlet.ShouldProcess("returning: [$($ToastInput.GetType().Name)]:Id=$($ToastInput.Id):Title=$($ToastInput.Title):PlaceholderContent=$($ToastInput.PlaceholderContent):DefaultInput=$($ToastInput.DefaultInput)")) { $ToastInput } }
        ToastSelectionBox { if($PSCmdlet.ShouldProcess("returning: [$($ToastInput.GetType().Name)]:Id=$($ToastInput.Id):Title=$($ToastInput.Title):DefaultSelectionBoxItemId=$($ToastInput.DefaultSelectionBoxItemId):DefaultInput=$($ToastInput.Items.Count)")) { $ToastInput } }
    }
}
function New-BTProgressBar {
    <#
        .SYNOPSIS
        Creates a new Progress Bar element for Toast Notifications.

        .DESCRIPTION
        The New-BTProgressBar function creates a new AdaptiveProgressBar element for Toast Notifications, visualizing completion via percentage or indeterminate animation.

        .PARAMETER Title
        Text displayed above the progress bar (optional context).

        .PARAMETER Status
        Mandatory. String describing the current operation status, shown below the bar.

        .PARAMETER Indeterminate
        Switch. When set, an indeterminate animation is shown (can't be used with Value).

        .PARAMETER Value
        Double (0-1). The percent complete (e.g. 0.45 = 45%).

        .PARAMETER ValueDisplay
        String. Replaces default percentage label with a custom one.

        .INPUTS
        None. You cannot pipe input to this function.

        .OUTPUTS
        Microsoft.Toolkit.Uwp.Notifications.AdaptiveProgressBar

        .EXAMPLE
        New-BTProgressBar -Status 'Copying files' -Value 0.2
        Creates a 20% full progress bar showing the status.

        .EXAMPLE
        New-BTProgressBar -Status 'Copying files' -Indeterminate
        Progress bar with indeterminate animation.

        .EXAMPLE
        New-BTProgressBar -Status 'Copying files' -Value 0.2 -ValueDisplay '4/20 files complete'
        Progress bar at 20%, overridden label text.

        .EXAMPLE
        New-BTProgressBar -Title 'File Copy' -Status 'Copying files' -Value 0.2
        Displays title and status.

        .EXAMPLE
        $Progress = New-BTProgressBar -Status 'Copying files' -Value 0.2
        New-BurntToastNotification -Text 'File copy script running', 'More details!' -ProgressBar $Progress
        Toast notification includes a progress bar.

        .LINK
        https://github.com/Windos/BurntToast/blob/main/Help/New-BTProgressBar.md
    #>

    [CmdletBinding(DefaultParameterSetName = 'Determinate',
                   SupportsShouldProcess   = $true,
                   HelpUri = 'https://github.com/Windos/BurntToast/blob/main/Help/New-BTProgressBar.md')]
    param (
        [string] $Title,

        [Parameter(Mandatory)]
        [string] $Status,

        [Parameter(Mandatory,
                   ParameterSetName = 'Indeterminate')]
        [switch] $Indeterminate,

        [Parameter(Mandatory,
                   ParameterSetName = 'Determinate')]
        #[ValidateRange(0.0, 1.0)]
        $Value,

        [string] $ValueDisplay
    )

    $ProgressBar = [Microsoft.Toolkit.Uwp.Notifications.AdaptiveProgressBar]::new()

    $ProgressBar.Status = $Status

    if ($PSCmdlet.ParameterSetName -eq 'Determinate') {
        $ProgressBar.Value = [Microsoft.Toolkit.Uwp.Notifications.BindableProgressBarValue]::new($Value)
    } else {
        $ProgressBar.Value = 'indeterminate'
    }


    if ($Title) {
        $ProgressBar.Title = $Title
    }

    if ($ValueDisplay) {
        $ProgressBar.ValueStringOverride = $ValueDisplay
    }

    if($PSCmdlet.ShouldProcess("returning: [$($ProgressBar.GetType().Name)]:Status=$($ProgressBar.Status.BindingName):Title=$($ProgressBar.Title.BindingName):Value=$($ProgressBar.Value.BindingName):ValueStringOverride=$($ProgressBar.ValueStringOverride.BindingName)")) {
        $ProgressBar
    }
}
function New-BTSelectionBoxItem {
    <#
        .SYNOPSIS
        Creates a selection box item for use in a toast input.

        .DESCRIPTION
        The New-BTSelectionBoxItem function creates a selection box item (ToastSelectionBoxItem) to include as an option in a selection box, produced by New-BTInput.

        .PARAMETER Id
        Unique identifier for this selection box item, also referred to by DefaultSelectionBoxItemId when used in New-BTInput.

        .PARAMETER Content
        String to display as the label for the item in the dropdown.

        .INPUTS
        None. You cannot pipe input to this function.

        .OUTPUTS
        Microsoft.Toolkit.Uwp.Notifications.ToastSelectionBoxItem

        .EXAMPLE
        $Select1 = New-BTSelectionBoxItem -Id 'Item1' -Content 'First option in the list'
        Creates a Selection Box Item for use in a selection input element.

        .LINK
        https://github.com/Windos/BurntToast/blob/main/Help/New-BTSelectionBoxItem.md
    #>

    [CmdletBinding(SupportsShouldProcess = $true,
                   HelpUri = 'https://github.com/Windos/BurntToast/blob/main/Help/New-BTSelectionBoxItem.md')]
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.ToastSelectionBoxItem])]

    param (
        [Parameter(Mandatory)]
        [string] $Id,

        [Parameter(Mandatory)]
        [string] $Content
    )

    $SelectionBoxItem = [Microsoft.Toolkit.Uwp.Notifications.ToastSelectionBoxItem]::new($Id, $Content)

    if($PSCmdlet.ShouldProcess("returning: [$($SelectionBoxItem.GetType().Name)]:Id=$($SelectionBoxItem.Id):Content=$($SelectionBoxItem.Content)")) {
        $SelectionBoxItem
    }
}
function New-BTShortcut {
<#
    .SYNOPSIS
    Creates a Windows shortcut for launching PowerShell or a compatible host with a custom AppUserModelID, enabling full toast notification branding (name & icon).

    .DESCRIPTION
    To ensure toast notifications show your custom app name and icon (registered by New-BTAppId), PowerShell (or a custom host) must be launched from a shortcut
    with the AppUserModelID property set. This function automates creation of such a shortcut, optionally with a custom icon and host executable.

    .PARAMETER AppId
    The AppUserModelID to set on the shortcut (should match the value registered with New-BTAppId).

    .PARAMETER ShortcutPath
    Path where the shortcut (.lnk) will be created. Defaults to Desktop.

    .PARAMETER DisplayName
    Friendly display name/description for the shortcut (optional).

    .PARAMETER IconPath
    Path to the icon image to use for the shortcut (should match icon registered for AppId; optional).

    .PARAMETER ForceWindowsPowerShell
    Forces the shortcut to use Windows PowerShell (powershell.exe), even if PowerShell 7+ (pwsh.exe) is available. Cannot be used with ExecutablePath.

    .PARAMETER ExecutablePath
    The absolute path to a custom executable (pwsh.exe, powershell.exe, or another PowerShell host). Cannot be used with ForceWindowsPowerShell.

    .INPUTS
    None. You cannot pipe input to this function.

    .OUTPUTS
    System.IO.FileInfo (Returns the path to the created shortcut file).

    .EXAMPLE
    New-BTShortcut -AppId "Acme.MyApp" -DisplayName "My App PowerShell" -IconPath "C:\Path\To\MyIcon.ico"
    Creates a PowerShell shortcut with custom AppId and icon on the Desktop. Prefers pwsh.exe if available.

    .EXAMPLE
    New-BTShortcut -AppId "Acme.MyApp"
    Creates a default shortcut with AppUserModelID, desktop location, and default icon. Prefers pwsh.exe if available.

    .EXAMPLE
    New-BTShortcut -AppId "Acme.MyApp" -ForceWindowsPowerShell
    Forces the shortcut to always launch Windows PowerShell (powershell.exe).

    .EXAMPLE
    New-BTShortcut -AppId "Acme.MyApp" -ExecutablePath "C:\CustomHost\CustomHost.exe"
    Uses the specified executable as the shortcut target.

    .NOTES
    After creating the shortcut, launch PowerShell exclusively via this shortcut to guarantee Windows uses your custom name and icon
    for actionable toast notifications. This works for pwsh.exe (PowerShell 7+), powershell.exe (Windows PowerShell), or any compatible host.
#>
    [CmdletBinding(SupportsShouldProcess = $true, DefaultParameterSetName = "Dynamic", HelpUri = 'https://github.com/Windos/BurntToast/blob/main/Help/New-BTShortcut.md')]
    param(
        [Parameter(Mandatory=$true, ParameterSetName="Dynamic")]
        [Parameter(Mandatory=$true, ParameterSetName="ForceWindowsPowerShell")]
        [Parameter(Mandatory=$true, ParameterSetName="ExecutablePath")]
        [string]$AppId,

        [Parameter(ParameterSetName="Dynamic")]
        [Parameter(ParameterSetName="ForceWindowsPowerShell")]
        [Parameter(ParameterSetName="ExecutablePath")]
        [string]$ShortcutPath = [System.IO.Path]::Combine([Environment]::GetFolderPath("Desktop"), "PowerShell - $DisplayName.lnk"),

        [Parameter(ParameterSetName="Dynamic")]
        [Parameter(ParameterSetName="ForceWindowsPowerShell")]
        [Parameter(ParameterSetName="ExecutablePath")]
        [string]$DisplayName = "PowerShell ($AppId)",

        [Parameter(ParameterSetName="Dynamic")]
        [Parameter(ParameterSetName="ForceWindowsPowerShell")]
        [Parameter(ParameterSetName="ExecutablePath")]
        [string]$IconPath,

        [Parameter(ParameterSetName = "ForceWindowsPowerShell", Mandatory = $true)]
        [switch]$ForceWindowsPowerShell,

        [Parameter(ParameterSetName = "ExecutablePath", Mandatory = $true)]
        [string]$ExecutablePath
    )

    if ($PSCmdlet.ShouldProcess($ShortcutPath, "Create PowerShell shortcut")) {
        # Use WScript.Shell to create the shortcut
        $WScriptShell = New-Object -ComObject WScript.Shell
        $Shortcut = $WScriptShell.CreateShortcut($ShortcutPath)

        if ($PSCmdlet.ParameterSetName -eq 'ExecutablePath') {
            $Shortcut.TargetPath = $ExecutablePath
            $Shortcut.Arguments = "-NoExit"
        } elseif ($PSCmdlet.ParameterSetName -eq 'ForceWindowsPowerShell') {
            $Shortcut.TargetPath = (Get-Command powershell.exe).Source
            $Shortcut.Arguments = "-NoExit"
        } else {
            # Default behavior: pwsh.exe if found, else powershell.exe
            $pwsh = Get-Command pwsh.exe -ErrorAction SilentlyContinue
            if ($pwsh) {
                $Shortcut.TargetPath = $pwsh.Source
                $Shortcut.Arguments = "-NoExit"
            } else {
                $Shortcut.TargetPath = (Get-Command powershell.exe).Source
                $Shortcut.Arguments = "-NoExit"
            }
        }

        $Shortcut.Description = $DisplayName
        if ($IconPath) {
            $Shortcut.IconLocation = $IconPath
        }

        # Save shortcut file
        $Shortcut.Save()

        # Now set AppUserModelID directly via property store (COM/Windows API)
        try {
            $shell = New-Object -ComObject Shell.Application
            $folder = Split-Path $ShortcutPath
            $file = Split-Path $ShortcutPath -Leaf
            $folderItem = $shell.Namespace($folder).ParseName($file)
            $props = $folderItem.ExtendedProperty("System.AppUserModel.ID")
            if (-not $props -or $props -ne $AppId) {
                # Fallback to PowerShell Community: use Set-ItemProperty as known working on Windows 10+
                Set-ItemProperty -Path $ShortcutPath -Name 'System.AppUserModel.ID' -Value $AppId -ErrorAction SilentlyContinue
            }
        } catch {
            Write-Warning "Unable to set AppUserModelID property on shortcut. Try setting it manually if required."
        }
    }
}
function New-BTText {
    <#
        .SYNOPSIS
        Creates a new text element for Toast Notifications.

        .DESCRIPTION
        The New-BTText function creates an AdaptiveText object for Toast Notifications, used to display a line (or wrapped lines) of text. All formatting and layout options (wrapping, lines, alignment, style, language) are customizable.

        .PARAMETER Text
        The text to display as the content. If omitted, a blank line is produced. Aliased as 'Content'.

        .PARAMETER MaxLines
        Maximum number of lines the text may display (wraps/collapses extra lines).

        .PARAMETER MinLines
        Minimum number of lines that must be shown.

        .PARAMETER Wrap
        Switch. Enable/disable word wrapping.

        .PARAMETER Align
        Property for horizontal alignment of the text.

        .PARAMETER Style
        Controls font size, weight, opacity for the text.

        .PARAMETER Language
        BCP-47 language tag for payload, e.g. "en-US" (overrides parent).

        .PARAMETER Bind
        Switch. Indicates the text comes from a data binding expression (for advanced scenarios).

        .INPUTS
        None. You cannot pipe input to this function.

        .OUTPUTS
        Microsoft.Toolkit.Uwp.Notifications.AdaptiveText

        .EXAMPLE
        New-BTText -Content 'This is a line with text!'
        Creates a text element that will show this string in a Toast Notification.

        .EXAMPLE
        New-BTText
        Creates a blank line in the Toast.

        .LINK
        https://github.com/Windos/BurntToast/blob/main/Help/New-BTText.md
    #>

    [CmdletBinding(SupportsShouldProcess = $true,
                   HelpUri = 'https://github.com/Windos/BurntToast/blob/main/Help/New-BTText.md')]
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.AdaptiveText])]
    param (
        [Parameter()]
        [alias('Content')]
        [string] $Text,

        [int] $MaxLines,

        [int] $MinLines,

        [switch] $Wrap,

        [Microsoft.Toolkit.Uwp.Notifications.AdaptiveTextAlign] $Align,

        [Microsoft.Toolkit.Uwp.Notifications.AdaptiveTextStyle] $Style,

        [string] $Language,

        [switch] $Bind
    )

    $TextObj = [Microsoft.Toolkit.Uwp.Notifications.AdaptiveText]::new()

    if ($Text) {
        $TextObj.Text = $Text -replace '\x01'
    }

    if ($MaxLines) {
        $TextObj.HintMaxLines = $MaxLines
    }

    if ($MinLines) {
        $TextObj.HintMinLines = $MinLines
    }

    if ($Wrap) {
        $TextObj.HintWrap = $Wrap
    }

    if ($Align) {
        $TextObj.HintAlign = $Align
    }

    if ($Style) {
        $TextObj.HintStyle = $Style
    }

    if ($Language) {
        $TextObj.Language = $Language
    }

    if($PSCmdlet.ShouldProcess("returning: [$($TextObj.GetType().Name)]:Text=$($TextObj.Text.BindingName):HintMaxLines=$($TextObj.HintMaxLines):HintMinLines=$($TextObj.HintMinLines):HintWrap=$($TextObj.HintWrap):HintAlign=$($TextObj.HintAlign):HintStyle=$($TextObj.HintStyle):Language=$($TextObj.Language)")) {
        $TextObj
    }
}
function New-BTVisual {
    <#
        .SYNOPSIS
        Creates a new visual element for toast notifications.

        .DESCRIPTION
        The New-BTVisual function creates a ToastVisual object, defining the visual appearance and layout for a Toast Notification. This includes the root Toast binding, optional alternate bindings, image query, base URI, and locale settings.

        .PARAMETER BindingGeneric
        Mandatory. ToastBindingGeneric object describing the main layout and visuals (text, images, progress bars, columns).

        .PARAMETER BindingShoulderTap
        Optional alternate Toast binding that can be rendered on devices supporting ShoulderTap notifications.

        .PARAMETER AddImageQuery
        Switch. Allows image URIs to include scale and language info added by Windows.

        .PARAMETER BaseUri
        URI to prepend to all relative image uris in the toast.

        .PARAMETER Language
        BCP-47 tag specifying what language/locale to use for display.

        .INPUTS
        None. You cannot pipe input to this function.

        .OUTPUTS
        Microsoft.Toolkit.Uwp.Notifications.ToastVisual

        .EXAMPLE
        New-BTVisual -BindingGeneric $Binding1
        Creates a Toast Visual containing the provided binding.

        .LINK
        https://github.com/Windos/BurntToast/blob/main/Help/New-BTVisual.md
    #>

    [CmdletBinding(SupportsShouldProcess = $true,
                   HelpUri = 'https://github.com/Windos/BurntToast/blob/main/Help/New-BTVisual.md')]
    [OutputType([Microsoft.Toolkit.Uwp.Notifications.ToastVisual])]
    param (
        [Parameter(Mandatory)]
        [Microsoft.Toolkit.Uwp.Notifications.ToastBindingGeneric] $BindingGeneric,

        [Microsoft.Toolkit.Uwp.Notifications.ToastBindingShoulderTap] $BindingShoulderTap,

        [switch] $AddImageQuery,

        [uri] $BaseUri,

        [string] $Language
    )

    $Visual = [Microsoft.Toolkit.Uwp.Notifications.ToastVisual]::new()
    $Visual.BindingGeneric = $BindingGeneric

    $Visual.BindingShoulderTap = $BindingShoulderTap

    if ($AddImageQuery) {
        $Visual.AddImageQuery = $AddImageQuery
    }

    if ($BaseUri) {
        $Visual.BaseUri = $BaseUri
    }

    if ($Language) {
        $Visual.Language = $Language
    }

    if($PSCmdlet.ShouldProcess("returning: [$($Visual.GetType().Name)]:BindingGeneric=$($Visual.BindingGeneric.Children.Count):BaseUri=$($Visual.BaseUri):Language=$($Visual.Language)")) {
        $Visual
    }
}
function New-BurntToastNotification {
    <#
        .SYNOPSIS
        Creates and displays a rich Toast Notification for Windows.

        .DESCRIPTION
        The New-BurntToastNotification function creates and displays a Toast Notification supporting text, images, sounds, progress bars, actions, snooze/dismiss, attribution, and more on Microsoft Windows 10+.
        Parameter sets ensure mutual exclusivity (e.g., you cannot use Silent and Sound together).
        The `-Urgent` switch will designate the toast as an "Important Notification" that can break through Focus Assist.

        .PARAMETER Text
        Up to 3 strings to show within the Toast Notification. The first is the title.

        .PARAMETER Column
        Array of columns, created by New-BTColumn, to be rendered side-by-side in the toast.

        .PARAMETER AppLogo
        Path to an image that will appear as the application logo.

        .PARAMETER HeroImage
        Path to a prominent hero image for the notification.

        .PARAMETER Attribution
        Optional attribution text displayed at the bottom of the notification. Only supported on modern versions of Windows.

        .PARAMETER Sound
        The sound to play. Choose from Default, alarms, calls, etc. (Cannot be used with Silent.)

        .PARAMETER Silent
        Switch. Makes the notification silent.

        .PARAMETER SnoozeAndDismiss
        Switch. Adds system-provided snooze and dismiss controls.

        .PARAMETER Button
        Array of button objects for custom actions, created by New-BTButton.

        .PARAMETER Header
        Toast header object (New-BTHeader): categorize or group notifications.

        .PARAMETER ProgressBar
        One or more progress bars, created by New-BTProgressBar, for visualizing progress within the notification.

        .PARAMETER UniqueIdentifier
        Optional string grouping related notifications; allows newer notifications to overwrite older.

        .PARAMETER DataBinding
        Hashtable. Associates string values with binding variables to allow updating toasts by data.

        .PARAMETER ExpirationTime
        DateTime. After which the notification is removed from the Action Center.

        .PARAMETER SuppressPopup
        Switch. If set, the toast is sent to Action Center but not displayed as a popup.

        .PARAMETER CustomTimestamp
        DateTime. Custom timestamp used for Action Center sorting.

        .PARAMETER ActivatedAction
        Script block to invoke when the toast is activated (clicked).

        .PARAMETER DismissedAction
        Script block to invoke when the toast is dismissed by the user.

        .PARAMETER EventDataVariable
        The name of the global variable that will contain event data for use in event handler script blocks.

        .PARAMETER Urgent
        If set, designates the toast as an "Important Notification" (scenario 'urgent'), allowing it to break through Focus Assist.

        .INPUTS
        None. You cannot pipe input to this function.

        .OUTPUTS
        None. New-BurntToastNotification displays the toast, it does not return an object.

        .EXAMPLE
        New-BurntToastNotification
        Shows a toast with all default values.

        .EXAMPLE
        New-BurntToastNotification -Text 'Example', 'Details about the operation.'
        Shows a toast with custom title and body text.

        .EXAMPLE
        $btn = New-BTButton -Content 'Google' -Arguments 'https://google.com'
        New-BurntToastNotification -Text 'New Blog!' -Button $btn
        Displays a toast with a button that opens Google.

        .EXAMPLE
        $header = New-BTHeader -Id '001' -Title 'Updates'
        New-BurntToastNotification -Text 'Major Update Available!' -Header $header
        Creates a categorized notification under the 'Updates' header.

        .EXAMPLE
        New-BurntToastNotification -Text 'Integration Complete' -Attribution 'Powered by BurntToast'
        Displays a notification with attribution at the bottom.

        .LINK
        https://github.com/Windos/BurntToast/blob/main/Help/New-BurntToastNotification.md
    #>

    [Alias('Toast')]
    [CmdletBinding(DefaultParameterSetName = 'Sound',
                   SupportsShouldProcess = $true,
                   HelpUri = 'https://github.com/Windos/BurntToast/blob/main/Help/New-BurntToastNotification.md')]
    param (
        [ValidateCount(0, 3)]
        [String[]] $Text = 'Default Notification',

        [Microsoft.Toolkit.Uwp.Notifications.AdaptiveSubgroup[]] $Column,

        [String] $AppLogo,

        [String] $HeroImage,

        [String] $Attribution,

        [Parameter(ParameterSetName = 'Sound')]
        [Parameter(Mandatory = $true,
                   ParameterSetName = 'Sound-SnD')]
        [Parameter(Mandatory = $true,
                   ParameterSetName = 'Sound-Button')]
        [ValidateSet('Default',
                     'IM',
                     'Mail',
                     'Reminder',
                     'SMS',
                     'Alarm',
                     'Alarm2',
                     'Alarm3',
                     'Alarm4',
                     'Alarm5',
                     'Alarm6',
                     'Alarm7',
                     'Alarm8',
                     'Alarm9',
                     'Alarm10',
                     'Call',
                     'Call2',
                     'Call3',
                     'Call4',
                     'Call5',
                     'Call6',
                     'Call7',
                     'Call8',
                     'Call9',
                     'Call10')]
        [String] $Sound = 'Default',

        [Parameter(Mandatory = $true,
                   ParameterSetName = 'Silent')]
        [Parameter(Mandatory = $true,
                   ParameterSetName = 'Silent-SnD')]
        [Parameter(Mandatory = $true,
                   ParameterSetName = 'Silent-Button')]
        [Switch] $Silent,

        [Parameter(Mandatory = $true,
                   ParameterSetName = 'SnD')]
        [Parameter(Mandatory = $true,
                   ParameterSetName = 'Silent-SnD')]
        [Parameter(Mandatory = $true,
                   ParameterSetName = 'Sound-SnD')]
        [Switch] $SnoozeAndDismiss,

        [Parameter(Mandatory = $true,
                   ParameterSetName = 'Button')]
        [Parameter(Mandatory = $true,
                   ParameterSetName = 'Silent-Button')]
        [Parameter(Mandatory = $true,
                   ParameterSetName = 'Sound-Button')]
        [Microsoft.Toolkit.Uwp.Notifications.IToastButton[]] $Button,

        [Microsoft.Toolkit.Uwp.Notifications.ToastHeader] $Header,

        [Microsoft.Toolkit.Uwp.Notifications.AdaptiveProgressBar[]] $ProgressBar,

        [string] $UniqueIdentifier,

        [hashtable] $DataBinding,

        [datetime] $ExpirationTime,

        [switch] $SuppressPopup,

        [datetime] $CustomTimestamp,

        [scriptblock] $ActivatedAction,

        [scriptblock] $DismissedAction,

        [string] $EventDataVariable,

        [switch] $Urgent
    )

    $ChildObjects = @()

    foreach ($Txt in $Text) {
        $ChildObjects += New-BTText -Text $Txt -WhatIf:$false
    }

    if ($ProgressBar) {
        foreach ($Bar in $ProgressBar) {
            $ChildObjects += $Bar
        }
    }

    if ($AppLogo) {
        $AppLogoImage = New-BTImage -Source $AppLogo -AppLogoOverride -Crop Circle -WhatIf:$false
    } else {
        $AppLogoImage = New-BTImage -AppLogoOverride -Crop Circle -WhatIf:$false
    }

    if ($Silent) {
        $Audio = New-BTAudio -Silent -WhatIf:$false
    } else {
        if ($Sound -ne 'Default') {
            if ($Sound -like 'Alarm*' -or $Sound -like 'Call*') {
                $Audio = New-BTAudio -Source "ms-winsoundevent:Notification.Looping.$Sound" -Loop -WhatIf:$false
                $Long = $True
            } else {
                $Audio = New-BTAudio -Source "ms-winsoundevent:Notification.$Sound" -WhatIf:$false
            }
        }
    }

    $BindingSplat = @{
        Children        = $ChildObjects
        AppLogoOverride = $AppLogoImage
        WhatIf          = $false
    }

    if ($Attribution) {
        $BindingSplat['Attribution'] = $Attribution
    }

    if ($HeroImage) {
        $BTImageHero = New-BTImage -Source $HeroImage -HeroImage -WhatIf:$false
        $BindingSplat['HeroImage'] = $BTImageHero
    }

    if ($Column) {
        $BindingSplat['Column'] = $Column
    }

    $Binding = New-BTBinding @BindingSplat
    $Visual = New-BTVisual -BindingGeneric $Binding -WhatIf:$false

    $ContentSplat = @{
        'Audio'  = $Audio
        'Visual' = $Visual
    }

    if ($Long) {
        $ContentSplat.Add('Duration', [Microsoft.Toolkit.Uwp.Notifications.ToastDuration]::Long)
    }

    if ($SnoozeAndDismiss) {
        $ContentSplat.Add('Actions', (New-BTAction -SnoozeAndDismiss -WhatIf:$false))
    } elseif ($Button) {
        $ContentSplat.Add('Actions', (New-BTAction -Buttons $Button -WhatIf:$false))
    }

    if ($Header) {
        $ContentSplat.Add('Header', $Header)
    }

    if ($CustomTimestamp) {
        $ContentSplat.Add('CustomTimestamp', $CustomTimestamp)
    }

    $Content = New-BTContent @ContentSplat -WhatIf:$false

    $ToastSplat = @{
        Content = $Content
    }

    if ($UniqueIdentifier) {
        $ToastSplat.Add('UniqueIdentifier', $UniqueIdentifier)
    }

    if ($ExpirationTime) {
        $ToastSplat.Add('ExpirationTime', $ExpirationTime)
    }

    if ($SuppressPopup.IsPresent) {
        $ToastSplat.Add('SuppressPopup', $true)
    }

    if ($DataBinding) {
        $ToastSplat.Add('DataBinding', $DataBinding)
    }

    # Toast events may not be supported, this check happens inside Submit-BTNotification
    if ($ActivatedAction) {
        $ToastSplat.Add('ActivatedAction', $ActivatedAction)
    }

    if ($DismissedAction) {
        $ToastSplat.Add('DismissedAction', $DismissedAction)
    }

    if ($EventDataVariable) {
        $ToastSplat.Add('EventDataVariable', $EventDataVariable)
    }

    if ($Urgent) {
        $ToastSplat.Add('Urgent', $true)
    }

    if ($PSCmdlet.ShouldProcess( "submitting: $($Content.GetContent())" )) {
        Submit-BTNotification @ToastSplat
    }
}
function Remove-BTNotification {
    <#
        .SYNOPSIS
        Removes toast notifications from the Action Center.

        .DESCRIPTION
        The Remove-BTNotification function removes toast notifications for the current application from the Action Center.
        If no parameters are specified, all toast notifications for this app are removed.
        Specify Tag and/or Group to remove specific notifications. Use UniqueIdentifier to remove notifications matching both tag and group.

        .PARAMETER Tag
        The tag of the toast notification(s) to remove (String).

        .PARAMETER Group
        The group (category) of the toast notification(s) to remove (String).

        .PARAMETER UniqueIdentifier
        Used to specify both the Tag and Group and remove a uniquely identified toast.

        .INPUTS
        None. You cannot pipe input to this function.

        .OUTPUTS
        None.

        .EXAMPLE
        Remove-BTNotification
        Removes all toast notifications for the calling application.

        .EXAMPLE
        Remove-BTNotification -Tag 'Toast001'
        Removes the toast notification with tag 'Toast001'.

        .EXAMPLE
        Remove-BTNotification -Group 'Updates'
        Removes all toast notifications in the group 'Updates'.

        .EXAMPLE
        Remove-BTNotification -UniqueIdentifier 'Toast001'
        Removes the toast notification with both tag and group set to 'Toast001'.

        .LINK
        https://github.com/Windos/BurntToast/blob/main/Help/Remove-BTNotification.md
    #>

    [CmdletBinding(DefaultParameterSetName = 'Individual',
                   SupportsShouldProcess = $true,
                   HelpUri = 'https://github.com/Windos/BurntToast/blob/main/Help/Remove-BTNotification.md')]
    param (
        [Parameter(ParameterSetName = 'Individual')]
        [string] $Tag,

        [Parameter(ParameterSetName = 'Individual')]
        [string] $Group,

        [Parameter(Mandatory = $true,
                   ParameterSetName = 'Combo')]
        [string] $UniqueIdentifier
    )

    if ($UniqueIdentifier) {
        if($PSCmdlet.ShouldProcess("Tag: $UniqueIdentifier, Group: $UniqueIdentifier", 'Selectively removing notifications')) {
            [Microsoft.Toolkit.Uwp.Notifications.ToastNotificationManagerCompat]::History.Remove($UniqueIdentifier, $UniqueIdentifier)
        }
    }

    if ($Tag -and $Group) {
        if($PSCmdlet.ShouldProcess("Tag: $Tag, Group: $Group", 'Selectively removing notifications')) {
            [Microsoft.Toolkit.Uwp.Notifications.ToastNotificationManagerCompat]::History.Remove($Tag, $Group)
        }
    } elseif ($Tag) {
        if($PSCmdlet.ShouldProcess("Tag: $Tag", 'Selectively removing notifications')) {
            [Microsoft.Toolkit.Uwp.Notifications.ToastNotificationManagerCompat]::History.Remove($Tag)
        }
    } elseif ($Group) {
        if($PSCmdlet.ShouldProcess("Group: $Group", 'Selectively removing notifications')) {
            [Microsoft.Toolkit.Uwp.Notifications.ToastNotificationManagerCompat]::History.RemoveGroup($Group)
        }
    } else {
        if($PSCmdlet.ShouldProcess("All", 'Clearing all notifications')) {
            [Microsoft.Toolkit.Uwp.Notifications.ToastNotificationManagerCompat]::History.Clear()
        }
    }
}
function Submit-BTNotification {
    <#
        .SYNOPSIS
        Submits a completed toast notification for display.

        .DESCRIPTION
        The Submit-BTNotification function submits a completed toast notification to the operating system's notification manager for display.
        This function supports advanced scenarios such as event callbacks for user actions or toast dismissal, sequence numbering to ensure correct update order, unique identification for toast replacement, expiration control, and direct Action Center delivery.
        Supports colored action buttons: when a button generated via New-BTButton includes the -Color parameter
        ('Green' or 'Red'), the notification will style those buttons as "Success" (green) or "Critical" (red)
        to visually distinguish positive or destructive actions where supported.

        When an action ScriptBlock is supplied (Activated, Dismissed, or Failed), a normalized SHA256 hash of its content is used to generate a unique SourceIdentifier for event registration.
        This prevents duplicate handler registration for the same ScriptBlock, warning if a duplicate registration is attempted.

        If the -ReturnEventData switch is used and any event action scriptblocks are supplied (ActivatedAction, DismissedAction, FailedAction),
        the $Event automatic variable from the event will be assigned to $global:ToastEvent before invoking your script block.
        You can override the variable name used for event data by specifying -EventDataVariable. If supplied, the event data will be assigned to the chosen global variable in your event handler (e.g., -EventDataVariable 'CustomEvent' results in $global:CustomEvent).
        Specifying -EventDataVariable implicitly enables the behavior of -ReturnEventData.

        .PARAMETER Content
        A ToastContent object to display, such as returned by New-BTContent. The content defines the visual and data parts of the toast.

        .PARAMETER SequenceNumber
        A number that sequences this notification's version. When updating a toast, a higher sequence number ensures the most recent notification is displayed, and older ones are not resurrected if received out-of-order.

        .PARAMETER UniqueIdentifier
        A string that uniquely identifies the toast notification. Submitting a new toast with the same identifier as a previous toast replaces the previous notification. Useful for updating or overwriting the same toast notification (e.g., for progress).

        .PARAMETER DataBinding
        Hashtable mapping strings to binding keys in a toast notification. Enables advanced updating scenarios; the original toast must include the relevant databinding keys to be updateable.

        .PARAMETER ExpirationTime
        A [datetime] specifying when the notification is no longer relevant and should be removed from the Action Center.

        .PARAMETER SuppressPopup
        If set, the notification is delivered directly to the Action Center (bypasses immediate display as a popup/toast notification).

        .PARAMETER ActivatedAction
        A script block executed if the user activates/clicks the toast notification.

        .PARAMETER DismissedAction
        A script block executed if the user dismisses the toast notification.

        .PARAMETER FailedAction
        A script block executed if the notification fails to display properly.

        .PARAMETER ReturnEventData
        If set, the $Event variable from notification activation/dismissal is made available as $global:ToastEvent within event action script blocks.

        .PARAMETER EventDataVariable
        If specified, assigns the $Event variable from notification callbacks to this global variable name (e.g., -EventDataVariable MyVar gives $global:MyVar in handlers). Implies ReturnEventData.

        .PARAMETER Urgent
        If set, designates the toast as an "Important Notification" (scenario 'urgent') which can break through Focus Assist, ensuring the notification is delivered even when user focus mode is enabled.

        .INPUTS
        None. You cannot pipe input to this function.

        .OUTPUTS
        None. This function submits a toast but returns no objects.

        .EXAMPLE
        Submit-BTNotification -Content $Toast1 -UniqueIdentifier 'Toast001'
        Submits the toast content object $Toast1 and tags it with a unique identifier so it can be replaced or updated.

        .LINK
        https://github.com/Windos/BurntToast/blob/main/Help/Submit-BTNotification.md
    #>

    [CmdletBinding(SupportsShouldProcess = $true,
                   HelpUri = 'https://github.com/Windos/BurntToast/blob/main/Help/Submit-BTNotification.md')]
    param (
        [Microsoft.Toolkit.Uwp.Notifications.ToastContent] $Content,
        [uint64] $SequenceNumber,
        [string] $UniqueIdentifier,
        [hashtable] $DataBinding,
        [datetime] $ExpirationTime,
        [switch] $SuppressPopup,
        [switch] $Urgent,
        [scriptblock] $ActivatedAction,
        [scriptblock] $DismissedAction,
        [scriptblock] $FailedAction,
        [switch] $ReturnEventData,
        [string] $EventDataVariable = 'ToastEvent'
    )

    if (-not $IsWindows) {
        $null = [Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime]
    }

    $ToastXml = [Windows.Data.Xml.Dom.XmlDocument]::new()

    $ToastXmlContent = $Content.GetContent()

    if (-not $DataBinding) {
        $ToastXmlContent = $ToastXmlContent -replace '<text(.*?)>{', '<text$1>'
        $ToastXmlContent = $ToastXmlContent.Replace('}</text>', '</text>')
        $ToastXmlContent = $ToastXmlContent.Replace('="{', '="')
        $ToastXmlContent = $ToastXmlContent.Replace('}" ', '" ')
    }

    $ToastXml.LoadXml($ToastXmlContent)

    if ($Urgent) {
        try {$ToastXml.GetElementsByTagName('toast')[0].SetAttribute('scenario', 'urgent')} catch {}
    }

    if ($ToastXml.GetElementsByTagName('toast')[0].GetAttribute('scenario') -eq 'incomingCall') {
        foreach ($BindingElement in $ToastXml.GetElementsByTagName('binding')[0].ChildNodes) {
            if ($BindingElement.TagName -eq 'text') {
                $BindingElement.SetAttribute('hint-callScenarioCenterAlign', 'true')
            }
        }
    }

    if ($ToastXml.GetXml() -match 'hint-actionId="(Red|Green)"') {
        try {$ToastXml.GetElementsByTagName('toast').SetAttribute('useButtonStyle', 'true')} catch {}

        foreach ($ActionElement in $ToastXml.GetElementsByTagName('actions')[0].ChildNodes) {
            if ($ActionElement.GetAttribute('hint-actionId') -eq 'Red') {
                $ActionElement.SetAttribute('hint-buttonStyle', 'Critical')
            }
            if ($ActionElement.GetAttribute('hint-actionId') -eq 'Green') {
                $ActionElement.SetAttribute('hint-buttonStyle', 'Success')
            }
        }
    }

    $Toast = [Windows.UI.Notifications.ToastNotification]::new($ToastXml)

    if ($DataBinding) {
        $DataDictionary = New-Object 'system.collections.generic.dictionary[string,string]'

        if ($DataBinding) {
            foreach ($Key in $DataBinding.Keys) {
                $DataDictionary.Add($Key, $DataBinding.$Key)
            }
        }

        foreach ($Child in $Content.Visual.BindingGeneric.Children) {
            if ($Child.GetType().Name -eq 'AdaptiveText') {
                $BindingName = $Child.Text.BindingName

                if (!$DataDictionary.ContainsKey($BindingName)) {
                    $DataDictionary.Add($BindingName, $BindingName)
                }
            } elseif ($Child.GetType().Name -eq 'AdaptiveProgressBar') {
                if ($Child.Title) {
                    $BindingName = $Child.Title.BindingName

                    if (!$DataDictionary.ContainsKey($BindingName)) {
                        $DataDictionary.Add($BindingName, $BindingName)
                    }
                }

                if ($Child.Value) {
                    $BindingName = $Child.Value.BindingName

                    if (!$DataDictionary.ContainsKey($BindingName)) {
                        $DataDictionary.Add($BindingName, $BindingName)
                    }
                }

                if ($Child.ValueStringOverride) {
                    $BindingName = $Child.ValueStringOverride.BindingName

                    if (!$DataDictionary.ContainsKey($BindingName)) {
                        $DataDictionary.Add($BindingName, $BindingName)
                    }
                }

                if ($Child.Status) {
                    $BindingName = $Child.Status.BindingName

                    if (!$DataDictionary.ContainsKey($BindingName)) {
                        $DataDictionary.Add($BindingName, $BindingName)
                    }
                }
            }
        }

        $Toast.Data = [Windows.UI.Notifications.NotificationData]::new($DataDictionary)
    }

    if ($UniqueIdentifier) {
        $Toast.Group = $UniqueIdentifier
        $Toast.Tag = $UniqueIdentifier
    }

    if ($ExpirationTime) {
        $Toast.ExpirationTime = $ExpirationTime
    }

    if ($SuppressPopup.IsPresent) {
        $Toast.SuppressPopup = $SuppressPopup
    }

    if ($SequenceNumber) {
        $Toast.Data.SequenceNumber = $SequenceNumber
    }

    $CompatMgr = [Microsoft.Toolkit.Uwp.Notifications.ToastNotificationManagerCompat]

    if ($ActivatedAction -or $DismissedAction -or $FailedAction) {
        $Action_Activated = $ActivatedAction
        $Action_Dismissed = $DismissedAction
        $Action_Failed = $FailedAction

        if ($ReturnEventData -or $EventDataVariable -ne 'ToastEvent') {
            $EventReturn = '$global:{0} = $Event' -f $EventDataVariable
            if ($ActivatedAction) {
                $Action_Activated = [ScriptBlock]::Create($EventReturn + "`n" + $Action_Activated.ToString())
            }
            if ($DismissedAction) {
                $Action_Dismissed = [ScriptBlock]::Create($EventReturn + "`n" + $Action_Dismissed.ToString())
            }
            if ($FailedAction) {
                $Action_Failed = [ScriptBlock]::Create($EventReturn + "`n" + $Action_Failed.ToString())
            }
        }

        if ($Action_Activated) {
            try {
                $ActivatedHash = Get-BTScriptBlockHash $Action_Activated
                $activatedParams = @{
                    InputObject      = $CompatMgr
                    EventName        = 'OnActivated'
                    Action           = $Action_Activated
                    SourceIdentifier = "BT_Activated_$ActivatedHash"
                    ErrorAction      = 'Stop'
                }
                Register-ObjectEvent @activatedParams | Out-Null
            } catch {
                Write-Warning "Duplicate or conflicting OnActivated ScriptBlock event detected: Activation action not registered. $_"
            }
            <#
                EDGE CASES / NOTES
                - Hash collisions: In the rare event that two different ScriptBlocks normalize to the same text, they will share a SourceIdentifier and not both be registered.
                - Only ScriptBlocks are handled: if a non-ScriptBlock is supplied where an action is expected, registration will fail.
                - Actions with dynamic or closure content: If `ToString()` outputs identical strings for two blocks with different closure state, only one event will register.
                - User warnings: Any error during event registration (including duplicate) triggers a user-facing warning instead of otherwise disrupting notification flow.
            #>
        }
        if ($Action_Dismissed -or $Action_Failed) {
            if ($Script:ActionsSupported) {
                if ($Action_Dismissed) {
                    try {
                        $DismissedHash = Get-BTScriptBlockHash $Action_Dismissed
                        $dismissedParams = @{
                            InputObject      = $Toast
                            EventName        = 'Dismissed'
                            Action           = $Action_Dismissed
                            SourceIdentifier = "BT_Dismissed_$DismissedHash"
                            ErrorAction      = 'Stop'
                        }
                        Register-ObjectEvent @dismissedParams | Out-Null
                    } catch {
                        Write-Warning "Duplicate or conflicting Dismissed ScriptBlock event detected: Dismissed action not registered. $_"
                    }
                }
                if ($Action_Failed) {
                    try {
                        $FailedHash = Get-BTScriptBlockHash $Action_Failed
                        $failedParams = @{
                            InputObject      = $Toast
                            EventName        = 'Failed'
                            Action           = $Action_Failed
                            SourceIdentifier = "BT_Failed_$FailedHash"
                            ErrorAction      = 'Stop'
                        }
                        Register-ObjectEvent @failedParams | Out-Null
                    } catch {
                        Write-Warning "Duplicate or conflicting Failed ScriptBlock event detected: Failed action not registered. $_"
                    }
                }
            } else {
                Write-Warning $Script:UnsupportedEvents
            }
        }
    }

    if($PSCmdlet.ShouldProcess( "submitting: [$($Toast.GetType().Name)] with Id $UniqueIdentifier, Sequence Number $($Toast.Data.SequenceNumber) and XML: $($Content.GetContent())")) {
        $CompatMgr::CreateToastNotifier().Show($Toast)
    }
}
function Update-BTNotification {
    <#
        .SYNOPSIS
        Updates an existing toast notification.

        .DESCRIPTION
        The Update-BTNotification function updates a toast notification by matching UniqueIdentifier and replacing or updating its contents/data.
        DataBinding provides the values to update in the notification, and SequenceNumber ensures correct ordering if updates overlap.

        .PARAMETER SequenceNumber
        Used for notification versioning; higher numbers indicate newer content to prevent out-of-order display.

        .PARAMETER UniqueIdentifier
        String uniquely identifying the toast notification to update.

        .PARAMETER DataBinding
        Hashtable containing the data binding keys/values to update.

        .INPUTS
        None. You cannot pipe input to this function.

        .OUTPUTS
        None.

        .EXAMPLE
        $data = @{ Key = 'Value' }
        Update-BTNotification -UniqueIdentifier 'ID001' -DataBinding $data
        Updates notification with key 'ID001' using new data binding values.

        .LINK
        https://github.com/Windos/BurntToast/blob/main/Help/Update-BTNotification.md
    #>

    [CmdletBinding(SupportsShouldProcess = $true,
                   HelpUri = 'https://github.com/Windos/BurntToast/blob/main/Help/Update-BTNotification.md')]
    [CmdletBinding()]
    param (
        [uint64] $SequenceNumber,
        [string] $UniqueIdentifier,
        [hashtable] $DataBinding
    )

    if (-not $IsWindows) {
        $null = [Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime]
    }

    if ($DataBinding) {
        $DataDictionary = New-Object 'system.collections.generic.dictionary[string,string]'

        foreach ($Key in $DataBinding.Keys) {
            $DataDictionary.Add($Key, $DataBinding.$Key)
        }
    }

    $ToastData = [Windows.UI.Notifications.NotificationData]::new($DataDictionary)

    if ($SequenceNumber) {
        $ToastData.SequenceNumber = $SequenceNumber
    }

    if($PSCmdlet.ShouldProcess("UniqueId: $UniqueIdentifier", 'Updating notification')) {
        [Microsoft.Toolkit.Uwp.Notifications.ToastNotificationManagerCompat]::CreateToastNotifier().Update($ToastData, $UniqueIdentifier, $UniqueIdentifier)
    }
}
$PublicFunctions = 'Get-BTHeader', 'Get-BTHistory', 'New-BTAction', 'New-BTAudio', 'New-BTBinding', 'New-BTButton', 'New-BTColumn', 'New-BTContent', 'New-BTContextMenuItem', 'New-BTHeader', 'New-BTImage', 'New-BTInput', 'New-BTProgressBar', 'New-BTSelectionBoxItem', 'New-BTShortcut', 'New-BTText', 'New-BTVisual', 'New-BurntToastNotification', 'Remove-BTNotification', 'Submit-BTNotification', 'Update-BTNotification'

$OSVersion = [System.Environment]::OSVersion.Version

if ($OSVersion.Major -ge 10 -and $null -eq $env:BurntToastPesterNotWindows10) {
    if ($OSVersion.Build -ge 15063 -and $null -eq $env:BurntToastPesterNotAnniversaryUpdate) {
        $Paths = if ($IsWindows) {
            "$PSScriptRoot\lib\Microsoft.Toolkit.Uwp.Notifications\net5.0-windows10.0.17763\*.dll",
            "$PSScriptRoot\lib\Microsoft.Windows.SDK.NET\*.dll"
        } else {
            "$PSScriptRoot\lib\Microsoft.Toolkit.Uwp.Notifications\net461\*.dll"
        }

        $Library = @( Get-ChildItem -Path $Paths -Recurse -ErrorAction SilentlyContinue )

        # Add one class from each expected DLL here:
        $LibraryMap = @{
            'Microsoft.Toolkit.Uwp.Notifications.dll' = 'Microsoft.Toolkit.Uwp.Notifications.ToastContent'
            'Microsoft.Windows.SDK.NET.dll' = 'Windows.UI.Notifications.ToastNotification'
            'WinRT.Runtime.dll' = 'WinRT.WindowsRuntimeTypeAttribute'
        }

        $Script:Config = Get-Content -Path $PSScriptRoot\config.json -ErrorAction SilentlyContinue | ConvertFrom-Json
        $Script:DefaultImage = if ($Script:Config.AppLogo -match '^[.\\]') {
            "$PSScriptRoot$($Script:Config.AppLogo)"
        } else {
            $Script:Config.AppLogo
        }

        foreach ($Type in $Library) {
            try {
                if (-not ($LibraryMap[$Type.Name]  -as [type])) {
                    Add-Type -Path $Type.FullName -ErrorAction Stop
                }
            } catch {
                Write-Error -Message "Failed to load library $($Type.FullName): $_"
            }
        }

        $Script:ActionsSupported = 'System.Management.Automation.SemanticVersion' -as [type] -and
            $PSVersionTable.PSVersion -ge [System.Management.Automation.SemanticVersion] '7.1.0-preview.4'

        $Script:UnsupportedEvents = 'Dismissed and Failed Toast events are only supported on PowerShell 7.1.0 and above. ' +
            'Your notification will still be displayed, but these actions will be ignored.'

        Export-ModuleMember -Alias 'Toast'
        Export-ModuleMember -Function $PublicFunctions

        if (-not $IsWindows) {
            $null = [Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime]
        }
    } else {
        throw 'This version of BurntToast will only work on Windows 10 Creators Update (15063) and above or equivalent Windows Server version. ' +
              'If you would like to use BurntToast on earlier builds, please downgrade to a version of the module below 1.0'
    }
} else {
    throw 'This version of BurntToast will only work on Windows 10 or equivalent Windows Server version. ' +
          'If you would like to use BurntToast on Windows 8, please use version 0.4 of the module'
}
