@echo off
title By Platinum+ Optimizer

:: Disable Windows Copilot via Policy
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" /v "TurnOffWindowsCopilot" /t REG_DWORD /d 1 /f

:: Disable Copilot Hardware Key via Policy
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\CopilotKey" /v "SetCopilotHardwareKey" /t REG_DWORD /d 0 /f

:: Force Copilot Disabled Reason in Shell
reg add "HKCU\SOFTWARE\Microsoft\Windows\Shell\Copilot" /v "CopilotDisabledReason" /t REG_SZ /d "FeatureIsDisabled" /f

:: Remove Copilot Logon Telemetry
reg delete "HKCU\Software\Microsoft\Windows\Shell\Copilot" /v "CopilotLogonTelemetryTime" /f

:: Disable Copilot Educational Experience in OneDrive
reg add "HKCU\Software\Microsoft\OneDrive\Accounts\Personal" /v "CopilotEducationalExperience" /t REG_DWORD /d 0 /f

:: Disable Copilot Upgrade in Edge
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\EdgeUpdate" /v "CopilotUpgrade" /t REG_DWORD /d 0 /f

:: Prevent Auto-Installation of PWAs (Progressive Web Apps) by Explorer
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\AutoInstalledPWAs" /ve /t REG_DWORD /d 0 /f

:: Disable AI Features in MS Paint (Image Creator, Cocreator, Generative Fill)
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Paint" /v "DisableImageCreator" /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Paint" /v "DisableCocreator" /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Paint" /v "DisableGenerativeFill" /t REG_DWORD /d 1 /f

echo Disable Microsoft Copilot and AI Features applied successfully.
