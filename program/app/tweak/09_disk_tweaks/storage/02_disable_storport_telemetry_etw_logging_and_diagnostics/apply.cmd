@echo off
title By Platinum+ Optimizer

:: Disable StorPort Telemetry and ETW Logging
reg add "HKLM\SYSTEM\CurrentControlSet\Control\StorPort" /v TelemetryPerformanceHighResolutionTimer /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\StorPort" /v TelemetryPerformanceEnabled /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\StorPort" /v TelemetryIoSizeDistributionEnabled /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\StorPort" /v TelemetryPerformancePeriod /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\StorPort" /v TelemetryErrorDataEnabled /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\StorPort" /v TelemetryDeviceHealthEnabled /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\StorPort" /v TelemetryDeviceHealthPeriod /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\StorPort" /v TelemetryCriticalEventEnabled /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\StorPort" /v TelemetryCriticalEventMaximum /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\StorPort" /v TelemetryDeviceLogPagesPeriod /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\StorPort" /v DeviceTelemetryLiveDumpEnable /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\StorPort" /v StorportEtwErrorThrottleLimit /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\StorPort" /v StorportEtwWarningThrottleLimit /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\StorPort" /v StorportEtwInfoThrottleLimit /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\StorPort" /v EnableRegistryWatch /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\StorPort" /v LogControlEnable /t REG_QWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\StorPort" /v LogSize /t REG_DWORD /d 0 /f

:: Disable StorPort Verification and Device Dumps
reg add "HKLM\SYSTEM\CurrentControlSet\Control\StorPort\Verifier" /v VerifyLevel /t REG_DWORD /d 4294967295 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Storage\StorageTelemetry" /v DeviceDumpLevel /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Storage\StorageTelemetry" /v DeviceDumpMaxSize /t REG_DWORD /d 0 /f

echo Disable StorPort Telemetry, ETW Logging, and Diagnostics applied successfully.
