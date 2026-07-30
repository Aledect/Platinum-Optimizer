@echo off
title By Platinum+ Optimizer

:: The following value names are NOT SPECIFIED in the source PDF. 
:: The exact policy descriptions from the documentation are used as placeholders.

:: Show or hide "Most used" list from Start menu
REG ADD "HKLM\Software\Policies\Microsoft\Windows\Explorer" /v "Show or hide ?Most used? list from Start menu" /t REG_DWORD /d 1 /f
REG ADD "HKCU\Software\Policies\Microsoft\Windows\Explorer" /v "Show or hide ?Most used? list from Start menu" /t REG_DWORD /d 1 /f

:: Remove frequent programs list from the Start Menu
REG ADD "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "Remove frequent programs list from the Start Menu" /t REG_DWORD /d 1 /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "Remove frequent programs list from the Start Menu" /t REG_DWORD /d 1 /f

:: Turn off user tracking
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "Turn off user tracking" /t REG_DWORD /d 1 /f

:: Remove "Recently added" list from Start Menu
REG ADD "HKLM\Software\Policies\Microsoft\Windows\Explorer" /v "Remove ?Recently added? list from Start Menu" /t REG_DWORD /d 1 /f
REG ADD "HKCU\Software\Policies\Microsoft\Windows\Explorer" /v "Remove ?Recently added? list from Start Menu" /t REG_DWORD /d 1 /f

:: Do not show the 'new application installed' notification
REG ADD "HKLM\Software\Policies\Microsoft\Windows\Explorer" /v "Do not show the ?new application installed? notification" /t REG_DWORD /d 1 /f

echo Disable Start Menu Tracking and App Notifications for UI applied successfully.
