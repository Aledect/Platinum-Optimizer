@echo off
title By Platinum+ Optimizer
reg add "HKCU\Software\Policies\Microsoft\Windows NT\Printers" /v "Turn off printing over HTTP" /t REG_SZ /d "D" /f
reg add "HKLM\Software\Policies\Microsoft\Windows NT\Printers" /v "Turn off printing over HTTP" /t REG_SZ /d "D" /f
reg add "HKCU\Software\Policies\Microsoft\Windows NT\Printers" /v "Turn off downloading of print drivers over HTTP" /t REG_SZ /d "D" /f
reg add "HKLM\Software\Policies\Microsoft\Windows NT\Printers" /v "Turn off downloading of print drivers over HTTP" /t REG_SZ /d "D" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "Prevent addition of printers" /t REG_SZ /d "N" /f
reg add "HKCU\Software\Microsoft\Windows NT\CurrentVersion\Windows" /v "Turn off Windows default printer management" /t REG_SZ /d "L" /f
reg add "HKCU\Software\Policies\Microsoft\Windows NT\Printers\Wizard" /v "Browse the network to find printers" /t REG_SZ /d "D" /f
echo.
echo Disable Printer Policies for Windows applied successfully.
