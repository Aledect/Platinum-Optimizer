@echo off
title By Platinum+ Optimizer

:: Restore UXD Support and Deletion Policies
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB\hubg" /v DisableUxdSupport /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\usbhub\uxd_control\policy" /v UxdGlobalEnable /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\usbhub\uxd_control\policy" /v UxdGlobalDeleteOnShutdown /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\usbhub\uxd_control\policy" /v UxdGlobalDeleteOnReload /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\usbhub\uxd_control\policy" /v UxdGlobalDeleteOnDisconnect /f >nul 2>&1

:: Restore Dynamic Device and PnP Caching Strings
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\usbhub\uxd_control\devices" /v "%%04X%%04X%%04X" /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\usbhub\uxd_control\pnp" /v "{GUID}" /f >nul 2>&1

echo Disable UXD Support and Device Caching restored successfully.
