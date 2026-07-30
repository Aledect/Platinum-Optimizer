@echo off
title By Platinum+ Optimizer

:: Optimize Audio Engine Real-Time Processing
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Audio" /v SkipRTHeap /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Audio" /v RTOperatingMode /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Audio" /v UseNewStreamManagementCodePath /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Audio" /v CpuManagementThresholdHns /t REG_DWORD /d 50000 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Audio" /v CpuManagementAudioReservedCpuMask /t REG_QWORD /d 0 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Audio" /v DisableGetMixFormatChange /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Audio" /v EnableProtectedAudioDG /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Audio" /v AudioDGInactiveTimeout /t REG_DWORD /d 4294967295 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Audio" /v AllowClassicOffload /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Audio" /v DisableExemptionForBCMStartupLatency /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Audio" /v AastRenderDelayInMs /t REG_DWORD /d 0 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Audio" /v UnrestrictedPerProcessLoopback /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Audio\Parameters" /v AudioDGCPUPercentMax /t REG_DWORD /d 90 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Audio\Parameters" /v DeadlineDurationThreshold /t REG_DWORD /d 0 /f

echo Optimize Audio Engine Real-Time Processing applied successfully.
