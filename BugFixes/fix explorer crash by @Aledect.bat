@echo off
title Reset Explorer - Full Fix
color 0A

:: Start
echo Starting Explorer reset

:: Stop Explorer
echo Stopping Explorer
taskkill /f /im explorer.exe >nul 2>&1
timeout /t 2 >nul

:: Clear icon cache
echo Clearing icon cache
del /a /q "%localappdata%\IconCache.db" >nul 2>&1
del /a /f /q "%localappdata%\Microsoft\Windows\Explorer\iconcache*" >nul 2>&1

:: Clear thumbnail cache
echo Clearing thumbnail cache
del /a /f /q "%localappdata%\Microsoft\Windows\Explorer\thumbcache*" >nul 2>&1

:: Re-register core Explorer DLLs
echo Re-registering core DLLs
for %%i in (shell32.dll explorerframe.dll actxprxy.dll) do regsvr32 /s %%i

:: Check Explorer system file
echo Checking Explorer system file
sfc /scanfile=%SystemRoot%\explorer.exe

:: Full system file check
echo Performing full system file check
sfc /scannow

:: Restore Windows image
echo Restoring Windows image (DISM)
DISM /Online /Cleanup-Image /RestoreHealth

:: Restart Explorer
echo Restarting Explorer
start explorer.exe

:: End
echo Reset completed
pause
