@echo off
title By Platinum+ Optimizer
schtasks /change /tn "\Microsoft\Windows\WCM\WiFiTask" /enable
schtasks /change /tn "\Microsoft\Windows\WlanSvc\CDSSync" /enable
schtasks /change /tn "\Microsoft\Windows\WwanSvc\NotificationTask" /enable
schtasks /change /tn "\Microsoft\Windows\WwanSvc\OobeDiscovery" /enable
schtasks /change /tn "\Microsoft\Windows\WlanSvc\MoProfileManagement" /enable
schtasks /change /tn "\Microsoft\Windows\Location\WindowsActionDialog" /enable
echo Restore Network, Wi-Fi, and Location Polling applied successfully.
