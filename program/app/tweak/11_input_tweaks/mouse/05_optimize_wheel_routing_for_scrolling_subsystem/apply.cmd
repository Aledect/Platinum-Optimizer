@echo off
title By Platinum+ Optimizer

reg add "HKCU\Control Panel\Desktop" /v "WheelScrollLines" /t REG_SZ /d "3" /f
reg add "HKCU\Control Panel\Desktop" /v "MouseWheelRouting" /t REG_DWORD /d 0 /f
reg add "HKCU\Control Panel\Mouse" /v "ReverseMouseWheelDirection" /t REG_DWORD /d 0 /f

echo Optimize Wheel Routing for Scrolling Subsystem applied successfully.
