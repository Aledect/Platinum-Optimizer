@echo off
title By Platinum+ Optimizer

reg add "HKCU\Control Panel\Mouse" /v "MouseTrails" /t REG_SZ /d "0" /f
reg add "HKCU\Control Panel\Mouse" /v "DoubleClickSpeed" /t REG_SZ /d "500" /f
reg delete "HKCU\Control Panel\Mouse" /v "DoubleClickHeight" /f
reg delete "HKCU\Control Panel\Mouse" /v "DoubleClickWidth" /f

echo Optimize Click Tolerances for Mouse Subsystem restored successfully.
