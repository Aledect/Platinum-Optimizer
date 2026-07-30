@echo off
title By Platinum+ Optimizer
reg add "HKLM\SOFTWARE\Microsoft\Avalon.Graphics" /v "UseD3DDebugLayer" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Avalon.Graphics" /v "Force10Level9" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Avalon.Graphics" /v "Force10OnWDDM1_0" /t REG_DWORD /d 0 /f
echo Disable Avalon Graphics Debugging and Legacy Hardware Modes applied successfully.
