@echo off
title By Platinum+ Optimizer

:: Restore WER Services
sc config WerSvc start= demand
sc config wercplsupport start= demand

:: Restore WER Scheduled Tasks
schtasks /change /tn "\Microsoft\Windows\ErrorDetails\EnableErrorDetailsUpdate" /enable >nul 2>&1
schtasks /change /tn "\Microsoft\Windows\Windows Error Reporting\QueueReporting" /enable >nul 2>&1

:: Restore Crash Dumps (3 = Small memory dump)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\CrashControl" /v "CrashDumpEnabled" /t REG_DWORD /d 3 /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\CrashControl" /v "CrashDumpEnabled.New" /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\CrashControl" /v "CrashDumpEnabled.Old" /f

:: Restore Kernel WER and Watson Reporting
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Kernel" /v "EnableWerUserReporting" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Kernel" /v "SeLpacEnableWatsonReporting" /t REG_DWORD /d 1 /f

:: Restore Hardware and Memory Telemetry
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PnP\pci" /v "AerMultiErrorDisabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\StorPort" /v "TelemetryErrorDataEnabled" /t REG_DWORD /d 1 /f
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "PeriodicTelemetryReportFrequency" /f

:: Restore Base WER Registry Settings
reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "DisableWER" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "DefaultConsent" /t REG_DWORD /d 0 /f

:: Restore Windows Policies: Device Install Settings
reg delete "HKLM\Software\Policies\Microsoft\Windows\DeviceInstall\Settings" /v "Do not send a Windows error report when a generic driver is installed on a device" /f
reg delete "HKLM\Software\Policies\Microsoft\Windows\DeviceInstall\Settings" /v "Prevent Windows from sending an error report when a device driver requests additional software during installation" /f

:: Restore Windows Policies: Windows Error Reporting (Machine & User)
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "Disable Windows Error Reporting" /f
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "Automatically send memory dumps for OS-generated error reports" /f

for /f "tokens=*" %%u in ('reg query "HKU" ^| findstr /V "_Classes"') do (
    reg delete "%%u\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "Disable logging" /f
    reg delete "%%u\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "Automatically send memory dumps for OS-generated error reports" /f
)

:: Restore Windows Policies: Device Health Attestation
reg delete "HKLM\Software\Policies\Microsoft\DeviceHealthAttestationService" /v "Enable Device Health Attestation Monitoring and Reporting" /f

:: Restore Windows Policies: Reliability and Persistent Timestamp
reg delete "HKLM\Software\Policies\Microsoft\Windows NT\Reliability" /v "TimeStampEnabled" /f
reg delete "HKLM\Software\Policies\Microsoft\Windows NT\Reliability" /v "TimeStampInterval" /f
reg delete "HKLM\Software\Policies\Microsoft\Windows NT\Reliability" /v "Enable Persistent Time Stamp" /f

echo Restore Windows Error Reporting and Crash Dumps applied successfully.
