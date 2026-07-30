@echo off
title By Platinum+ Optimizer

:: Restore Search Highlights
REG DELETE "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "EnableDynamicContentInWSB" /f

:: Restore Dynamic Search Box
REG DELETE "HKCU\Software\Microsoft\Windows\CurrentVersion\SearchSettings" /v "IsDynamicSearchBoxEnabled" /f

:: Restore placeholder policy values
REG DELETE "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "Set the SafeSearch setting for Search" /f
REG DELETE "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "Prevent indexing when running on battery power to conserve energy" /f
REG DELETE "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "Disable Index Usage for System File Search" /f
REG DELETE "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "Find Partial Matches" /f
REG DELETE "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "Exclude System Directories" /f
REG DELETE "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "Exclude Archived Files" /f
REG DELETE "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "Disable Natural Language Search" /f
REG DELETE "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "Search Only in Indexed Locations" /f
REG DELETE "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "Exclude Compressed Files" /f
REG DELETE "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "Disallow Indexing of Encrypted Items" /f
REG DELETE "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "Always use automatic language detection when indexing content and properties" /f
REG DELETE "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "Prevent clients from querying the index remotely" /f
REG DELETE "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "Don?t search the web or display web results in Search" /f
REG DELETE "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "Do not allow web search" /f
REG DELETE "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "Search over metered connections" /f
REG DELETE "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "Do not allow locations on removable drives to be added to libraries" /f
REG DELETE "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "Fully disable Search UI" /f

echo Restore Search Indexing and Web Integration for Storage and Network applied successfully.
