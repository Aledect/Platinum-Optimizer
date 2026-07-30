@echo off
title By Platinum+ Optimizer
powercfg /import "%~dp0AMDCPU.pow" 88888888-8888-8888-8888-888888888888 >nul 2>&1
powercfg /setactive 88888888-8888-8888-8888-888888888888
echo Apply Platinum+ Optimizer Power Plan applied successfully.
