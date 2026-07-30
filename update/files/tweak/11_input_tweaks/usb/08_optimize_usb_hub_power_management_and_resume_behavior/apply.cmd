@echo off
title By Platinum+ Optimizer

:: Optimize USB Hub Power Management and Resume Behavior
reg add "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB\hubg" /v DisableSelectiveSuspendUI /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB\hubg" /v DisableOnSoftRemove /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB\hubg" /v WakeOnConnectUI /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB\hubg" /v PreventDebounceTimeForSuperSpeedDevices /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB\hubg" /v ForceResetOnResume /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB\hubg" /v DisableFastResume /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB\hubg" /v IdleTimeout /t REG_DWORD /d 0 /f

echo Optimize USB Hub Power Management and Resume Behavior applied successfully.
