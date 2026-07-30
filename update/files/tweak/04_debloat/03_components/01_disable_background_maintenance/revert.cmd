@echo off
title By Platinum+ Optimizer
schtasks /change /tn "\Microsoft\Windows\Offline Files\Background Synchronization" /enable
schtasks /change /tn "\Microsoft\Windows\Offline Files\Logon Synchronization" /enable
schtasks /change /tn "\Microsoft\Windows\ApplicationData\DsSvcCleanup" /enable
schtasks /change /tn "\Microsoft\Windows\CloudExperienceHost\CreateObjectTask" /enable
schtasks /change /tn "\Microsoft\Windows\Defrag\ScheduledDefrag" /enable
schtasks /change /tn "\Microsoft\Windows\DiskCleanup\SilentCleanup" /enable
schtasks /change /tn "\Microsoft\Windows\DiskFootprint\StorageSense" /enable
schtasks /change /tn "\Microsoft\Windows\Sysmain\ResPriStaticDbSync" /enable
schtasks /change /tn "\Microsoft\Windows\Sysmain\WsSwapAssessmentTask" /enable
schtasks /change /tn "\Microsoft\Windows\BrokerInfrastructure\BgTaskRegistrationMaintenanceTask" /enable
schtasks /change /tn "\Microsoft\Windows\capabilityaccessmanager\maintenancetasks" /enable
schtasks /change /tn "\Microsoft\Windows\Registry\RegIdleBackup" /enable
schtasks /change /tn "\Microsoft\Windows\RetailDemo\CleanupOfflineContent" /enable
schtasks /change /tn "\Microsoft\Windows\Chkdsk\ProactiveScan" /enable
schtasks /change /tn "\Microsoft\Windows\Chkdsk\SyspartRepair" /enable
schtasks /change /tn "\Microsoft\Windows\Work Folders\Work Folders Logon Synchronization" /enable
schtasks /change /tn "\Microsoft\Windows\Work Folders\Work Folders Maintenance Work" /enable
schtasks /change /tn "\Microsoft\Windows\SystemRestore\SR" /enable
echo Restore Background Maintenance and Storage Operations applied successfully.
