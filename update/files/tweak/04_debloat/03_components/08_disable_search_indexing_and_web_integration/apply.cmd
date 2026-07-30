@echo off
title By Platinum+ Optimizer

:: Disable Search Highlights (Explicitly named in PDF)
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "EnableDynamicContentInWSB" /t REG_DWORD /d 0 /f

:: Disable Dynamic Search Box (Explicitly named in PDF)
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\SearchSettings" /v "IsDynamicSearchBoxEnabled" /t REG_DWORD /d 0 /f

:: The following value names are NOT SPECIFIED in the source PDF. 
:: The exact policy descriptions from the documentation are used as placeholders.

:: Disable SafeSearch
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "Set the SafeSearch setting for Search" /t REG_DWORD /d 0 /f

:: Prevent Index on Battery
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "Prevent indexing when running on battery power to conserve energy" /t REG_DWORD /d 1 /f

:: Disable Index Usage for System File Search
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "Disable Index Usage for System File Search" /t REG_DWORD /d 1 /f

:: Disable Partial Matches
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "Find Partial Matches" /t REG_DWORD /d 0 /f

:: Exclude System Directories
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "Exclude System Directories" /t REG_DWORD /d 1 /f

:: Exclude Archived Files
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "Exclude Archived Files" /t REG_DWORD /d 1 /f

:: Disable Natural Language Search
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "Disable Natural Language Search" /t REG_DWORD /d 1 /f

:: Search Only in Indexed Locations
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "Search Only in Indexed Locations" /t REG_DWORD /d 1 /f

:: Exclude Compressed Files
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "Exclude Compressed Files" /t REG_DWORD /d 1 /f

:: Disallow Indexing of Encrypted Items
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "Disallow Indexing of Encrypted Items" /t REG_DWORD /d 1 /f

:: Disable Language Detection
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "Always use automatic language detection when indexing content and properties" /t REG_DWORD /d 0 /f

:: Prevent Querying Index Remotely
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "Prevent clients from querying the index remotely" /t REG_DWORD /d 1 /f

:: Disable Web Results in Search
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "Don?t search the web or display web results in Search" /t REG_DWORD /d 1 /f

:: Disable Web Search
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "Do not allow web search" /t REG_DWORD /d 1 /f

:: Search over metered connections (Key path not specified in PDF, applying to standard Search policy path)
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "Search over metered connections" /t REG_DWORD /d 0 /f

:: Do not allow locations on removable drives to be added to libraries
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "Do not allow locations on removable drives to be added to libraries" /t REG_DWORD /d 1 /f

:: Fully disable Search UI
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "Fully disable Search UI" /t REG_DWORD /d 1 /f

echo Disable Search Indexing and Web Integration for Storage and Network applied successfully.
