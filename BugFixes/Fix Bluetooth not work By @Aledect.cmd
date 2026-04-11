@echo off
title Fix Bluetooth not work By @Aledect
color 0a

timeout /t 3 /nobreak >nul

sc config BTAGService start= demand
sc config bthserv start= demand

timeout /t 1 /nobreak >nul

powershell -WindowStyle Hidden -NoProfile -ExecutionPolicy Bypass -Command ^
"Add-Type -AssemblyName System.Runtime.WindowsRuntime; ^
$asTaskGeneric = ([System.Runtime.WindowsRuntimeSystemExtensions].GetMethods() | Where-Object { $_.Name -eq 'AsTask' -and $_.GetParameters().Count -eq 1 -and $_.GetParameters()[0].ParameterType.Name -eq 'IAsyncOperation`1' })[0]; ^
function Await($t,$r){$m=$asTaskGeneric.MakeGenericMethod($r);$n=$m.Invoke($null,@($t));$n.Wait(-1)|Out-Null;$n.Result}; ^
if((Get-Service bthserv).Status -eq 'Stopped'){Start-Service bthserv}; ^
[Windows.Devices.Radios.Radio,Windows.System.Devices,ContentType=WindowsRuntime]|Out-Null; ^
Await ([Windows.Devices.Radios.Radio]::RequestAccessAsync()) ([Windows.Devices.Radios.RadioAccessStatus])|Out-Null; ^
$radios=Await ([Windows.Devices.Radios.Radio]::GetRadiosAsync()) ([System.Collections.Generic.IReadOnlyList[Windows.Devices.Radios.Radio]]); ^
$bt=$radios|Where-Object{$_.Kind -eq 'Bluetooth'}; ^
if($bt.State -ne 'On'){Await ($bt.SetStateAsync('On')) ([Windows.Devices.Radios.RadioAccessStatus])|Out-Null}"

echo.
echo Completed.
timeout /t 3 /nobreak >nul
shutdown /r /t 1
