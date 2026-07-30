@echo off
title By Platinum+ Optimizer
reg add "HKLM\System\CurrentControlSet\Services\nvlddmkm\Global\NVTweak" /v "NvCplPhysxAuto" /t REG_DWORD /d 1 /f
reg delete "HKLM\System\CurrentControlSet\Services\nvlddmkm\NVAPI" /v "physxGpuId" /f
reg add "HKLM\System\CurrentControlSet\Services\nvlddmkm\Global\NVTweak" /v "RmProfilingAdminOnly" /t REG_DWORD /d 0 /f
reg add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmProfilingAdminOnly" /t REG_DWORD /d 0 /f
echo Restore NVIDIA PhysX and Performance Counters defaults applied successfully.
