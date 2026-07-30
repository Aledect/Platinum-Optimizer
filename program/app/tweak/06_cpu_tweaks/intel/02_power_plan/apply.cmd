@echo off
title By Platinum+ Optimizer
powercfg /import "%~dp0INTELCPU.pow" 99999999-9999-9999-9999-999999999999 >nul 2>&1
powercfg /setactive 99999999-9999-9999-9999-999999999999
echo Apply Platinum+ Optimizer Power Plan applied successfully.
