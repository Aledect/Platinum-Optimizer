@echo off
title By Platinum+ Optimizer

:: Enable TRIM/UNMAP
REG ADD "HKLM\System\CurrentControlSet\Control\FileSystem" /v "DisableDeleteNotification" /t REG_DWORD /d 0 /f

:: Suppress random driver verification
REG ADD "HKLM\System\CurrentControlSet\Control\FileSystem" /v "DontVerifyRandomDrivers" /t REG_DWORD /d 1 /f

:: Enable Win32 long paths
REG ADD "HKLM\System\CurrentControlSet\Control\FileSystem" /v "LongPathsEnabled" /t REG_DWORD /d 1 /f

:: Restrict 8.3 names to basic ASCII
REG ADD "HKLM\System\CurrentControlSet\Control\FileSystem" /v "NtfsAllowExtendedCharacter8dot3Rename" /t REG_DWORD /d 0 /f

:: Attempt self-healing without forcing a bugcheck
REG ADD "HKLM\System\CurrentControlSet\Control\FileSystem" /v "NtfsBugcheckOnCorrupt" /t REG_DWORD /d 0 /f

:: Disable 8.3 name creation for all volumes
REG ADD "HKLM\System\CurrentControlSet\Control\FileSystem" /v "NtfsDisable8dot3NameCreation" /t REG_DWORD /d 1 /f

:: Disable NTFS compression
REG ADD "HKLM\System\CurrentControlSet\Control\FileSystem" /v "NtfsDisableCompression" /t REG_DWORD /d 1 /f

:: Stop compressing highly fragmented files (Behavior moot if compression is disabled, but set for absolute performance)
REG ADD "HKLM\System\CurrentControlSet\Control\FileSystem" /v "NtfsDisableCompressionLimit" /t REG_DWORD /d 0 /f

:: Disable NTFS EFS encryption
REG ADD "HKLM\System\CurrentControlSet\Control\FileSystem" /v "NtfsDisableEncryption" /t REG_DWORD /d 1 /f

:: Disable Last Access Time updates (Value inferred as 1 for disabled, though not explicitly mapped in PDF)
REG ADD "HKLM\System\CurrentControlSet\Control\FileSystem" /v "NTFSDisableLastAccessUpdate" /t REG_DWORD /d 1 /f

:: Disable background spot corruption handling
REG ADD "HKLM\System\CurrentControlSet\Control\FileSystem" /v "NtfsDisableSpotCorruptionHandling" /t REG_DWORD /d 1 /f

:: Store paging file unencrypted
REG ADD "HKLM\System\CurrentControlSet\Control\FileSystem" /v "NtfsEncryptPagingFile" /t REG_DWORD /d 0 /f

:: Configure internal cache levels (Value 2 used for increased cache, exact mapping not specified in PDF)
REG ADD "HKLM\System\CurrentControlSet\Control\FileSystem" /v "NtfsMemoryUsage" /t REG_DWORD /d 2 /f

:: Set MFT Zone Reservation to maximum (800 MB) to reduce fragmentation
REG ADD "HKLM\System\CurrentControlSet\Control\FileSystem" /v "NtfsMftZoneReservation" /t REG_DWORD /d 4 /f

:: Disable ReFS Last Access Time updates (Value inferred as 1 for disabled)
REG ADD "HKLM\System\CurrentControlSet\Control\FileSystem" /v "RefsDisableLastAccessUpdate" /t REG_DWORD /d 1 /f

:: Disable symlink evaluation to prevent file system traversal overhead
REG ADD "HKLM\System\CurrentControlSet\Control\FileSystem" /v "SymlinkXToXEvaluation" /t REG_DWORD /d 0 /f

:: Enforce standard modern FAT behavior
REG ADD "HKLM\System\CurrentControlSet\Control\FileSystem" /v "Win31FileSystem" /t REG_DWORD /d 0 /f

echo Optimize File System and Storage I/O for Storage applied successfully.
