@echo off
title By Platinum+ Optimizer

:: Define the base registry path for the AutoLogger session.
set "BASE_PATH=HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\OptimizedSession"

:: Restore Default Clock Type (1 = Performance counter value)
reg add "%BASE_PATH%" /v "ClockType" /t REG_DWORD /d 1 /f

:: Restore Real-time Persistence (0 = Enabled)
reg add "%BASE_PATH%" /v "DisableRealtimePersistence" /t REG_DWORD /d 0 /f

:: Restore Default Start and Boot Behaviors
reg add "%BASE_PATH%" /v "Start" /t REG_DWORD /d 1 /f
reg delete "%BASE_PATH%" /v "Boot" /f

:: Restore Default Flush Timer and Max File Size
reg add "%BASE_PATH%" /v "FlushTimer" /t REG_DWORD /d 0 /f
reg add "%BASE_PATH%" /v "MaxFileSize" /t REG_DWORD /d 100 /f

:: Remove Custom Buffer Limits (Allows system to calculate dynamically)
reg delete "%BASE_PATH%" /v "BufferSize" /f
reg delete "%BASE_PATH%" /v "MinimumBuffers" /f
reg delete "%BASE_PATH%" /v "MaximumBuffers" /f

:: Remove Custom File Output Configurations
reg delete "%BASE_PATH%" /v "FileCounter" /f
reg delete "%BASE_PATH%" /v "FileName" /f
reg delete "%BASE_PATH%" /v "FileMax" /f
reg delete "%BASE_PATH%" /v "LogFileMode" /f

:: Remove Identifiers
reg delete "%BASE_PATH%" /v "Guid" /f
reg delete "%BASE_PATH%" /v "Status" /f

echo Restore Startup ETS applied successfully.
