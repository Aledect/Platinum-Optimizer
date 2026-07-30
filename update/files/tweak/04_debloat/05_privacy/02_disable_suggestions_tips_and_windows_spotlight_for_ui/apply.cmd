@echo off
title By Platinum+ Optimizer

:: Disable SubscribedContent IDs across all loaded user profiles
for /f "tokens=*" %%u in ('reg query "HKU" ^| findstr /V "_Classes"') do (
    :: LockScreen
    reg add "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338380Enabled" /t REG_DWORD /d 0 /f
    reg add "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338387Enabled" /t REG_DWORD /d 0 /f
    :: WindowsTip
    reg add "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338382Enabled" /t REG_DWORD /d 0 /f
    reg add "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338389Enabled" /t REG_DWORD /d 0 /f
    :: StartSuggestions
    reg add "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338381Enabled" /t REG_DWORD /d 0 /f
    reg add "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /t REG_DWORD /d 0 /f
    :: Settings
    reg add "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338386Enabled" /t REG_DWORD /d 0 /f
    reg add "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338393Enabled" /t REG_DWORD /d 0 /f
    :: SettingsHome
    reg add "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353697Enabled" /t REG_DWORD /d 0 /f
    reg add "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353696Enabled" /t REG_DWORD /d 0 /f
    :: SettingsAccountsYourInfo
    reg add "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353695Enabled" /t REG_DWORD /d 0 /f
    reg add "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353694Enabled" /t REG_DWORD /d 0 /f
    :: SettingsValueBanner
    reg add "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-88000106Enabled" /t REG_DWORD /d 0 /f
    reg add "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-88000105Enabled" /t REG_DWORD /d 0 /f
    :: OobeOffers
    reg add "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-314566Enabled" /t REG_DWORD /d 0 /f
    reg add "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-314567Enabled" /t REG_DWORD /d 0 /f
    :: MinuteZeroOffers
    reg add "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-310094Enabled" /t REG_DWORD /d 0 /f
    reg add "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-310093Enabled" /t REG_DWORD /d 0 /f
    :: ApiTest
    reg add "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-280812Enabled" /t REG_DWORD /d 0 /f
    :: ActionCenter
    reg add "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-310092Enabled" /t REG_DWORD /d 0 /f
    reg add "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-310091Enabled" /t REG_DWORD /d 0 /f
    :: ShareAppSuggestions
    reg add "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-280814Enabled" /t REG_DWORD /d 0 /f
    reg add "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-280815Enabled" /t REG_DWORD /d 0 /f
    :: SilentInstalledApps
    reg add "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-202913Enabled" /t REG_DWORD /d 0 /f
    reg add "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-202914Enabled" /t REG_DWORD /d 0 /f
    :: PeopleAppSuggestions
    reg add "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-314562Enabled" /t REG_DWORD /d 0 /f
    reg add "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-314563Enabled" /t REG_DWORD /d 0 /f
    :: DynamicLayouts
    reg add "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-314558Enabled" /t REG_DWORD /d 0 /f
    reg add "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-314559Enabled" /t REG_DWORD /d 0 /f
    :: DynamicLayoutsSV
    reg add "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-88000531Enabled" /t REG_DWORD /d 0 /f
    reg add "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-88000530Enabled" /t REG_DWORD /d 0 /f
    :: Timeline
    reg add "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353699Enabled" /t REG_DWORD /d 0 /f
    reg add "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353698Enabled" /t REG_DWORD /d 0 /f
    :: AppDefaultsEdgeEnlightenment
    reg add "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-88000044Enabled" /t REG_DWORD /d 0 /f
    reg add "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-88000045Enabled" /t REG_DWORD /d 0 /f
    :: OneDriveLocal
    reg add "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-280797Enabled" /t REG_DWORD /d 0 /f
    reg add "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-280811Enabled" /t REG_DWORD /d 0 /f
    :: OneDriveSync
    reg add "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-280817Enabled" /t REG_DWORD /d 0 /f
    reg add "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-280810Enabled" /t REG_DWORD /d 0 /f
    :: OneDriveDocuments
    reg add "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-88000162Enabled" /t REG_DWORD /d 0 /f
    reg add "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-88000161Enabled" /t REG_DWORD /d 0 /f
    :: OneDriveDesktop
    reg add "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-88000164Enabled" /t REG_DWORD /d 0 /f
    reg add "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-88000163Enabled" /t REG_DWORD /d 0 /f
    :: OneDrivePictures
    reg add "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-88000166Enabled" /t REG_DWORD /d 0 /f
    reg add "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-88000165Enabled" /t REG_DWORD /d 0 /f

    :: HKCU Windows Policies
    reg add "%%u\Software\Policies\Microsoft\Windows\CloudContent" /v "Do not suggest third-party content in Windows spotlight" /t REG_DWORD /d 1 /f
    reg add "%%u\Software\Policies\Microsoft\Windows\Explorer" /v "Remove Recommended section from Start Menu" /t REG_DWORD /d 1 /f
    reg add "%%u\Software\Policies\Microsoft\Windows\Explorer" /v "Remove Personalized Website Recommendations from the Recommended section in the Start Menu" /t REG_DWORD /d 1 /f
    reg add "%%u\Software\Policies\Microsoft\Windows\Explorer" /v "Turn off display of recent search entries in the File Explorer search box" /t REG_DWORD /d 1 /f
    reg add "%%u\Software\Policies\Microsoft\Windows\CloudContent" /v "Configure Windows spotlight on lock screen" /t REG_DWORD /d 0 /f
    reg add "%%u\Software\Policies\Microsoft\Windows\CloudContent" /v "Turn off all Windows spotlight features" /t REG_DWORD /d 1 /f
    reg add "%%u\Software\Policies\Microsoft\Windows\CloudContent" /v "Turn off Spotlight collection on Desktop" /t REG_DWORD /d 1 /f
    reg add "%%u\Software\Policies\Microsoft\Windows\CloudContent" /v "Turn off Windows Spotlight on Action Center" /t REG_DWORD /d 1 /f
    reg add "%%u\Software\Policies\Microsoft\Windows\CloudContent" /v "Turn off Windows Spotlight on Settings" /t REG_DWORD /d 1 /f
    reg add "%%u\Software\Policies\Microsoft\Windows\CloudContent" /v "Turn off the Windows Welcome Experience" /t REG_DWORD /d 1 /f
)

:: HKLM Windows Policies
reg add "HKLM\Software\Policies\Microsoft\Windows\CloudContent" /v "Turn off Microsoft consumer experiences" /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Policies\Microsoft\Windows\CloudContent" /v "Turn off cloud optimized content" /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Policies\Microsoft\Windows\CloudContent" /v "Turn off cloud consumer account state content" /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Policies\Microsoft\Windows\CloudContent" /v "Do not show Windows tips" /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "Allow Online Tips" /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Policies\Microsoft\Windows\Explorer" /v "Remove Recommended section from Start Menu" /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Policies\Microsoft\Windows\Explorer" /v "Remove Personalized Website Recommendations from the Recommended section in the Start Menu" /t REG_DWORD /d 1 /f

echo Disable Suggestions, Tips, and Windows Spotlight applied successfully.
