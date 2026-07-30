@echo off
title By Platinum+ Optimizer
reg delete "HKLM\SOFTWARE\Microsoft\Windows\DWM" /v "DesktopHeapLogging" /f >nul 2>&1
echo Restore Desktop Window Manager Heap Logging applied successfully.
