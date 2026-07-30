@echo off
title By Platinum+ Optimizer

:: Apply Global USB Core Optimizations
reg add "HKLM\SYSTEM\CurrentControlSet\Control\usbflags" /v Allow64KLowOrFullSpeedControlTransfers /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\usbflags" /v DisableHCS0Idle /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\usbflags" /v GenericCompositeUSBDeviceString /t REG_SZ /d "Optimized" /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\usbflags" /v SetMultiTTBitDuringConfigureEndpoint /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\usbflags" /v TestRunEsmInWorkItem /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\usbflags" /v ResetTTOnCancel /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\usbflags" /v NoClearTTBufferOnCancel /t REG_DWORD /d 1 /f

echo Optimize Global USB Transfer and Controller Flags applied successfully.
