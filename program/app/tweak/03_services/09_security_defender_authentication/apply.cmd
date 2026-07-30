@echo off
title By Platinum+ Optimizer
sc config "WinDefend" start= disabled
sc stop "WinDefend"
sc config "MsSecCore" start= disabled
sc stop "MsSecCore"
sc config "wscsvc" start= disabled
sc stop "wscsvc"
sc config "WdFilter" start= disabled
sc stop "WdFilter"
sc config "WdBoot" start= disabled
sc stop "WdBoot"
sc config "WdNisSvc" start= disabled
sc stop "WdNisSvc"
sc config "WdNisDrv" start= disabled
sc stop "WdNisDrv"
sc config "SecurityHealthService" start= disabled
sc stop "SecurityHealthService"
sc config "Sense" start= disabled
sc stop "Sense"
sc config "MDCoreSvc" start= disabled
sc stop "MDCoreSvc"
sc config "WbioSrvc" start= disabled
sc stop "WbioSrvc"
sc config "wlidsvc" start= disabled
sc stop "wlidsvc"
sc config "NaturalAuthentication" start= disabled
sc stop "NaturalAuthentication"
sc config "NgcCtnrSvc" start= disabled
sc stop "NgcCtnrSvc"
sc config "NgcSvc" start= disabled
sc stop "NgcSvc"
sc config "SCardSvr" start= disabled
sc stop "SCardSvr"
sc config "ScDeviceEnum" start= disabled
sc stop "ScDeviceEnum"
sc config "SCPolicySvc" start= disabled
sc stop "SCPolicySvc"
sc config "scfilter" start= disabled
sc stop "scfilter"
sc config "WindowsTrustedRT" start= disabled
sc stop "WindowsTrustedRT"
sc config "WindowsTrustedRTProxy" start= disabled
sc stop "WindowsTrustedRTProxy"
sc config "PEAUTH" start= disabled
sc stop "PEAUTH"
echo Disable Security, Defender, and Authentication for File System/CPU applied successfully.