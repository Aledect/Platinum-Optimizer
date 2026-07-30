@echo off
title By Platinum+ Optimizer
sc config "DiagTrack" start= auto
sc config "dmwappushservice" start= demand
sc config "Ndu" start= auto
sc config "InventorySvc" start= demand
sc config "PcaSvc" start= demand
sc config "wuqisvc" start= demand
sc config "DusmSvc" start= auto
sc config "DPS" start= auto
sc config "diagsvc" start= demand
sc config "WdiServiceHost" start= demand
sc config "WdiSystemHost" start= demand
sc config "TroubleshootingSvc" start= demand
sc config "WerSvc" start= demand
sc config "wercplsupport" start= demand
echo Restore Telemetry, Diagnostics, and Error Reporting for System Core applied successfully.