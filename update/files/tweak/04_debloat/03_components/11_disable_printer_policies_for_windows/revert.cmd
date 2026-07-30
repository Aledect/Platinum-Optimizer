@echo off
title By Platinum+ Optimizer
reg delete "HKCU\Software\Policies\Microsoft\Windows NT\Printers" /v "Turn off printing over HTTP" /f
reg delete "HKLM\Software\Policies\Microsoft\Windows NT\Printers" /v "Turn off printing over HTTP" /f
reg delete "HKCU\Software\Policies\Microsoft\Windows NT\Printers" /v "Turn off downloading of print drivers over HTTP" /f
reg delete "HKLM\Software\Policies\Microsoft\Windows NT\Printers" /v "Turn off downloading of print drivers over HTTP" /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "Prevent addition of printers" /f
reg delete "HKCU\Software\Microsoft\Windows NT\CurrentVersion\Windows" /v "Turn off Windows default printer management" /f
reg delete "HKCU\Software\Policies\Microsoft\Windows NT\Printers\Wizard" /v "Browse the network to find printers" /f
echo.
echo Disable Printer Policies for Windows restored successfully.
