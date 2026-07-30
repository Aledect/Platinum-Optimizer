@echo off
title By Platinum+ Optimizer
schtasks /change /tn "\Microsoft\Windows\InstallService\ScanForUpdates" /disable
schtasks /change /tn "\Microsoft\Windows\InstallService\ScanForUpdatesAsUser" /disable
schtasks /change /tn "\Microsoft\Windows\InstallService\SmartRetry" /disable
schtasks /change /tn "\Microsoft\Windows\InstallService\WakeUpAndContinueUpdates" /disable
schtasks /change /tn "\Microsoft\Windows\InstallService\WakeUpAndScanForUpdates" /disable
schtasks /change /tn "\Microsoft\Windows\UNP\RunUpdateNotificationMgr" /disable
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\Report policies" /disable
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\Schedule Maintenance Work" /disable
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\Schedule Scan" /disable
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\Schedule Scan Static Task" /disable
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\Schedule Wake To Work" /disable
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\Schedule Work" /disable
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\Start Oobe Expedite Work" /disable
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\StartOobeAppsScan_LicenseAccepted" /disable
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\StartOobeAppsScanAfterUpdate" /disable
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\USO_UxBroker" /disable
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\UUS Failover Task" /disable
schtasks /change /tn "\Microsoft\Windows\WindowsUpdate\Scheduled Start" /disable
schtasks /change /tn "\Microsoft\Windows\WindowsUpdate\Refresh Group Policy Cache" /disable
echo Disable Automated Update Services applied successfully.
