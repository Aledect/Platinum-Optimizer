@echo off
title By Platinum+ Optimizer

:: Restore DirectStorage BypassIO and Global Parameters
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters" /v StorageSupportedFeatures /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters" /v DmaRemappingCompatible /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters" /v BusType /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters" /v BusyPauseTimeInMs /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters" /v BusyRetryCount /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters" /v IoLatencyCap /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters" /v IoTimeoutValue /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters" /v PnpAsyncNewDevices /f >nul 2>&1

:: Restore Device level BypassIO override
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v DisableBypassIO /f >nul 2>&1

echo Optimize DirectStorage BypassIO and Disable DMA Remapping restored successfully.
