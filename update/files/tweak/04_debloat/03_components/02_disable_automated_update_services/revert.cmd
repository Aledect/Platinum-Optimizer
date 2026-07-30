@echo off
title By Platinum+ Optimizer
schtasks /change /tn "\Microsoft\Windows\InstallService\ScanForUpdates" /enable
schtasks /change /tn "\Microsoft\Windows\InstallService\ScanForUpdatesAsUser" /enable
schtasks /change /tn "\Microsoft\Windows\InstallService\SmartRetry" /enable
schtasks /change /tn "\Microsoft\Windows\InstallService\WakeUpAndContinueUpdates" /enable
schtasks /change /tn "\Microsoft\Windows\InstallService\WakeUpAndScanForUpdates" /enable
schtasks /change /tn "\Microsoft\Windows\UNP\RunUpdateNotificationMgr" /enable
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\Report policies" /enable
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\Schedule Maintenance Work" /enable
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\Schedule Scan" /enable
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\Schedule Scan Static Task" /enable
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\Schedule Wake To Work" /enable
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\Schedule Work" /enable
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\Start Oobe Expedite Work" /enable
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\StartOobeAppsScan_LicenseAccepted" /enable
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\StartOobeAppsScanAfterUpdate" /enable
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\USO_UxBroker" /enable
schtasks /change /tn "\Microsoft\Windows\UpdateOrchestrator\UUS Failover Task" /enable
schtasks /change /tn "\Microsoft\Windows\WindowsUpdate\Scheduled Start" /enable
schtasks /change /tn "\Microsoft\Windows\WindowsUpdate\Refresh Group Policy Cache" /enable
echo Restore Automated Update Services applied successfully.
