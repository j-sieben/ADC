@echo off
set /p InstallUser=Enter owner schema for ADC:

set "PWD=powershell.exe -Command " ^
$inputPass = read-host 'Enter password for %InstallUser%' -AsSecureString ; ^
$BSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($inputPass); ^
[System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)""
for /f "tokens=*" %%a in ('%PWD%') do set PWD=%%a

set /p SID=Enter service name for the database or PDB:

set /p ApexWorkspace=Enter name of APEX workspace:
set /p AppId=Optionally enter a new admin application ID:

set nls_lang=GERMAN_GERMANY.AL32UTF8

echo @install_scripts/install_apex.sql %ApexWorkspace% %AppId% | sqlplus %InstallUser%/%PWD%@%SID% 

@echo off