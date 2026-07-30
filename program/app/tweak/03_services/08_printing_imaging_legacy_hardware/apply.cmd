@echo off
title By Platinum+ Optimizer
sc config "McpManagementService" start= disabled
sc stop "McpManagementService"
sc config "PrintDeviceConfigurationService" start= disabled
sc stop "PrintDeviceConfigurationService"
sc config "PrintNotify" start= disabled
sc stop "PrintNotify"
sc config "PrintScanBrokerService" start= disabled
sc stop "PrintScanBrokerService"
sc config "PrintWorkflowUserSvc" start= disabled
sc stop "PrintWorkflowUserSvc"
sc config "Spooler" start= disabled
sc stop "Spooler"
sc config "usbprint" start= disabled
sc stop "usbprint"
sc config "FrameServer" start= disabled
sc stop "FrameServer"
sc config "FrameServerMonitor" start= disabled
sc stop "FrameServerMonitor"
sc config "StiSvc" start= disabled
sc stop "StiSvc"
sc config "cdrom" start= disabled
sc stop "cdrom"
sc config "ShellHWDetection" start= disabled
sc stop "ShellHWDetection"
sc config "Beep" start= disabled
sc stop "Beep"
sc config "circlass" start= disabled
sc stop "circlass"
sc config "msisadrv" start= disabled
sc stop "msisadrv"
echo Disable Printing, Imaging, and Legacy Hardware for Subsystem Optimization applied successfully.