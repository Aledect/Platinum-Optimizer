@echo off
title 02 - Temp and Crash Dump Cleanup

net session >nul 2>&1 || exit /b 1

pushd "%SystemRoot%"

call :clean "%SystemRoot%\Temp"
call :clean "%TEMP%"

for /d %%U in ("%SystemDrive%\Users\*") do (
    call :clean "%%~U\AppData\Local\Temp"
    call :clean "%%~U\AppData\Local\CrashDumps"
)

if exist "%SystemRoot%\Minidump" del /f /q "%SystemRoot%\Minidump\*" >nul 2>&1
if exist "%SystemRoot%\MEMORY.DMP" del /f /q "%SystemRoot%\MEMORY.DMP" >nul 2>&1

popd

echo Done. Reboot recommended.

exit /b 0

:clean
if not exist "%~1" exit /b 0
del /f /s /q "%~1\*" >nul 2>&1
for /d %%D in ("%~1\*") do rd /s /q "%%D" >nul 2>&1
exit /b 0
