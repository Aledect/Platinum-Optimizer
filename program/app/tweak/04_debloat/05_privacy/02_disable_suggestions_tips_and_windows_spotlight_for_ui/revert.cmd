@echo off
title By Platinum+ Optimizer

:: Restore SubscribedContent IDs across all loaded user profiles
for /f "tokens=*" %%u in ('reg query "HKU" ^| findstr /V "_Classes"') do (
    :: Delete all injected keys
    reg delete "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338380Enabled" /f >nul 2>&1
    reg delete "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338387Enabled" /f >nul 2>&1
    reg delete "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338382Enabled" /f >nul 2>&1
    reg delete "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338381Enabled" /f >nul 2>&1
    reg delete "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338388Enabled" /f >nul 2>&1
    reg delete "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338386Enabled" /f >nul 2>&1
    reg delete "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338393Enabled" /f >nul 2>&1
    reg delete "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353697Enabled" /f >nul 2>&1
    reg delete "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353696Enabled" /f >nul 2>&1
    reg delete "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353695Enabled" /f >nul 2>&1
    reg delete "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353694Enabled" /f >nul 2>&1
    reg delete "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-88000106Enabled" /f >nul 2>&1
    reg delete "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-88000105Enabled" /f >nul 2>&1
    reg delete "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-314566Enabled" /f >nul 2>&1
    reg delete "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-314567Enabled" /f >nul 2>&1
    reg delete "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-310094Enabled" /f >nul 2>&1
    reg delete "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-310093Enabled" /f >nul 2>&1
    reg delete "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-280812Enabled" /f >nul 2>&1
    reg delete "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-310092Enabled" /f >nul 2>&1
    reg delete "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-310091Enabled" /f >nul 2>&1
    reg delete "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-280814Enabled" /f >nul 2>&1
    reg delete "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-280815Enabled" /f >nul 2>&1
    reg delete "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-202913Enabled" /f >nul 2>&1
    reg delete "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-202914Enabled" /f >nul 2>&1
    reg delete "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-314562Enabled" /f >nul 2>&1
    reg delete "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-314563Enabled" /f >nul 2>&1
    reg delete "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-314558Enabled" /f >nul 2>&1
    reg delete "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-314559Enabled" /f >nul 2>&1
    reg delete "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-88000531Enabled" /f >nul 2>&1
    reg delete "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-88000530Enabled" /f >nul 2>&1
    reg delete "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353699Enabled" /f >nul 2>&1
    reg delete "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-353698Enabled" /f >nul 2>&1
    reg delete "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-88000044Enabled" /f >nul 2>&1
    reg delete "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-88000045Enabled" /f >nul 2>&1
    reg delete "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-280797Enabled" /f >nul 2>&1
    reg delete "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-280811Enabled" /f >nul 2>&1
    reg delete "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-280817Enabled" /f >nul 2>&1
    reg delete "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-280810Enabled" /f >nul 2>&1
    reg delete "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-88000162Enabled" /f >nul 2>&1
    reg delete "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-88000161Enabled" /f >nul 2>&1
    reg delete "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-88000164Enabled" /f >nul 2>&1
    reg delete "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-88000163Enabled" /f >nul 2>&1
    reg delete "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-88000166Enabled" /f >nul 2>&1
    reg delete "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-88000165Enabled" /f >nul 2>&1

    :: Restore the only default value
    reg add "%%u\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SubscribedContent-338389Enabled" /t REG_DWORD /d 1 /f

    :: Restore HKCU Windows Policies
    reg delete "%%u\Software\Policies\Microsoft\Windows\CloudContent" /v "Do not suggest third-party content in Windows spotlight" /f >nul 2>&1
    reg delete "%%u\Software\Policies\Microsoft\Windows\Explorer" /v "Remove Recommended section from Start Menu" /f >nul 2>&1
    reg delete "%%u\Software\Policies\Microsoft\Windows\Explorer" /v "Remove Personalized Website Recommendations from the Recommended section in the Start Menu" /f >nul 2>&1
    reg delete "%%u\Software\Policies\Microsoft\Windows\Explorer" /v "Turn off display of recent search entries in the File Explorer search box" /f >nul 2>&1
    reg delete "%%u\Software\Policies\Microsoft\Windows\CloudContent" /v "Configure Windows spotlight on lock screen" /f >nul 2>&1
    reg delete "%%u\Software\Policies\Microsoft\Windows\CloudContent" /v "Turn off all Windows spotlight features" /f >nul 2>&1
    reg delete "%%u\Software\Policies\Microsoft\Windows\CloudContent" /v "Turn off Spotlight collection on Desktop" /f >nul 2>&1
    reg delete "%%u\Software\Policies\Microsoft\Windows\CloudContent" /v "Turn off Windows Spotlight on Action Center" /f >nul 2>&1
    reg delete "%%u\Software\Policies\Microsoft\Windows\CloudContent" /v "Turn off Windows Spotlight on Settings" /f >nul 2>&1
    reg delete "%%u\Software\Policies\Microsoft\Windows\CloudContent" /v "Turn off the Windows Welcome Experience" /f >nul 2>&1
)

:: Restore HKLM Windows Policies
reg delete "HKLM\Software\Policies\Microsoft\Windows\CloudContent" /v "Turn off Microsoft consumer experiences" /f >nul 2>&1
reg delete "HKLM\Software\Policies\Microsoft\Windows\CloudContent" /v "Turn off cloud optimized content" /f >nul 2>&1
reg delete "HKLM\Software\Policies\Microsoft\Windows\CloudContent" /v "Turn off cloud consumer account state content" /f >nul 2>&1
reg delete "HKLM\Software\Policies\Microsoft\Windows\CloudContent" /v "Do not show Windows tips" /f >nul 2>&1
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "Allow Online Tips" /f >nul 2>&1
reg delete "HKLM\Software\Policies\Microsoft\Windows\Explorer" /v "Remove Recommended section from Start Menu" /f >nul 2>&1
reg delete "HKLM\Software\Policies\Microsoft\Windows\Explorer" /v "Remove Personalized Website Recommendations from the Recommended section in the Start Menu" /f >nul 2>&1

echo Restore Suggestions, Tips, and Windows Spotlight applied successfully.
