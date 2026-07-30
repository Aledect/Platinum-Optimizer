@echo off
title By Platinum+ Optimizer

:: Disable WER Services
sc config WerSvc start= disabled
sc config wercplsupport start= disabled

:: Disable WER Scheduled Tasks
schtasks /change /tn "\Microsoft\Windows\ErrorDetails\EnableErrorDetailsUpdate" /disable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Windows Error Reporting\QueueReporting" /disable >nul 2>&1

:: Disable Crash Dumps
reg add "HKLM\SYSTEM\CurrentControlSet\Control\CrashControl" /v "CrashDumpEnabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\CrashControl" /v "CrashDumpEnabled.New" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\CrashControl" /v "CrashDumpEnabled.Old" /t REG_DWORD /d 0 /f

:: Disable Kernel WER and Watson Reporting
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Kernel" /v "EnableWerUserReporting" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Kernel" /v "SeLpacEnableWatsonReporting" /t REG_DWORD /d 0 /f

:: Disable Hardware and Memory Telemetry
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PnP\pci" /v "AerMultiErrorDisabled" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\StorPort" /v "TelemetryErrorDataEnabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "PeriodicTelemetryReportFrequency" /t REG_DWORD /d 0 /f

:: Disable Base WER Registry Settings
reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "DisableWER" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "DefaultConsent" /t REG_DWORD /d 0 /f

:: Windows Policies: Device Install Settings
reg add "HKLM\Software\Policies\Microsoft\Windows\DeviceInstall\Settings" /v "Do not send a Windows error report when a generic driver is installed on a device" /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Policies\Microsoft\Windows\DeviceInstall\Settings" /v "Prevent Windows from sending an error report when a device driver requests additional software during installation" /t REG_DWORD /d 1 /f

:: Windows Policies: Windows Error Reporting (Machine & User)
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "Disable Windows Error Reporting" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "Automatically send memory dumps for OS-generated error reports" /t REG_DWORD /d 0 /f

for /f "tokens=*" %%u in ('reg query "HKU" ^| findstr /V "_Classes"') do (
    reg add "%%u\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "Disable logging" /t REG_DWORD /d 1 /f
    reg add "%%u\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "Automatically send memory dumps for OS-generated error reports" /t REG_DWORD /d 0 /f
)

:: Windows Policies: Device Health Attestation
reg add "HKLM\Software\Policies\Microsoft\DeviceHealthAttestationService" /v "Enable Device Health Attestation Monitoring and Reporting" /t REG_DWORD /d 0 /f

:: Windows Policies: Reliability and Persistent Timestamp
reg add "HKLM\Software\Policies\Microsoft\Windows NT\Reliability" /v "TimeStampEnabled" /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Policies\Microsoft\Windows NT\Reliability" /v "TimeStampInterval" /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Policies\Microsoft\Windows NT\Reliability" /v "Enable Persistent Time Stamp" /t REG_DWORD /d 0 /f

echo Disable Windows Error Reporting and Crash Dumps applied successfully.
