@echo off
title By Platinum+ Optimizer

:: Disable Automatic Updates Core
reg add "HKLM\Software\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t REG_DWORD /d 1 /f

:: Prevent connection to Windows Update Internet locations
reg add "HKLM\Software\Policies\Microsoft\Windows\WindowsUpdate" /v "DoNotConnectToWindowsUpdateInternetLocations" /t REG_DWORD /d 1 /f

:: Exclude drivers from Windows Quality Updates
reg add "HKLM\Software\Policies\Microsoft\Windows\WindowsUpdate" /v "ExcludeWUDriversInQualityUpdate" /t REG_DWORD /d 1 /f

:: Specify search order for device driver source locations (Do not search Windows Update)
reg add "HKLM\Software\Policies\Microsoft\Windows\DriverSearching" /v "SearchOrderConfig" /t REG_DWORD /d 0 /f

:: Turn off Windows Update device driver searching completely
reg add "HKLM\Software\Policies\Microsoft\Windows\DriverSearching" /v "DontSearchWindowsUpdate" /t REG_DWORD /d 1 /f

:: Prevent automatic download of applications associated with device metadata
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Device Metadata" /v "PreventDeviceMetadataFromNetwork" /t REG_DWORD /d 1 /f

:: Turn off Automatic Root Certificates Update
reg add "HKLM\Software\Policies\Microsoft\SystemCertificates\AuthRoot" /v "DisableRootAutoUpdate" /t REG_DWORD /d 1 /f

:: Turn off Automatic Download and Install of updates (Windows Store)
reg add "HKLM\Software\Policies\Microsoft\WindowsStore" /v "AutoDownload" /t REG_DWORD /d 2 /f

:: Remove access to use all Windows Update features (UI)
reg add "HKLM\Software\Policies\Microsoft\Windows\WindowsUpdate" /v "SetDisableUXWUAccess" /t REG_DWORD /d 1 /f

:: Remove access to "Pause updates" feature
reg add "HKLM\Software\Policies\Microsoft\Windows\WindowsUpdate" /v "SetDisablePauseUXAccess" /t REG_DWORD /d 1 /f

:: Manage preview builds (Disable)
reg add "HKLM\Software\Policies\Microsoft\Windows\WindowsUpdate" /v "ManagePreviewBuilds" /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Policies\Microsoft\Windows\WindowsUpdate" /v "BranchReadinessLevel" /t REG_DWORD /d 16 /f

:: Define file shares for downloading security intelligence updates (Fallback to internal/none)
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates" /v "DefinitionUpdateFileSharesSources" /t REG_SZ /d "" /f
reg add "HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates" /v "FallbackOrder" /t REG_SZ /d "FileShares" /f

echo Disable Windows Update applied successfully.
