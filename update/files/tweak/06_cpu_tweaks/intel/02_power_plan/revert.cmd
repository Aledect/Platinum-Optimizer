@echo off
title By Platinum+ Optimizer
powercfg /setactive 381b4222-f694-41f0-9685-ff5bb260df2e
powercfg /delete 99999999-9999-9999-9999-999999999999 >nul 2>&1
echo Apply Platinum+ Optimizer Power Plan reverted successfully.
