@echo off
title By Platinum+ Optimizer
sc config "SysMain" start= auto
sc config "WSearch" start= auto
sc config "defragsvc" start= demand
sc config "bam" start= auto
sc config "cbdhsvc" start= demand
sc config "CldFlt" start= demand
sc config "CloudBackupRestoreSvc" start= demand
sc config "SDRSVC" start= demand
sc config "swprv" start= demand
sc config "VSS" start= demand
sc config "wbengine" start= demand
sc config "luafv" start= auto
sc config "UnistoreSvc" start= demand
sc config "UserDataSvc" start= demand
sc config "ConsentUxUserSvc" start= demand
sc config "MessagingService" start= demand
sc config "PimIndexMaintenanceSvc" start= demand
sc config "WalletService" start= demand
sc config "PenService" start= demand
sc config "buttonconverter" start= demand
sc config "SmsRouter" start= demand
sc config "Themes" start= auto
sc config "autotimesvc" start= demand
sc config "tzautoupdate" start= demand
sc config "AppMgmt" start= demand
sc config "AxInstSV" start= demand
sc config "BITS" start= demand
sc config "EntAppSvc" start= demand
sc config "RetailDemo" start= demand
sc config "shpamsvc" start= demand
sc config "WarpJITSvc" start= demand
sc config "wisvc" start= demand
echo Restore System Maintenance, Search, and Background Activity for Storage/CPU applied successfully.