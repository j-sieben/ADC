@echo off
setlocal
set "ADC_VERSION="
set "ADC_GIT_COMMIT="

set "ADC_VERSION_FILE=%TEMP%\adc-version-%RANDOM%-%RANDOM%.tmp"
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0version.ps1" -OutputPath "%ADC_VERSION_FILE%"
if errorlevel 1 exit /b 1
for /f "usebackq tokens=1,* delims==" %%A in ("%ADC_VERSION_FILE%") do set "%%A=%%B"
del "%ADC_VERSION_FILE%"
if not defined ADC_VERSION exit /b 1
if not defined ADC_GIT_COMMIT exit /b 1

set /p InstallUser=Enter APEX workspace schema for ADC:

set "OWNER_PWD_CMD=powershell.exe -Command " ^
$inputPass = read-host 'Enter password for %InstallUser%' -AsSecureString ; ^
$BSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($inputPass); ^
[System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)""
for /f "tokens=*" %%a in ('%OWNER_PWD_CMD%') do set OWNER_PWD=%%a

set /p SID=Enter service name for the database or PDB:

set nls_lang=GERMAN_GERMANY.AL32UTF8

cd /d "%~dp0.."
sqlplus -L "%InstallUser%/%OWNER_PWD%@%SID%" @install_scripts/install_runtime.sql "%ADC_VERSION%" "%ADC_GIT_COMMIT%"
exit /b %ERRORLEVEL%
