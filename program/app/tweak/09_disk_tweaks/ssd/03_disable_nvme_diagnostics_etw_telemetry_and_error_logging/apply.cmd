@echo off
title By Platinum+ Optimizer

:: Disable NVMe Diagnostics and Telemetry
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v DiagnosticFlags /t REG_MULTI_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v LogSize /t REG_MULTI_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v TestMdlDataBufferOffsetInBytes /t REG_MULTI_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v UseDumpPointers /t REG_MULTI_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v NvmeTestSwitch /t REG_MULTI_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v ErrorEtwThrottleInterval /t REG_MULTI_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v ReliabilityDegraded /t REG_MULTI_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v ReadOnly /t REG_MULTI_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v VolatileMemoryBackupDeviceFailed /t REG_MULTI_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v AvailableSpare /t REG_MULTI_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v AvailableSpareThreshold /t REG_MULTI_SZ /d "0" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v DriverParameter /t REG_MULTI_SZ /d "0" /f

echo Disable NVMe Diagnostics, ETW Telemetry, and Error Logging applied successfully.
