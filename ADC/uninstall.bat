cls
@echo off
set /p InstallUser=Enter APEX workspace schema for ADC:

set "PWD=powershell.exe -Command " ^
$inputPass = read-host 'Enter password for %InstallUser%' -AsSecureString ; ^
$BSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($inputPass); ^
[System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)""
for /f "tokens=*" %%a in ('%PWD%') do set PWD=%%a

set /p SID=Enter service name for the database or PDB:

set /p ApexWorkspace=Enter name of APEX workspace:
set /p AppId=Enter the admin application ID:

set nls_lang=GERMAN_GERMANY.AL32UTF8

sqlplus %InstallUser%/%PWD%@%SID% @install_scripts/uninstall_apex.sql %ApexWorkspace% %AppId%

@echo off