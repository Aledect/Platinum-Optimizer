@echo off
title By Platinum+ Optimizer
schtasks /change /tn "\Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance" /enable
schtasks /change /tn "\Microsoft\Windows\Windows Defender\Windows Defender Cleanup" /enable
schtasks /change /tn "\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan" /enable
schtasks /change /tn "\Microsoft\Windows\Windows Defender\Windows Defender Verification" /enable
schtasks /change /tn "\Microsoft\Windows\BitLocker\BitLocker Encrypt All Drives" /enable
schtasks /change /tn "\Microsoft\Windows\BitLocker\BitLocker MDM Policy Refresh" /enable
schtasks /change /tn "\Microsoft\Windows\AccountHealth\RecoverabilityToastTask" /enable
schtasks /change /tn "\Microsoft\Windows\RemoteAssistance\RemoteAssistanceTask" /enable
schtasks /change /tn "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /enable
echo Restore Security, Account, and Power Diagnostics applied successfully.
