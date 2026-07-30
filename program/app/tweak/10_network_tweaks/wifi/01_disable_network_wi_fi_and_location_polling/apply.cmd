@echo off
title By Platinum+ Optimizer
schtasks /change /tn "\Microsoft\Windows\WCM\WiFiTask" /disable
schtasks /change /tn "\Microsoft\Windows\WlanSvc\CDSSync" /disable
schtasks /change /tn "\Microsoft\Windows\WwanSvc\NotificationTask" /disable
schtasks /change /tn "\Microsoft\Windows\WwanSvc\OobeDiscovery" /disable
schtasks /change /tn "\Microsoft\Windows\WlanSvc\MoProfileManagement" /disable
schtasks /change /tn "\Microsoft\Windows\Location\WindowsActionDialog" /disable
echo Disable Network, Wi-Fi, and Location Polling applied successfully.
