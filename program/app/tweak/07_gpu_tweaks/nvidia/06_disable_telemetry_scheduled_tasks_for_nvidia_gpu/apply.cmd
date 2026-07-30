@echo off
title By Platinum+ Optimizer
powershell -NoProfile -Command "Get-ScheduledTask -TaskName 'NvTmRep_*', 'NvTmRepOnLogon*', 'NvTmMon_*' -ErrorAction SilentlyContinue | Disable-ScheduledTask"
echo Disable Telemetry Scheduled Tasks for NVIDIA GPU applied successfully.
