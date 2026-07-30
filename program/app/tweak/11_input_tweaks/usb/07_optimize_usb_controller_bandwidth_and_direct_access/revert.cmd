@echo off
title By Platinum+ Optimizer

:: Restore Bandwidth and Direct Controller Access Optimizations
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\usb" /v EnableDCA /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\usb" /v ForcePortsHighSpeed /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\USB" /v DualRoleFeaturesTestOverride /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\USB" /v UcmIsPresent /f >nul 2>&1

:: Restore Class-specific Buffer and Bandwidth Overrides
for /f "delims=" %%K in ('reg query "HKLM\System\CurrentControlSet\Control\Class\{36FC9E60-C465-11CF-8056-444553540000}" 2^>nul ^| findstr /R "[0-9][0-9][0-9][0-9]"') do (
    reg delete "%%K" /v HcFlavor /f >nul 2>&1
    reg delete "%%K" /v TotalBusBandwidth /f >nul 2>&1
    reg delete "%%K" /v CommonBuffer2GBLimit /f >nul 2>&1
)

echo Optimize USB Controller Bandwidth and Direct Access restored successfully.
