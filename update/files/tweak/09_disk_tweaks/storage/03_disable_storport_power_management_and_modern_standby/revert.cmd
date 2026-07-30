@echo off
title By Platinum+ Optimizer

:: Restore StorPort Power Management and Sleep States
reg add "HKLM\SYSTEM\CurrentControlSet\Control\StorPort" /v DisableRuntimePower /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\StorPort" /v HiberFileHybridPriority /t REG_BINARY /d FFFF /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Storage" /v StorageD3InModernStandby /t REG_DWORD /d 4294967295 /f

echo Disable StorPort Power Management and Modern Standby restored successfully.
