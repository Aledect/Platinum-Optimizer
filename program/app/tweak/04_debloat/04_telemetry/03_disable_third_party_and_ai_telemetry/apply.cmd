@echo off
title By Platinum+ Optimizer
schtasks /change /tn "\Microsoft\Office\OfficeTelemetryAgentFallBack" /disable
schtasks /change /tn "\Microsoft\Office\OfficeTelemetryAgentFallBack2016" /disable
schtasks /change /tn "\Microsoft\Office\OfficeTelemetryAgentLogOn" /disable
schtasks /change /tn "\Microsoft\Office\OfficeTelemetryAgentLogOn2016" /disable
powershell -NoProfile -Command "Get-ScheduledTask -TaskName 'NvTmRep_*' -ErrorAction SilentlyContinue | Disable-ScheduledTask"
powershell -NoProfile -Command "Get-ScheduledTask -TaskName 'NvTmRepOnLogon*' -ErrorAction SilentlyContinue | Disable-ScheduledTask"
powershell -NoProfile -Command "Get-ScheduledTask -TaskName 'NvTmMon_*' -ErrorAction SilentlyContinue | Disable-ScheduledTask"
schtasks /change /tn "\Microsoft\Windows\WindowsAI\Recall\InitialConfiguration" /disable
schtasks /change /tn "\Microsoft\Windows\WindowsAI\Recall\PolicyConfiguration" /disable
schtasks /change /tn "\Microsoft\Windows\WindowsAI\Settings\InitialConfiguration" /disable
echo Disable Third-Party and AI Telemetry applied successfully.
