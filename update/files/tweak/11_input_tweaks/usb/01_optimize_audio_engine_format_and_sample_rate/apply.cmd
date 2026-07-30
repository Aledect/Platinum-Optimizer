@echo off
title By Platinum+ Optimizer
set "ENDPOINT_GUID={YOUR-ENDPOINT-GUID}"
set "AUDIO_PATH=HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\MMDevices\Audio\Render\%ENDPOINT_GUID%\Properties"
set "HEX_DATA=4100000001000000FEFF080080BB000000B80B0010001000160010003F0600000100000000001000800000AA00389B71"

reg add "%AUDIO_PATH%" /v "{f19f064d-082c-4e27-bc73-6882a1bb8e4c},0" /t REG_BINARY /d %HEX_DATA% /f
reg add "%AUDIO_PATH%" /v "{e4870e26-3cc5-4cd2-ba46-ca0a9a70ed04},0" /t REG_BINARY /d %HEX_DATA% /f
reg add "%AUDIO_PATH%" /v "{3d6e1656-2e50-4c4c-8d85-d0acae3c6c68},3" /t REG_BINARY /d %HEX_DATA% /f
reg add "%AUDIO_PATH%" /v "{624f56de-fd24-473e-814a-de40aacaed16},3" /t REG_BINARY /d %HEX_DATA% /f
reg add "%AUDIO_PATH%" /v "{3d6e1656-2e50-4c4c-8d85-d0acae3c6c68},2" /t REG_BINARY /d %HEX_DATA% /f

echo Optimize Audio Engine Format and Sample Rate applied successfully.
