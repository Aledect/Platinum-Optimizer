@echo off
title By Platinum+ Optimizer

:: Disable USB Hub Diagnostics, Debugging, and Validation
reg add "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB\hubg" /v EnableDiagnosticMode /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB\hubg" /v EnableExtendedValidation /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB\hubg" /v UsbDebugModeEnable /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB\hubg" /v BreakOnHubException /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB\hubg" /v debuglevel /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB\hubg" /v DebugLogMask /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB\hubg" /v DebugLogEnable /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB\hubg" /v BreakOnReplicant /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB\hubg" /v BreakOnEnumFailure /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB\hubg" /v UseIoErrorLog /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB\hubg" /v LogSize /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB\hubg" /v MsOsDescriptorMode /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB\hubg" /v DisableHardReset /t REG_DWORD /d 1 /f

echo Disable USB Hub Diagnostics and Debugging Logging applied successfully.
