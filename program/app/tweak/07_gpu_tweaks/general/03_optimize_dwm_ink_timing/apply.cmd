@echo off
title By Platinum+ Optimizer
reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm\GpuAccelInkTiming" /v "ExtensionTimeMicroseconds" /t REG_DWORD /d 1000 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm\GpuAccelInkTiming" /v "PeriodicFenceMinDifferenceMicroseconds" /t REG_DWORD /d 500 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm\GpuAccelInkTiming" /v "RefreshRatePercentage" /t REG_DWORD /d 10 /f
echo Optimize DWM GPU Accelerated Ink Timing applied successfully.
