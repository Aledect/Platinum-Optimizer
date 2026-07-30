@echo off
title By Platinum+ Optimizer
reg delete "HKCU\Software\Microsoft\GameBar" /v "AutoGameModeEnabled" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\GameBar" /v "GpuGameMemoryBudgetPercentage" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\GameBar" /v "GpuDwmMemoryBudgetPercentage" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\GameBar" /v "GpuYieldPercentage" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\GameBar" /v "DisallowSystemAllowedCpuSets" /f >nul 2>&1
reg delete "HKLM\Software\Policies\Microsoft\Windows\GameDVR" /v "AllowAutoGameMode" /f >nul 2>&1
echo Restore Game Mode Resource Manager for GPU Scheduling applied successfully.
