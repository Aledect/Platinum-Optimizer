@echo off
title By Platinum+ Optimizer
sc config "wuauserv" start= disabled
sc stop "wuauserv"
sc config "UsoSvc" start= disabled
sc stop "UsoSvc"
sc config "WaaSMedicSvc" start= disabled
sc stop "WaaSMedicSvc"
sc config "AppXSvc" start= disabled
sc stop "AppXSvc"
sc config "camsvc" start= disabled
sc stop "camsvc"
sc config "ClipSVC" start= disabled
sc stop "ClipSVC"
sc config "InstallService" start= disabled
sc stop "InstallService"
sc config "LicenseManager" start= disabled
sc stop "LicenseManager"
sc config "PushToInstall" start= disabled
sc stop "PushToInstall"
sc config "MicrosoftEdgeElevationService" start= disabled
sc stop "MicrosoftEdgeElevationService"
sc config "edgeupdate" start= disabled
sc stop "edgeupdate"
sc config "edgeupdatem" start= disabled
sc stop "edgeupdatem"
echo Disable Windows Update, Microsoft Store, and Edge Services for Network/CPU applied successfully.