@echo off
title By Platinum+ Optimizer

setlocal
set ELEV=0
net session >nul 2>&1 && set ELEV=1

if "%ELEV%"=="1" (
    for /d %%U in ("%SystemDrive%\Users\*") do (
        call :clean "%%~U\AppData\Local\D3DSCache"
        call :clean "%%~U\AppData\Local\NVIDIA\DXCache"
        call :clean "%%~U\AppData\Local\NVIDIA\GLCache"
        call :clean "%%~U\AppData\Local\NVIDIA\OptixCache"
        call :clean "%%~U\AppData\Local\AMD\DxCache"
        call :clean "%%~U\AppData\Local\AMD\GLCache"
        call :clean "%%~U\AppData\Local\AMD\OglCache"
        call :clean "%%~U\AppData\Local\Intel\ShaderCache"
        call :clean "%%~U\AppData\Local\Intel\GLCache"
    )
) else (
    call :clean "%LOCALAPPDATA%\D3DSCache"
    call :clean "%LOCALAPPDATA%\NVIDIA\DXCache"
    call :clean "%LOCALAPPDATA%\NVIDIA\GLCache"
    call :clean "%LOCALAPPDATA%\NVIDIA\OptixCache"
    call :clean "%LOCALAPPDATA%\AMD\DxCache"
    call :clean "%LOCALAPPDATA%\AMD\GLCache"
    call :clean "%LOCALAPPDATA%\AMD\OglCache"
    call :clean "%LOCALAPPDATA%\Intel\ShaderCache"
    call :clean "%LOCALAPPDATA%\Intel\GLCache"
)

echo Done. Restart PC if games show graphical issues.

exit /b 0

:clean
if not exist "%~1" exit /b 0
del /f /s /q "%~1\*" >nul 2>&1
for /d %%D in ("%~1\*") do rd /s /q "%%D" >nul 2>&1
exit /b 0
