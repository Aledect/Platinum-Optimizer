@echo off
title By Platinum+ Optimizer
sc config Spooler start= disabled
sc stop Spooler
sc config PrintWorkFlowUserSvc start= disabled
sc stop PrintWorkFlowUserSvc
sc config PrintNotify start= disabled
sc stop PrintNotify
sc config usbprint start= disabled
sc stop usbprint
sc config McpManagementService start= disabled
sc stop McpManagementService
sc config PrintScanBrokerService start= disabled
sc stop PrintScanBrokerService
sc config PrintDeviceConfigurationService start= disabled
sc stop PrintDeviceConfigurationService
echo.
echo Disable Printer Services for System Environment applied successfully.
