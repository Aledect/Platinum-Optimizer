@echo off
title By Platinum+ Optimizer
reg add "HKLM\SOFTWARE\Microsoft\Windows\DWM" /v "DesktopHeapLogging" /t REG_DWORD /d 0 /f
echo Disable Desktop Window Manager Heap Logging applied successfully.
