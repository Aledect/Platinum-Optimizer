@echo off
title By Platinum+ Optimizer

:: Apply Bandwidth and Direct Controller Access Optimizations
reg add "HKLM\SYSTEM\CurrentControlSet\Services\usb" /v EnableDCA /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\usb" /v ForcePortsHighSpeed /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\USB" /v DualRoleFeaturesTestOverride /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\USB" /v UcmIsPresent /t REG_DWORD /d 1 /f

:: Apply Class-specific Buffer and Bandwidth Overrides
for /f "delims=" %%K in ('reg query "HKLM\System\CurrentControlSet\Control\Class\{36FC9E60-C465-11CF-8056-444553540000}" 2^>nul ^| findstr /R "[0-9][0-9][0-9][0-9]"') do (
    reg add "%%K" /v HcFlavor /t REG_DWORD /d 0 /f
    reg add "%%K" /v TotalBusBandwidth /t REG_DWORD /d 0 /f
    reg add "%%K" /v CommonBuffer2GBLimit /t REG_DWORD /d 0 /f
)

echo Optimize USB Controller Bandwidth and Direct Access applied successfully.
