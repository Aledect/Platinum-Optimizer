@echo off
title By Platinum+ Optimizer

:: Restore NVMe Diagnostics and Telemetry
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v DiagnosticFlags /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v LogSize /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v TestMdlDataBufferOffsetInBytes /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v UseDumpPointers /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v NvmeTestSwitch /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v ErrorEtwThrottleInterval /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v ReliabilityDegraded /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v ReadOnly /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v VolatileMemoryBackupDeviceFailed /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v AvailableSpare /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v AvailableSpareThreshold /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v DriverParameter /f >nul 2>&1

echo Disable NVMe Diagnostics, ETW Telemetry, and Error Logging restored successfully.
