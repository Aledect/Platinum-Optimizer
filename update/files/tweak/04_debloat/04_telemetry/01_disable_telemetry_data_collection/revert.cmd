@echo off
title By Platinum+ Optimizer
schtasks /change /tn "\Microsoft\Windows\Autochk\Proxy" /enable
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /enable
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /enable
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\Uploader" /enable
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\Server\ServerCeipAssistant" /enable
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\Server\ServerRoleUsageCollector" /enable
schtasks /change /tn "\Microsoft\Windows\Feedback\Siuf\DmClient" /enable
schtasks /change /tn "\Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" /enable
schtasks /change /tn "\Microsoft\Windows\Application Experience\MareBackup" /enable
schtasks /change /tn "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /enable
schtasks /change /tn "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser Exp" /enable
schtasks /change /tn "\Microsoft\Windows\Application Experience\PcaPatchDbTask" /enable
schtasks /change /tn "\Microsoft\Windows\Application Experience\SdbinstMergeDbTask" /enable
schtasks /change /tn "\Microsoft\Windows\Application Experience\StartupAppTask" /enable
schtasks /change /tn "\Microsoft\Windows\Device Information\Device User" /enable
schtasks /change /tn "\Microsoft\Windows\Device Information\Device" /enable
schtasks /change /tn "\Microsoft\Windows\Flighting\OneSettings\RefreshCache" /enable
echo Restore Telemetry and Customer Experience Data Collection applied successfully.
