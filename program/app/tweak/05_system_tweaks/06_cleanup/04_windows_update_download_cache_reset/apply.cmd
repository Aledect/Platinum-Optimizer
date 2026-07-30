@echo off
title By Platinum+ Optimizer

net session >nul 2>&1 || exit /b 1

echo WARNING: This stops Windows Update services and deletes downloaded update files.
set /p CONFIRM=Type YES to continue: 
if /i not "%CONFIRM%"=="YES" exit /b 0

net stop UsoSvc /y >nul 2>&1
net stop wuauserv /y >nul 2>&1
net stop bits /y >nul 2>&1

if exist "%SystemRoot%\SoftwareDistribution\Download" (
    del /f /s /q "%SystemRoot%\SoftwareDistribution\Download\*" >nul 2>&1
    for /d %%D in ("%SystemRoot%\SoftwareDistribution\Download\*") do rd /s /q "%%D" >nul 2>&1
)

net start bits >nul 2>&1
net start wuauserv >nul 2>&1
net start UsoSvc >nul 2>&1

echo Done. Open Windows Update and check for updates again.
