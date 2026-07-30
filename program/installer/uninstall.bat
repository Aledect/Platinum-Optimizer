@echo off
echo Platinum+ Optimizer Uninstaller
echo ================================
echo.

REM Get the directory where this batch file is located
set "SCRIPT_DIR=%~dp0"

REM Define paths
set "PS_SCRIPT=%SCRIPT_DIR%uninstall.ps1"
set "TEMP_SCRIPT=%TEMP%\uninstall_platinum.ps1"

REM Check if PowerShell script exists
if not exist "%PS_SCRIPT%" (
    echo ERROR: uninstall.ps1 not found in: %SCRIPT_DIR%
    echo.
    pause
    exit /b 1
)

REM Copy PowerShell script to temp directory
echo Copying uninstall script to temp directory...
copy "%PS_SCRIPT%" "%TEMP_SCRIPT%" >nul
if errorlevel 1 (
    echo ERROR: Failed to copy script to temp directory
    echo.
    pause
    exit /b 1
)

echo Script copied successfully.
echo.

REM Execute PowerShell script from temp directory
echo Starting uninstallation...
echo.
powershell.exe -ExecutionPolicy Bypass -File "%TEMP_SCRIPT%"

REM Delete this batch file after PowerShell script starts
echo.
echo Cleaning up batch file...
del "%~f0" >nul 2>&1

exit
