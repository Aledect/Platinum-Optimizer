@echo off
title By Platinum+ Optimizer
schtasks /change /tn "\Microsoft\Office\OfficeTelemetryAgentFallBack" /enable
schtasks /change /tn "\Microsoft\Office\OfficeTelemetryAgentFallBack2016" /enable
schtasks /change /tn "\Microsoft\Office\OfficeTelemetryAgentLogOn" /enable
schtasks /change /tn "\Microsoft\Office\OfficeTelemetryAgentLogOn2016" /enable
powershell -NoProfile -Command "Get-ScheduledTask -TaskName 'NvTmRep_*' -ErrorAction SilentlyContinue | Enable-ScheduledTask"
powershell -NoProfile -Command "Get-ScheduledTask -TaskName 'NvTmRepOnLogon*' -ErrorAction SilentlyContinue | Enable-ScheduledTask"
powershell -NoProfile -Command "Get-ScheduledTask -TaskName 'NvTmMon_*' -ErrorAction SilentlyContinue | Enable-ScheduledTask"
schtasks /change /tn "\Microsoft\Windows\WindowsAI\Recall\InitialConfiguration" /enable
schtasks /change /tn "\Microsoft\Windows\WindowsAI\Recall\PolicyConfiguration" /enable
schtasks /change /tn "\Microsoft\Windows\WindowsAI\Settings\InitialConfiguration" /enable
echo Restore Third-Party and AI Telemetry applied successfully.
