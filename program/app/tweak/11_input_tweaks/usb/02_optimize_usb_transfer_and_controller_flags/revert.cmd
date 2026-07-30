@echo off
title By Platinum+ Optimizer

:: Restore Global USB Core Optimizations
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\usbflags" /v Allow64KLowOrFullSpeedControlTransfers /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\usbflags" /v DisableHCS0Idle /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\usbflags" /v GenericCompositeUSBDeviceString /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\usbflags" /v SetMultiTTBitDuringConfigureEndpoint /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\usbflags" /v TestRunEsmInWorkItem /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\usbflags" /v ResetTTOnCancel /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\usbflags" /v NoClearTTBufferOnCancel /f >nul 2>&1

echo Optimize Global USB Transfer and Controller Flags restored successfully.
