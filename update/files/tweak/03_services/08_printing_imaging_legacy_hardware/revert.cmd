@echo off
title By Platinum+ Optimizer
sc config "McpManagementService" start= demand
sc config "PrintDeviceConfigurationService" start= demand
sc config "PrintNotify" start= demand
sc config "PrintScanBrokerService" start= demand
sc config "PrintWorkflowUserSvc" start= demand
sc config "Spooler" start= auto
sc config "usbprint" start= demand
sc config "FrameServer" start= demand
sc config "FrameServerMonitor" start= demand
sc config "StiSvc" start= demand
sc config "cdrom" start= demand
sc config "ShellHWDetection" start= auto
sc config "Beep" start= demand
sc config "circlass" start= demand
sc config "msisadrv" start= demand
echo Restore Printing, Imaging, and Legacy Hardware for Subsystem Optimization applied successfully.