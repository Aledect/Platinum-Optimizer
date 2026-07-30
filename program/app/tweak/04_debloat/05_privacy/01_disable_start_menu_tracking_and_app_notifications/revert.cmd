@echo off
title By Platinum+ Optimizer

:: Restore placeholder policy values
REG DELETE "HKLM\Software\Policies\Microsoft\Windows\Explorer" /v "Show or hide ?Most used? list from Start menu" /f
REG DELETE "HKCU\Software\Policies\Microsoft\Windows\Explorer" /v "Show or hide ?Most used? list from Start menu" /f

REG DELETE "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "Remove frequent programs list from the Start Menu" /f
REG DELETE "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "Remove frequent programs list from the Start Menu" /f

REG DELETE "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "Turn off user tracking" /f

REG DELETE "HKLM\Software\Policies\Microsoft\Windows\Explorer" /v "Remove ?Recently added? list from Start Menu" /f
REG DELETE "HKCU\Software\Policies\Microsoft\Windows\Explorer" /v "Remove ?Recently added? list from Start Menu" /f

REG DELETE "HKLM\Software\Policies\Microsoft\Windows\Explorer" /v "Do not show the ?new application installed? notification" /f

echo Restore Start Menu Tracking and App Notifications for UI applied successfully.
