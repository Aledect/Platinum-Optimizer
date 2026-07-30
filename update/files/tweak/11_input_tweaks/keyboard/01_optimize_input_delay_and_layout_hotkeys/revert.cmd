@echo off
title By Platinum+ Optimizer

:: Restore Keyboard Repeat and Cursor Rates to Defaults
reg add "HKCU\Control Panel\Keyboard" /v KeyboardDelay /t REG_SZ /d "1" /f
reg add "HKCU\Control Panel\Keyboard" /v KeyboardSpeed /t REG_SZ /d "31" /f
reg add "HKCU\Control Panel\Desktop" /v CursorBlinkRate /t REG_SZ /d "530" /f

:: Restore Language and Layout Switch Hotkeys to Defaults
reg add "HKCU\Keyboard Layout\Toggle" /v "Language Hotkey" /t REG_SZ /d "1" /f
reg add "HKCU\Keyboard Layout\Toggle" /v "Hotkey" /t REG_SZ /d "1" /f
reg add "HKCU\Keyboard Layout\Toggle" /v "Layout Hotkey" /t REG_SZ /d "1" /f

echo Optimize Input Delay and Layout Hotkeys for Keyboard restored successfully.
