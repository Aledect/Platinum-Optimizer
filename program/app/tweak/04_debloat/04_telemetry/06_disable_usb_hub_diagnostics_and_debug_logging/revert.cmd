@echo off
title By Platinum+ Optimizer

:: Restore USB Hub Diagnostics, Debugging, and Validation
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB\hubg" /v EnableDiagnosticMode /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB\hubg" /v EnableExtendedValidation /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB\hubg" /v UsbDebugModeEnable /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB\hubg" /v BreakOnHubException /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB\hubg" /v debuglevel /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB\hubg" /v DebugLogMask /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB\hubg" /v DebugLogEnable /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB\hubg" /v BreakOnReplicant /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB\hubg" /v BreakOnEnumFailure /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB\hubg" /v UseIoErrorLog /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB\hubg" /v LogSize /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB\hubg" /v MsOsDescriptorMode /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB\hubg" /v DisableHardReset /f >nul 2>&1

echo Disable USB Hub Diagnostics and Debugging Logging restored successfully.
