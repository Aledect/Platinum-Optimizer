@echo off
title By Platinum+ Optimizer

:: Restore Automatic Updates Core
reg delete "HKLM\Software\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /f

:: Restore connection to Windows Update Internet locations
reg delete "HKLM\Software\Policies\Microsoft\Windows\WindowsUpdate" /v "DoNotConnectToWindowsUpdateInternetLocations" /f

:: Restore drivers in Windows Quality Updates
reg delete "HKLM\Software\Policies\Microsoft\Windows\WindowsUpdate" /v "ExcludeWUDriversInQualityUpdate" /f

:: Restore search order for device driver source locations
reg delete "HKLM\Software\Policies\Microsoft\Windows\DriverSearching" /v "SearchOrderConfig" /f

:: Restore Windows Update device driver searching
reg delete "HKLM\Software\Policies\Microsoft\Windows\DriverSearching" /v "DontSearchWindowsUpdate" /f

:: Restore automatic download of applications associated with device metadata
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Device Metadata" /v "PreventDeviceMetadataFromNetwork" /f

:: Restore Automatic Root Certificates Update
reg delete "HKLM\Software\Policies\Microsoft\SystemCertificates\AuthRoot" /v "DisableRootAutoUpdate" /f

:: Restore Automatic Download and Install of updates (Windows Store)
reg delete "HKLM\Software\Policies\Microsoft\WindowsStore" /v "AutoDownload" /f

:: Restore access to use all Windows Update features (UI)
reg delete "HKLM\Software\Policies\Microsoft\Windows\WindowsUpdate" /v "SetDisableUXWUAccess" /f

:: Restore access to "Pause updates" feature
reg delete "HKLM\Software\Policies\Microsoft\Windows\WindowsUpdate" /v "SetDisablePauseUXAccess" /f

:: Restore preview builds management
reg delete "HKLM\Software\Policies\Microsoft\Windows\WindowsUpdate" /v "ManagePreviewBuilds" /f
reg delete "HKLM\Software\Policies\Microsoft\Windows\WindowsUpdate" /v "BranchReadinessLevel" /f

:: Restore file shares for downloading security intelligence updates
reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates" /v "DefinitionUpdateFileSharesSources" /f
reg delete "HKLM\Software\Policies\Microsoft\Windows Defender\Signature Updates" /v "FallbackOrder" /f

echo Restore Windows Update applied successfully.
