@echo off
title By Platinum+ Optimizer

:: Restore Downloaded Maps Manager Core (moshostcore) to Manual
reg add "HKLM\System\CurrentControlSet\Services\moshostcore" /v "Start" /t REG_DWORD /d 3 /f

:: Restore auto-update over metered connection to User's Choice (65535)
reg add "HKLM\System\Maps\Configuration" /v "AllowOfflineMapsDownloadOverMeteredConnection" /t REG_DWORD /d 65535 /f
reg add "HKLM\System\Maps\Configuration" /v "EnableOfflineMapsAutoUpdate" /t REG_DWORD /d 65535 /f

:: Restore Persisted Boolean Settings to Default (1)
reg add "HKLM\System\Maps\Configuration" /v "AutoUpdateEnabled" /t REG_DWORD /d 1 /f
reg add "HKLM\System\Maps\Configuration" /v "UpdateOnlyOnWifi" /t REG_DWORD /d 1 /f

:: Remove System Configuration override for Offline Maps
reg delete "HKLM\System\Maps\Configuration" /v "OfflineMaps" /f

:: Remove Windows Policies for Maps
reg delete "HKLM\Software\Policies\Microsoft\Windows\Maps" /v "AutoDownloadAndUpdat" /f
reg delete "HKLM\Software\Policies\Microsoft\Windows\Maps" /v "AllowUntriggeredNetw" /f

echo Restore Map Downloads applied successfully.
