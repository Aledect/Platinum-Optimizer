@echo off
title By Platinum+ Optimizer

:: Restore USB Hub Power Management and Resume Behavior
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB\hubg" /v DisableSelectiveSuspendUI /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB\hubg" /v DisableOnSoftRemove /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB\hubg" /v WakeOnConnectUI /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB\hubg" /v PreventDebounceTimeForSuperSpeedDevices /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB\hubg" /v ForceResetOnResume /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB\hubg" /v DisableFastResume /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB\hubg" /v IdleTimeout /f >nul 2>&1

echo Optimize USB Hub Power Management and Resume Behavior restored successfully.
