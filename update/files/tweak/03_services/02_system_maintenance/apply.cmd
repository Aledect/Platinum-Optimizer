@echo off
title By Platinum+ Optimizer
sc config "SysMain" start= disabled
sc stop "SysMain"
sc config "WSearch" start= disabled
sc stop "WSearch"
sc config "defragsvc" start= disabled
sc stop "defragsvc"
sc config "bam" start= disabled
sc stop "bam"
sc config "cbdhsvc" start= disabled
sc stop "cbdhsvc"
sc config "CldFlt" start= disabled
sc stop "CldFlt"
sc config "CloudBackupRestoreSvc" start= disabled
sc stop "CloudBackupRestoreSvc"
sc config "SDRSVC" start= disabled
sc stop "SDRSVC"
sc config "swprv" start= disabled
sc stop "swprv"
sc config "VSS" start= disabled
sc stop "VSS"
sc config "wbengine" start= disabled
sc stop "wbengine"
sc config "luafv" start= disabled
sc stop "luafv"
sc config "UnistoreSvc" start= disabled
sc stop "UnistoreSvc"
sc config "UserDataSvc" start= disabled
sc stop "UserDataSvc"
sc config "ConsentUxUserSvc" start= disabled
sc stop "ConsentUxUserSvc"
sc config "MessagingService" start= disabled
sc stop "MessagingService"
sc config "PimIndexMaintenanceSvc" start= disabled
sc stop "PimIndexMaintenanceSvc"
sc config "WalletService" start= disabled
sc stop "WalletService"
sc config "PenService" start= disabled
sc stop "PenService"
sc config "buttonconverter" start= disabled
sc stop "buttonconverter"
sc config "SmsRouter" start= disabled
sc stop "SmsRouter"
sc config "Themes" start= disabled
sc stop "Themes"
sc config "autotimesvc" start= disabled
sc stop "autotimesvc"
sc config "tzautoupdate" start= disabled
sc stop "tzautoupdate"
sc config "AppMgmt" start= disabled
sc stop "AppMgmt"
sc config "AxInstSV" start= disabled
sc stop "AxInstSV"
sc config "BITS" start= disabled
sc stop "BITS"
sc config "EntAppSvc" start= disabled
sc stop "EntAppSvc"
sc config "RetailDemo" start= disabled
sc stop "RetailDemo"
sc config "shpamsvc" start= disabled
sc stop "shpamsvc"
sc config "WarpJITSvc" start= disabled
sc stop "WarpJITSvc"
sc config "wisvc" start= disabled
sc stop "wisvc"
echo Disable System Maintenance, Search, and Background Activity for Storage/CPU applied successfully.