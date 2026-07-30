@echo off
title By Platinum+ Optimizer
sc config "wuauserv" start= demand
sc config "UsoSvc" start= demand
sc config "WaaSMedicSvc" start= demand
sc config "AppXSvc" start= demand
sc config "camsvc" start= demand
sc config "ClipSVC" start= demand
sc config "InstallService" start= demand
sc config "LicenseManager" start= demand
sc config "PushToInstall" start= demand
sc config "MicrosoftEdgeElevationService" start= demand
sc config "edgeupdate" start= demand
sc config "edgeupdatem" start= demand
echo Restore Windows Update, Microsoft Store, and Edge Services for Network/CPU applied successfully.