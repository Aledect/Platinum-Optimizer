@echo off
title By Platinum+ Optimizer

:: Optimize Keyboard Repeat and Cursor Rates
reg add "HKCU\Control Panel\Keyboard" /v KeyboardDelay /t REG_SZ /d "0" /f
reg add "HKCU\Control Panel\Keyboard" /v KeyboardSpeed /t REG_SZ /d "31" /f
reg add "HKCU\Control Panel\Desktop" /v CursorBlinkRate /t REG_SZ /d "900" /f

:: Disable Language and Layout Switch Hotkeys
reg add "HKCU\Keyboard Layout\Toggle" /v "Language Hotkey" /t REG_SZ /d "3" /f
reg add "HKCU\Keyboard Layout\Toggle" /v "Hotkey" /t REG_SZ /d "3" /f
reg add "HKCU\Keyboard Layout\Toggle" /v "Layout Hotkey" /t REG_SZ /d "3" /f

echo Optimize Input Delay and Layout Hotkeys for Keyboard applied successfully.
