@echo off
title By Platinum+ Optimizer

:: Disable Audio Diagnostics and Watchdog Timers
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Audio" /v SuppressBridgeTargetGlitchLogging /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Audio" /v DisablePumpBackupTimer /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Audio" /v AudioDgWatchDogTimerInMs /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Audio" /v PreventAudioDGCrashOrReportOnAPOException /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Audio" /v SkipPeriodicityValidation /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Audio" /v ProbeForMinimumPeriod /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Audio" /v MaxCapturePeriodicityInMs /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Audio" /v EnableCaptureMonitor /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Audio" /v ConstraintModelTest /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Audio" /v AudioHealthMonitorLimit /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Audio" /v AudioSrvWatchDogTimerInMs /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Audio\Policy" /v SkipAPOFailureCheck /t REG_DWORD /d 1 /f

echo Disable Audio Diagnostics, Telemetry, and Watchdog Timers applied successfully.
