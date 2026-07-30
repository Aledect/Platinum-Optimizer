@echo off
title By Platinum+ Optimizer
sc config Spooler start= demand
sc config PrintWorkFlowUserSvc start= demand
sc config PrintNotify start= demand
sc config usbprint start= demand
sc config McpManagementService start= demand
sc config PrintScanBrokerService start= demand
sc config PrintDeviceConfigurationService start= demand
echo.
echo Disable Printer Services for System Environment restored successfully.
