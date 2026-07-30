@echo off
title By Platinum+ Optimizer
sc config "LanmanServer" start= disabled
sc stop "LanmanServer"
sc config "CSC" start= disabled
sc stop "CSC"
sc config "CscService" start= disabled
sc stop "CscService"
sc config "Dfsc" start= disabled
sc stop "Dfsc"
sc config "MRxDAV" start= disabled
sc stop "MRxDAV"
sc config "mrxsmb" start= disabled
sc stop "mrxsmb"
sc config "mrxsmb20" start= disabled
sc stop "mrxsmb20"
sc config "P9Rdr" start= disabled
sc stop "P9Rdr"
sc config "P9RdrService" start= disabled
sc stop "P9RdrService"
sc config "rdbss" start= disabled
sc stop "rdbss"
sc config "TrkWks" start= disabled
sc stop "TrkWks"
sc config "WebClient" start= disabled
sc stop "WebClient"
sc config "fdPHost" start= disabled
sc stop "fdPHost"
sc config "FDResPub" start= disabled
sc stop "FDResPub"
sc config "SSDPSRV" start= disabled
sc stop "SSDPSRV"
sc config "upnphost" start= disabled
sc stop "upnphost"
sc config "MsLldp" start= disabled
sc stop "MsLldp"
sc config "rspndr" start= disabled
sc stop "rspndr"
sc config "lltdio" start= disabled
sc stop "lltdio"
sc config "lltdsvc" start= disabled
sc stop "lltdsvc"
sc config "p2pimsvc" start= disabled
sc stop "p2pimsvc"
sc config "p2psvc" start= disabled
sc stop "p2psvc"
sc config "PNRPAutoReg" start= disabled
sc stop "PNRPAutoReg"
sc config "PNRPsvc" start= disabled
sc stop "PNRPsvc"
sc config "lmhosts" start= disabled
sc stop "lmhosts"
echo Disable Network Discovery, File Sharing, and Offline Files for Network Stack applied successfully.