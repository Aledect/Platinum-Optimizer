@echo off
title By Platinum+ Optimizer
reg add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "_User_Global_VAL_SuperResolution" /t REG_DWORD /d 0 /f
reg add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "_User_Global_DAT_SuperResolution" /t REG_BINARY /d 0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 /f
reg add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "_User_Global_XEN_SuperResolution" /t REG_DWORD /d 2147483649 /f
reg add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "_User_SUB0_DFP1_VAL_Noise_Reduce" /t REG_DWORD /d 0 /f
reg add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "_User_SUB0_DFP1_XALG_Noise_Reduce" /t REG_BINARY /d 0000000000000000 /f
reg add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "_User_SUB0_DFP1_XEN_Noise_Reduce" /t REG_DWORD /d 0 /f
reg add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "_User_SUB0_DFP1_XALG_Cadence" /t REG_BINARY /d 0000000000000000 /f
reg add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "_User_SUB0_DFP1_XEN_Cadence" /t REG_DWORD /d 2147483649 /f
reg add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "_User_SUB0_DFP1_VAL_Edge_Enhance" /t REG_DWORD /d 0 /f
reg add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "_User_SUB0_DFP1_XALG_Edge_Enhance" /t REG_BINARY /d 0000000000000000 /f
reg add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "_User_SUB0_DFP1_XEN_Edge_Enhance" /t REG_DWORD /d 2147483649 /f
reg add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "_User_SUB0_DFP1_XALG_Color_Range" /t REG_BINARY /d 0000000000000000 /f
reg add "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "_User_SUB0_DFP1_XEN_Color_Range" /t REG_DWORD /d 2147483649 /f
echo Disable Video Processing Enhancements applied successfully.
