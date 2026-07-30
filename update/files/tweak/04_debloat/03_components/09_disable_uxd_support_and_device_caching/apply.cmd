@echo off
title By Platinum+ Optimizer

:: Disable UXD Support and Enforce Deletion Policies
reg add "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB\hubg" /v DisableUxdSupport /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\usbhub\uxd_control\policy" /v UxdGlobalEnable /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\usbhub\uxd_control\policy" /v UxdGlobalDeleteOnShutdown /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\usbhub\uxd_control\policy" /v UxdGlobalDeleteOnReload /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\usbhub\uxd_control\policy" /v UxdGlobalDeleteOnDisconnect /t REG_DWORD /d 1 /f

:: Neutralize Dynamic Device and PnP Caching Strings
reg add "HKLM\SYSTEM\CurrentControlSet\Services\usbhub\uxd_control\devices" /v "%%04X%%04X%%04X" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\usbhub\uxd_control\pnp" /v "{GUID}" /t REG_DWORD /d 0 /f

echo Disable UXD Support and Device Caching applied successfully.
