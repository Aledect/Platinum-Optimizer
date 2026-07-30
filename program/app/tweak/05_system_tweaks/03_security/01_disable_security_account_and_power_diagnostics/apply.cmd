@echo off
title By Platinum+ Optimizer
schtasks /change /tn "\Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance" /disable
schtasks /change /tn "\Microsoft\Windows\Windows Defender\Windows Defender Cleanup" /disable
schtasks /change /tn "\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan" /disable
schtasks /change /tn "\Microsoft\Windows\Windows Defender\Windows Defender Verification" /disable
schtasks /change /tn "\Microsoft\Windows\BitLocker\BitLocker Encrypt All Drives" /disable
schtasks /change /tn "\Microsoft\Windows\BitLocker\BitLocker MDM Policy Refresh" /disable
schtasks /change /tn "\Microsoft\Windows\AccountHealth\RecoverabilityToastTask" /disable
schtasks /change /tn "\Microsoft\Windows\RemoteAssistance\RemoteAssistanceTask" /disable
schtasks /change /tn "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /disable
echo Disable Security, Account, and Power Diagnostics applied successfully.
