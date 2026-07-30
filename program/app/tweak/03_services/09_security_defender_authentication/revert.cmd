@echo off
title By Platinum+ Optimizer
sc config "WinDefend" start= auto
sc config "MsSecCore" start= demand
sc config "wscsvc" start= auto
sc config "WdFilter" start= demand
sc config "WdBoot" start= demand
sc config "WdNisSvc" start= demand
sc config "WdNisDrv" start= demand
sc config "SecurityHealthService" start= demand
sc config "Sense" start= demand
sc config "MDCoreSvc" start= demand
sc config "WbioSrvc" start= demand
sc config "wlidsvc" start= demand
sc config "NaturalAuthentication" start= demand
sc config "NgcCtnrSvc" start= demand
sc config "NgcSvc" start= demand
sc config "SCardSvr" start= demand
sc config "ScDeviceEnum" start= demand
sc config "SCPolicySvc" start= demand
sc config "scfilter" start= demand
sc config "WindowsTrustedRT" start= demand
sc config "WindowsTrustedRTProxy" start= demand
sc config "PEAUTH" start= demand
echo Restore Security, Defender, and Authentication for File System/CPU applied successfully.