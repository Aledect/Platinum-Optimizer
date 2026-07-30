@echo off
title By Platinum+ Optimizer

:: DiagTrack and Regional Settings
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack" /v "RedirectedRegistryRoot" /t REG_SZ /d "Software\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack" /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack\RegionalSett" /v "IsProcessorMode" /t REG_QWORD /d 0 /f

:: CurrentVersion DataCollection Policies
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "MaxTelemetryAllowed" /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "CommercialId" /t REG_SZ /d "" /f

:: Apply to all existing User subkeys under CurrentVersion DataCollection
for /f "tokens=*" %%a in ('reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\DataCollection\Users" 2^>nul ^| findstr /I "Users\\"') do (
    reg add "%%a" /v "AllowTelemetry" /t REG_DWORD /d 0 /f
    reg add "%%a" /v "AllowTelemetry_PolicyManager" /t REG_DWORD /d 0 /f
)

:: Core DataCollection Policies
set "DC_POL=HKLM\Software\Policies\Microsoft\Windows\DataCollection"
reg add "%DC_POL%" /v "AllowTelemetry" /t REG_DWORD /d 0 /f
reg add "%DC_POL%" /v "LimitDumpCollection" /t REG_DWORD /d 1 /f
reg add "%DC_POL%" /v "LimitEnhancedDiagnosticDataWindowsAnalytics" /t REG_DWORD /d 1 /f
reg add "%DC_POL%" /v "DisableTelemetryOptInChangeNotification" /t REG_DWORD /d 1 /f
reg add "%DC_POL%" /v "DisableTelemetryOptInSettingsUx" /t REG_DWORD /d 1 /f
reg add "%DC_POL%" /v "DisableDeviceDelete" /t REG_DWORD /d 1 /f
reg add "%DC_POL%" /v "DisableDiagnosticDataViewer" /t REG_DWORD /d 1 /f
reg add "%DC_POL%" /v "AllowCommercialDataPipeline" /t REG_DWORD /d 0 /f
reg add "%DC_POL%" /v "LimitDiagnosticLogCollection" /t REG_DWORD /d 1 /f
reg add "%DC_POL%" /v "DisableEnterpriseAuthProxy" /t REG_DWORD /d 1 /f
reg add "%DC_POL%" /v "AllowDeviceNameInDiagnosticData" /t REG_DWORD /d 0 /f
reg add "%DC_POL%" /v "DisableOneSettingsDownloads" /t REG_DWORD /d 1 /f
reg add "%DC_POL%" /v "EnableOneSettingsAuditing" /t REG_DWORD /d 0 /f
reg add "%DC_POL%" /v "ConfigureMicrosoft365UploadEndpoint" /t REG_SZ /d "" /f
reg add "%DC_POL%" /v "AllowDeviceNameInTelemetry" /t REG_DWORD /d 0 /f
reg add "%DC_POL%" /v "AllowTelemetry_PolicyManager" /t REG_DWORD /d 0 /f
reg add "%DC_POL%" /v "CommercialId" /t REG_SZ /d "" /f
reg add "%DC_POL%" /v "TelemetryProxyServer" /t REG_SZ /d "" /f
reg add "%DC_POL%" /v "TelemetryProxyServer_PolicyManager" /t REG_SZ /d "" /f

:: Offline Auth Policies
reg add "HKLM\OFFLINE_AUTH\Microsoft\Windows\CurrentVersion\Diagnostics\DiagTrack" /v "DiagTrackAuthorization" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_AUTH\Policies\Microsoft\Windows\DataCollection" /v "LimitDumpCollection" /t REG_DWORD /d 1 /f

:: Apply User-specific Policies across all loaded profiles
for /f "tokens=*" %%u in ('reg query "HKU" ^| findstr /V "_Classes"') do (
    reg add "%%u\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f
    reg add "%%u\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry_PolicyManager" /t REG_DWORD /d 0 /f
    reg add "%%u\Software\Policies\Microsoft\Internet Explorer\SQM" /v "Prevent participation in the Customer Experience Improvement Program" /t REG_DWORD /d 1 /f
)

:: Windows Policies (Value names not explicitly specified in the source PDF; using Policy descriptions as placeholders)
reg add "HKLM\Software\Policies\Microsoft\Windows\AppCompat" /v "Turn off Application Telemetry" /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Policies\Microsoft\Windows\AppCompat" /v "Turn off Inventory" /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Policies\Microsoft\Windows\AdvertisingInfo" /v "Turn off the advertising ID" /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\TextInput" /v "Improve inking and typing recognition" /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Policies\Microsoft\Windows\HandwritingErrorReports" /v "Restrict Internet communication" /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Policies\Microsoft\Windows\TabletPC" /v "Restrict Internet communication" /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Policies\Microsoft\WindowsInkWorkspace" /v "Allow Windows Ink Workspace" /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Policies\Microsoft\WindowsInkWorkspace" /v "Allow suggested apps in Windows Ink Workspace" /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Policies\Microsoft\InputPersonalization" /v "Allow users to enable online speech recognition services" /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Policies\Microsoft\Speech" /v "Allow Automatic Update of Speech Data" /t REG_DWORD /d 0 /f
reg add "%DC_POL%" /v "Do not show feedback notifications" /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Policies\Microsoft\Messenger\Client" /v "Turn off the Windows Messenger Customer Experience Improvement Program" /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Policies\Microsoft\SQMClient\Windows" /v "Turn off Windows Customer Experience Improvement Program" /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Policies\Microsoft\Internet Explorer\SQM" /v "Prevent participation in the Customer Experience Improvement Program" /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Policies\Microsoft\Windows\System" /v "Turn off Resultant Set of Policy logging" /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Policies\Microsoft\Windows NT\CurrentVersion\Software Protection Platform" /v "Turn off KMS Client Online AVS Validation" /t REG_DWORD /d 1 /f

echo Disable General Telemetry and Diagnostic Data Collection applied successfully.
