@echo off
title By Platinum+ Optimizer
reg add "HKLM\System\CurrentControlSet\Services\nvlddmkm\Global\NVTweak" /v "NvCplPhysxAuto" /t REG_DWORD /d 0 /f
reg add "HKLM\System\CurrentControlSet\Services\nvlddmkm\NVAPI" /v "physxGpuId" /t REG_BINARY /d 00070000 /f
reg add "HKLM\System\CurrentControlSet\Services\nvlddmkm\Global\NVTweak" /v "RmProfilingAdminOnly" /t REG_DWORD /d 1 /f
reg add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "RmProfilingAdminOnly" /t REG_DWORD /d 1 /f
echo Optimize NVIDIA PhysX and Performance Counters applied successfully.
