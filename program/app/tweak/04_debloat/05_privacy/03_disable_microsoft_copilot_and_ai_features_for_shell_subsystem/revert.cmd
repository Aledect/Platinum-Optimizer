@echo off
title By Platinum+ Optimizer

:: Restore Windows Copilot Policy
reg delete "HKCU\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" /v "TurnOffWindowsCopilot" /f

:: Restore Copilot Hardware Key Policy
reg delete "HKCU\SOFTWARE\Policies\Microsoft\Windows\CopilotKey" /v "SetCopilotHardwareKey" /f

:: Remove Copilot Disabled Reason in Shell
reg delete "HKCU\SOFTWARE\Microsoft\Windows\Shell\Copilot" /v "CopilotDisabledReason" /f

:: Restore Copilot Educational Experience in OneDrive (Remove override)
reg delete "HKCU\Software\Microsoft\OneDrive\Accounts\Personal" /v "CopilotEducationalExperience" /f

:: Restore Copilot Upgrade in Edge (Remove override)
reg delete "HKLM\SOFTWARE\WOW6432Node\Microsoft\EdgeUpdate" /v "CopilotUpgrade" /f

:: Restore Auto-Installation of PWAs to Default (1)
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoInstalledPWAs" /ve /t REG_DWORD /d 1 /f

:: Restore AI Features in MS Paint
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Paint" /v "DisableImageCreator" /f
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Paint" /v "DisableCocreator" /f
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Paint" /v "DisableGenerativeFill" /f

echo Restore Microsoft Copilot and AI Features applied successfully.
