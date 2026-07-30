@echo off
title By Platinum+ Optimizer

reg delete "HKCU\Control Panel\Mouse" /v "ActiveWindowTracking" /f
reg add "HKCU\Control Panel\Mouse" /v "SnapToDefaultButton" /t REG_SZ /d "0" /f
reg add "HKCU\Control Panel\Mouse" /v "SwapMouseButtons" /t REG_SZ /d "0" /f
reg add "HKCU\Control Panel\Cursors" /v "CursorDeadzoneJumpingSetting" /t REG_DWORD /d 0 /f

echo Disable Edge Snapping for Cursor Subsystem restored successfully.
