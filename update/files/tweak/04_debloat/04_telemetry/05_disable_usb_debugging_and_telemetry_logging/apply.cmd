@echo off
title By Platinum+ Optimizer

:: Apply USB Debugging and Telemetry Disablement
reg add "HKLM\SYSTEM\CurrentControlSet\Services\usb" /v debuglevel /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\usb" /v debuglogmask /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\usb" /v debuglogenable /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\usb" /v debugcatc /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\usb" /v EnPMDebug /t REG_DWORD /d 0 /f
reg add "HKLM\System\CurrentControlSet\Control\Usb\Ceip" /v BootPathSurpriseRemovalCount /t REG_DWORD /d 0 /f

:: Disable Hardware Verifier Queries globally
reg add "HKLM\SYSTEM\CurrentControlSet\Control\usb\HardwareVerifier\global\usbUpto20" /v device /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\usb\HardwareVerifier\global\usb2X" /v device /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\usb\HardwareVerifier\global\usb30" /v device /t REG_DWORD /d 0 /f

echo Disable USB Debugging and Telemetry Logging applied successfully.
