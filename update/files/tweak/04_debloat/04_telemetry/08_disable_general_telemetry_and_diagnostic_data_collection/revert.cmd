@echo off
title By Platinum+ Optimizer

:: Restore DiagTrack and Regional Settings
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack" /v "RedirectedRegistryRoot" /f
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack\RegionalSett" /v "IsProcessorMode" /f

:: Restore CurrentVersion DataCollection Policies
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 3 /f
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "MaxTelemetryAllowed" /f
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "CommercialId" /f

:: Restore User subkeys under CurrentVersion DataCollection
for /f "tokens=*" %%a in ('reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\DataCollection\Users" 2^>nul ^| findstr /I "Users\\"') do (
    reg delete "%%a" /v "AllowTelemetry" /f
    reg delete "%%a" /v "AllowTelemetry_PolicyManager" /f
)

:: Restore Core DataCollection Policies
set "DC_POL=HKLM\Software\Policies\Microsoft\Windows\DataCollection"
reg delete "%DC_POL%" /v "AllowTelemetry" /f
reg delete "%DC_POL%" /v "LimitDumpCollection" /f
reg delete "%DC_POL%" /v "LimitEnhancedDiagnosticDataWindowsAnalytics" /f
reg delete "%DC_POL%" /v "DisableTelemetryOptInChangeNotification" /f
reg delete "%DC_POL%" /v "DisableTelemetryOptInSettingsUx" /f
reg delete "%DC_POL%" /v "DisableDeviceDelete" /f
reg delete "%DC_POL%" /v "DisableDiagnosticDataViewer" /f
reg delete "%DC_POL%" /v "AllowCommercialDataPipeline" /f
reg delete "%DC_POL%" /v "LimitDiagnosticLogCollection" /f
reg delete "%DC_POL%" /v "DisableEnterpriseAuthProxy" /f
reg delete "%DC_POL%" /v "AllowDeviceNameInDiagnosticData" /f
reg delete "%DC_POL%" /v "DisableOneSettingsDownloads" /f
reg delete "%DC_POL%" /v "EnableOneSettingsAuditing" /f
reg delete "%DC_POL%" /v "ConfigureMicrosoft365UploadEndpoint" /f
reg delete "%DC_POL%" /v "AllowDeviceNameInTelemetry" /f
reg delete "%DC_POL%" /v "AllowTelemetry_PolicyManager" /f
reg delete "%DC_POL%" /v "CommercialId" /f
reg delete "%DC_POL%" /v "TelemetryProxyServer" /f
reg delete "%DC_POL%" /v "TelemetryProxyServer_PolicyManager" /f

:: Restore Offline Auth Policies
reg delete "HKLM\OFFLINE_AUTH\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack" /v "DiagTrackAuthorization" /f
reg delete "HKLM\OFFLINE_AUTH\Policies\Microsoft\Windows\DataCollection" /v "LimitDumpCollection" /f

:: Restore User-specific Policies across all loaded profiles
for /f "tokens=*" %%u in ('reg query "HKU" ^| findstr /V "_Classes"') do (
    reg delete "%%u\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /f
    reg delete "%%u\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry_PolicyManager" /f
    reg delete "%%u\Software\Policies\Microsoft\Internet Explorer\SQM" /v "Prevent participation in the Customer Experience Improvement Program" /f
)

:: Restore Windows Policies (Placeholders)
reg delete "HKLM\Software\Policies\Microsoft\Windows\AppCompat" /v "Turn off Application Telemetry" /f
reg delete "HKLM\Software\Policies\Microsoft\Windows\AppCompat" /v "Turn off Inventory" /f
reg delete "HKLM\Software\Policies\Microsoft\Windows\AdvertisingInfo" /v "Turn off the advertising ID" /f
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\TextInput" /v "Improve inking and typing recognition" /f
reg delete "HKLM\Software\Policies\Microsoft\Windows\HandwritingErrorReports" /v "Restrict Internet communication" /f
reg delete "HKLM\Software\Policies\Microsoft\Windows\TabletPC" /v "Restrict Internet communication" /f
reg delete "HKLM\Software\Policies\Microsoft\WindowsInkWorkspace" /v "Allow Windows Ink Workspace" /f
reg delete "HKLM\Software\Policies\Microsoft\WindowsInkWorkspace" /v "Allow suggested apps in Windows Ink Workspace" /f
reg delete "HKLM\Software\Policies\Microsoft\InputPersonalization" /v "Allow users to enable online speech recognition services" /f
reg delete "HKLM\Software\Policies\Microsoft\Speech" /v "Allow Automatic Update of Speech Data" /f
reg delete "%DC_POL%" /v "Do not show feedback notifications" /f
reg delete "HKLM\Software\Policies\Microsoft\Messenger\Client" /v "Turn off the Windows Messenger Customer Experience Improvement Program" /f
reg delete "HKLM\Software\Policies\Microsoft\SQMClient\Windows" /v "Turn off Windows Customer Experience Improvement Program" /f
reg delete "HKLM\Software\Policies\Microsoft\Internet Explorer\SQM" /v "Prevent participation in the Customer Experience Improvement Program" /f
reg delete "HKLM\Software\Policies\Microsoft\Windows\System" /v "Turn off Resultant Set of Policy logging" /f
reg delete "HKLM\Software\Policies\Microsoft\Windows NT\CurrentVersion\Software Protection Platform" /v "Turn off KMS Client Online AVS Validation" /f

echo Restore General Telemetry and Diagnostic Data Collection applied successfully.
