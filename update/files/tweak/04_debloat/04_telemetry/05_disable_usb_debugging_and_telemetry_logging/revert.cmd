@echo off
title By Platinum+ Optimizer

:: Restore USB Debugging and Telemetry Disablement
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\usb" /v debuglevel /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\usb" /v debuglogmask /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\usb" /v debuglogenable /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\usb" /v debugcatc /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\usb" /v EnPMDebug /f >nul 2>&1
reg delete "HKLM\System\CurrentControlSet\Control\Usb\Ceip" /v BootPathSurpriseRemovalCount /f >nul 2>&1

:: Restore Hardware Verifier Queries globally
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\usb\HardwareVerifier\global\usbUpto20" /v device /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\usb\HardwareVerifier\global\usb2X" /v device /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\usb\HardwareVerifier\global\usb30" /v device /f >nul 2>&1

echo Disable USB Debugging and Telemetry Logging restored successfully.
