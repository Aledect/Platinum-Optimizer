@echo off
title By Platinum+ Optimizer
reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm\Scene" /v "EnableBloom" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm\Scene" /v "EnableDrawToBackbuffer" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm\Scene" /v "EnableImageProcessing" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm\Scene" /v "EnableShadow" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm\Scene" /v "ImageProcessing8bit" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm\Scene" /v "ImageProcessingMinHeight" /t REG_DWORD /d 200 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm\Scene" /v "ImageProcessingMinWidth" /t REG_DWORD /d 200 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm\Scene" /v "ImageProcessingResizeGrowth" /t REG_DWORD /d 200 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm\Scene" /v "MsaaQualityMode" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm\Scene" /v "SceneVisualCutoffCountOfConsecutiveIncidentsAllowed" /t REG_DWORD /d 5 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm\Scene" /v "SceneVisualCutoffThresholdInMS" /t REG_DWORD /d 1000 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm\Scene" /v "ForceNonPrimaryDisplayAdapter" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm\Scene" /v "ImageProcessingResizeThreshold" /t REG_DWORD /d 0 /f
echo Optimize DWM Scene and MSAA Quality applied successfully.
