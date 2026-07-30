@echo off
title By Platinum+ Optimizer
sc config "DiagTrack" start= disabled
sc stop "DiagTrack"
sc config "dmwappushservice" start= disabled
sc stop "dmwappushservice"
sc config "Ndu" start= disabled
sc stop "Ndu"
sc config "InventorySvc" start= disabled
sc stop "InventorySvc"
sc config "PcaSvc" start= disabled
sc stop "PcaSvc"
sc config "wuqisvc" start= disabled
sc stop "wuqisvc"
sc config "DusmSvc" start= disabled
sc stop "DusmSvc"
sc config "DPS" start= disabled
sc stop "DPS"
sc config "diagsvc" start= disabled
sc stop "diagsvc"
sc config "WdiServiceHost" start= disabled
sc stop "WdiServiceHost"
sc config "WdiSystemHost" start= disabled
sc stop "WdiSystemHost"
sc config "TroubleshootingSvc" start= disabled
sc stop "TroubleshootingSvc"
sc config "WerSvc" start= disabled
sc stop "WerSvc"
sc config "wercplsupport" start= disabled
sc stop "wercplsupport"
echo Disable Telemetry, Diagnostics, and Error Reporting for System Core applied successfully.