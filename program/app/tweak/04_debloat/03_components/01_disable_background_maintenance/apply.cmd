@echo off
title By Platinum+ Optimizer
schtasks /change /tn "\Microsoft\Windows\Offline Files\Background Synchronization" /disable
schtasks /change /tn "\Microsoft\Windows\Offline Files\Logon Synchronization" /disable
schtasks /change /tn "\Microsoft\Windows\ApplicationData\DsSvcCleanup" /disable
schtasks /change /tn "\Microsoft\Windows\CloudExperienceHost\CreateObjectTask" /disable
schtasks /change /tn "\Microsoft\Windows\Defrag\ScheduledDefrag" /disable
schtasks /change /tn "\Microsoft\Windows\DiskCleanup\SilentCleanup" /disable
schtasks /change /tn "\Microsoft\Windows\DiskFootprint\StorageSense" /disable
schtasks /change /tn "\Microsoft\Windows\Sysmain\ResPriStaticDbSync" /disable
schtasks /change /tn "\Microsoft\Windows\Sysmain\WsSwapAssessmentTask" /disable
schtasks /change /tn "\Microsoft\Windows\BrokerInfrastructure\BgTaskRegistrationMaintenanceTask" /disable
schtasks /change /tn "\Microsoft\Windows\capabilityaccessmanager\maintenancetasks" /disable
schtasks /change /tn "\Microsoft\Windows\Registry\RegIdleBackup" /disable
schtasks /change /tn "\Microsoft\Windows\RetailDemo\CleanupOfflineContent" /disable
schtasks /change /tn "\Microsoft\Windows\Chkdsk\ProactiveScan" /disable
schtasks /change /tn "\Microsoft\Windows\Chkdsk\SyspartRepair" /disable
schtasks /change /tn "\Microsoft\Windows\Work Folders\Work Folders Logon Synchronization" /disable
schtasks /change /tn "\Microsoft\Windows\Work Folders\Work Folders Maintenance Work" /disable
schtasks /change /tn "\Microsoft\Windows\SystemRestore\SR" /disable
echo Disable Background Maintenance and Storage Operations applied successfully.
