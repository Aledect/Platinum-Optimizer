@echo off
title By Platinum+ Optimizer
reg delete "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "_User_Global_VAL_SuperResolution" /f
reg delete "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "_User_Global_DAT_SuperResolution" /f
reg delete "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "_User_Global_XEN_SuperResolution" /f
reg delete "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "_User_SUB0_DFP1_VAL_Noise_Reduce" /f
reg delete "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "_User_SUB0_DFP1_XALG_Noise_Reduce" /f
reg delete "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "_User_SUB0_DFP1_XEN_Noise_Reduce" /f
reg delete "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "_User_SUB0_DFP1_XALG_Cadence" /f
reg delete "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "_User_SUB0_DFP1_XEN_Cadence" /f
reg delete "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "_User_SUB0_DFP1_VAL_Edge_Enhance" /f
reg delete "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "_User_SUB0_DFP1_XALG_Edge_Enhance" /f
reg delete "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "_User_SUB0_DFP1_XEN_Edge_Enhance" /f
reg delete "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "_User_SUB0_DFP1_XALG_Color_Range" /f
reg delete "HKLM\System\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0000" /v "_User_SUB0_DFP1_XEN_Color_Range" /f
echo Restore Video Processing Enhancements defaults applied successfully.
