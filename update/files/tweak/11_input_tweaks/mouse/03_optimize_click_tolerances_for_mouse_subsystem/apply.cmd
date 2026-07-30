@echo off
title By Platinum+ Optimizer

reg add "HKCU\Control Panel\Mouse" /v "MouseTrails" /t REG_SZ /d "0" /f
reg add "HKCU\Control Panel\Mouse" /v "DoubleClickSpeed" /t REG_SZ /d "200" /f
reg add "HKCU\Control Panel\Mouse" /v "DoubleClickHeight" /t REG_SZ /d "1" /f
reg add "HKCU\Control Panel\Mouse" /v "DoubleClickWidth" /t REG_SZ /d "1" /f

echo Optimize Click Tolerances for Mouse Subsystem applied successfully.
