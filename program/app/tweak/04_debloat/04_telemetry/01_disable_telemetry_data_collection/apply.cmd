@echo off
title By Platinum+ Optimizer
schtasks /change /tn "\Microsoft\Windows\Autochk\Proxy" /disable
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /disable
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /disable
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\Uploader" /disable
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\Server\ServerCeipAssistant" /disable
schtasks /change /tn "\Microsoft\Windows\Customer Experience Improvement Program\Server\ServerRoleUsageCollector" /disable
schtasks /change /tn "\Microsoft\Windows\Feedback\Siuf\DmClient" /disable
schtasks /change /tn "\Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" /disable
schtasks /change /tn "\Microsoft\Windows\Application Experience\MareBackup" /disable
schtasks /change /tn "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /disable
schtasks /change /tn "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser Exp" /disable
schtasks /change /tn "\Microsoft\Windows\Application Experience\PcaPatchDbTask" /disable
schtasks /change /tn "\Microsoft\Windows\Application Experience\SdbinstMergeDbTask" /disable
schtasks /change /tn "\Microsoft\Windows\Application Experience\StartupAppTask" /disable
schtasks /change /tn "\Microsoft\Windows\Device Information\Device User" /disable
schtasks /change /tn "\Microsoft\Windows\Device Information\Device" /disable
schtasks /change /tn "\Microsoft\Windows\Flighting\OneSettings\RefreshCache" /disable
echo Disable Telemetry and Customer Experience Data Collection applied successfully.
