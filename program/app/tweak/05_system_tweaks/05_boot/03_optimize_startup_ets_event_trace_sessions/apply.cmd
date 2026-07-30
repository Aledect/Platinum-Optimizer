@echo off
title By Platinum+ Optimizer

:: Define the base registry path for the AutoLogger session.
:: The exact root path is not specified in the source PDF, so a target session path is used.
set "BASE_PATH=HKLM\SYSTEM\CurrentControlSet\Control\WMI\Autologger\OptimizedSession"

:: Configure Buffer and Memory Footprint
reg add "%BASE_PATH%" /v "BufferSize" /t REG_DWORD /d 64 /f
reg add "%BASE_PATH%" /v "MinimumBuffers" /t REG_DWORD /d 2 /f
reg add "%BASE_PATH%" /v "MaximumBuffers" /t REG_DWORD /d 22 /f

:: Optimize CPU Overhead (3 = CPU cycle counter)
reg add "%BASE_PATH%" /v "ClockType" /t REG_DWORD /d 3 /f

:: Disable Disk I/O and Persistence
reg add "%BASE_PATH%" /v "DisableRealtimePersistence" /t REG_DWORD /d 1 /f
reg add "%BASE_PATH%" /v "FlushTimer" /t REG_DWORD /d 0 /f
reg add "%BASE_PATH%" /v "LogFileMode" /t REG_DWORD /d 0 /f

:: Prevent Logger Initialization and Boot Impact
reg add "%BASE_PATH%" /v "Start" /t REG_DWORD /d 0 /f
reg add "%BASE_PATH%" /v "Boot" /t REG_DWORD /d 0 /f

:: Configure File Output Constraints
reg add "%BASE_PATH%" /v "FileCounter" /t REG_DWORD /d 1 /f
reg add "%BASE_PATH%" /v "FileName" /t REG_SZ /d "%%WINDIR%%\System32\LogFiles\WMI\optimized.etl" /f
reg add "%BASE_PATH%" /v "FileMax" /t REG_DWORD /d 1 /f
reg add "%BASE_PATH%" /v "MaxFileSize" /t REG_DWORD /d 0 /f

:: Define Required Session Identifiers
reg add "%BASE_PATH%" /v "Guid" /t REG_SZ /d "{00000000-0000-0000-0000-000000000000}" /f
reg add "%BASE_PATH%" /v "Status" /t REG_DWORD /d 0 /f

echo Optimize Startup ETS applied successfully.
