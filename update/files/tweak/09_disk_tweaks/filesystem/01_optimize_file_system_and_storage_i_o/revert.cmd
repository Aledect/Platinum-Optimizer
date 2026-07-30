@echo off
title By Platinum+ Optimizer

:: Restore TRIM/UNMAP to enabled
REG ADD "HKLM\System\CurrentControlSet\Control\FileSystem" /v "DisableDeleteNotification" /t REG_DWORD /d 0 /f

:: Restore random driver verification
REG ADD "HKLM\System\CurrentControlSet\Control\FileSystem" /v "DontVerifyRandomDrivers" /t REG_DWORD /d 0 /f

:: Restore legacy MAX_PATH limit
REG ADD "HKLM\System\CurrentControlSet\Control\FileSystem" /v "LongPathsEnabled" /t REG_DWORD /d 0 /f

:: Restore extended characters for 8.3 names
REG ADD "HKLM\System\CurrentControlSet\Control\FileSystem" /v "NtfsAllowExtendedCharacter8dot3Rename" /t REG_DWORD /d 1 /f

:: Restore self-healing without bugcheck
REG ADD "HKLM\System\CurrentControlSet\Control\FileSystem" /v "NtfsBugcheckOnCorrupt" /t REG_DWORD /d 0 /f

:: Restore 8.3 name creation to per-volume basis
REG ADD "HKLM\System\CurrentControlSet\Control\FileSystem" /v "NtfsDisable8dot3NameCreation" /t REG_DWORD /d 2 /f

:: Restore NTFS compression allowed
REG ADD "HKLM\System\CurrentControlSet\Control\FileSystem" /v "NtfsDisableCompression" /t REG_DWORD /d 0 /f

:: Restore default compression limit behavior
REG ADD "HKLM\System\CurrentControlSet\Control\FileSystem" /v "NtfsDisableCompressionLimit" /t REG_DWORD /d 0 /f

:: Restore NTFS EFS encryption availability
REG ADD "HKLM\System\CurrentControlSet\Control\FileSystem" /v "NtfsDisableEncryption" /t REG_DWORD /d 0 /f

:: Restore Last Access Time updates (Reverting to default enabled behavior)
REG ADD "HKLM\System\CurrentControlSet\Control\FileSystem" /v "NTFSDisableLastAccessUpdate" /t REG_DWORD /d 0 /f

:: Restore active spot corruption handling
REG ADD "HKLM\System\CurrentControlSet\Control\FileSystem" /v "NtfsDisableSpotCorruptionHandling" /t REG_DWORD /d 0 /f

:: Restore unencrypted paging file
REG ADD "HKLM\System\CurrentControlSet\Control\FileSystem" /v "NtfsEncryptPagingFile" /t REG_DWORD /d 0 /f

:: Restore default internal cache levels
REG ADD "HKLM\System\CurrentControlSet\Control\FileSystem" /v "NtfsMemoryUsage" /t REG_DWORD /d 1 /f

:: Restore default MFT Zone Reservation (200 MB)
REG ADD "HKLM\System\CurrentControlSet\Control\FileSystem" /v "NtfsMftZoneReservation" /t REG_DWORD /d 1 /f

:: Restore ReFS Last Access Time updates
REG ADD "HKLM\System\CurrentControlSet\Control\FileSystem" /v "RefsDisableLastAccessUpdate" /t REG_DWORD /d 0 /f

:: Restore symlink evaluation
REG ADD "HKLM\System\CurrentControlSet\Control\FileSystem" /v "SymlinkXToXEvaluation" /t REG_DWORD /d 1 /f

:: Restore standard modern FAT behavior
REG ADD "HKLM\System\CurrentControlSet\Control\FileSystem" /v "Win31FileSystem" /t REG_DWORD /d 0 /f

echo Restore File System and Storage I/O for Storage applied successfully.
