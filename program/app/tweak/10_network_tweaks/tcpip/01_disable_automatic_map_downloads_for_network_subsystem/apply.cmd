@echo off
title By Platinum+ Optimizer

:: Disable Downloaded Maps Manager Core (moshostcore)
reg add "HKLM\System\CurrentControlSet\Services\moshostcore" /v "Start" /t REG_DWORD /d 4 /f

:: Force disable auto-update over metered connection and general auto-update
reg add "HKLM\System\Maps\Configuration" /v "AllowOfflineMapsDownloadOverMeteredConnection" /t REG_DWORD /d 0 /f
reg add "HKLM\System\Maps\Configuration" /v "EnableOfflineMapsAutoUpdate" /t REG_DWORD /d 0 /f

:: Override Persisted Boolean Settings (Trace ID 3025 & 3043 mitigation)
reg add "HKLM\System\Maps\Configuration" /v "AutoUpdateEnabled" /t REG_DWORD /d 0 /f
reg add "HKLM\System\Maps\Configuration" /v "UpdateOnlyOnWifi" /t REG_DWORD /d 0 /f

:: Disable System Configuration for Offline Maps
reg add "HKLM\System\Maps\Configuration" /v "OfflineMaps" /t REG_DWORD /d 0 /f

:: Apply Windows Policies to turn off unsolicited traffic and auto-downloads
reg add "HKLM\Software\Policies\Microsoft\Windows\Maps" /v "AutoDownloadAndUpdat" /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Policies\Microsoft\Windows\Maps" /v "AllowUntriggeredNetw" /t REG_DWORD /d 0 /f

echo Disable Map Downloads applied successfully.
