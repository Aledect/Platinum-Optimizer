@echo off
title By Platinum+ Optimizer
sc config "LanmanServer" start= auto
sc config "LanmanWorkstation" start= auto
sc config "CSC" start= demand
sc config "CscService" start= demand
sc config "Dfsc" start= demand
sc config "MRxDAV" start= demand
sc config "mrxsmb" start= demand
sc config "mrxsmb20" start= demand
sc config "P9Rdr" start= demand
sc config "P9RdrService" start= demand
sc config "rdbss" start= demand
sc config "TrkWks" start= auto
sc config "WebClient" start= demand
sc config "fdPHost" start= demand
sc config "FDResPub" start= demand
sc config "SSDPSRV" start= demand
sc config "upnphost" start= demand
sc config "MsLldp" start= demand
sc config "rspndr" start= demand
sc config "lltdio" start= demand
sc config "lltdsvc" start= demand
sc config "p2pimsvc" start= demand
sc config "p2psvc" start= demand
sc config "PNRPAutoReg" start= demand
sc config "PNRPsvc" start= demand
sc config "lmhosts" start= auto
echo Restore Network Discovery, File Sharing, and Offline Files for Network Stack applied successfully.