@echo off
title By Platinum+ Optimizer

:: Optimize DirectStorage BypassIO and Global Parameters
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters" /v StorageSupportedFeatures /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters" /v DmaRemappingCompatible /t REG_DWORD /d 2 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters" /v BusType /t REG_DWORD /d 17 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters" /v BusyPauseTimeInMs /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters" /v BusyRetryCount /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters" /v IoLatencyCap /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters" /v IoTimeoutValue /t REG_DWORD /d 10 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters" /v PnpAsyncNewDevices /t REG_DWORD /d 1 /f

:: Ensure BypassIO is not disabled at the device level
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v DisableBypassIO /t REG_MULTI_SZ /d "0" /f

echo Optimize DirectStorage BypassIO and Disable DMA Remapping applied successfully.
