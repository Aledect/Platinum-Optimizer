@echo off
title By Platinum+ Optimizer
reg add "HKCU\Software\Microsoft\GameBar" /v "AutoGameModeEnabled" /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\GameBar" /v "GpuGameMemoryBudgetPercentage" /t REG_DWORD /d 90 /f
reg add "HKCU\Software\Microsoft\GameBar" /v "GpuDwmMemoryBudgetPercentage" /t REG_DWORD /d 9 /f
reg add "HKCU\Software\Microsoft\GameBar" /v "GpuYieldPercentage" /t REG_DWORD /d 2 /f
reg add "HKCU\Software\Microsoft\GameBar" /v "DisallowSystemAllowedCpuSets" /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Policies\Microsoft\Windows\GameDVR" /v "AllowAutoGameMode" /t REG_DWORD /d 1 /f
echo Optimize Game Mode Resource Manager for GPU Scheduling applied successfully.
