@echo off
setlocal

if "%~1"=="" goto :help
if /I "%~1"=="help" goto :help
if /I "%~1"=="-h" goto :help
if /I "%~1"=="--help" goto :help

if /I "%~1"=="install" call "%~dp0install_scripts\adc-install.bat" & goto :eof
if /I "%~1"=="runtime" call "%~dp0install_scripts\adc-runtime.bat" & goto :eof
if /I "%~1"=="sample" call "%~dp0install_scripts\adc-sample.bat" & goto :eof
if /I "%~1"=="ut" call "%~dp0install_scripts\adc-ut.bat" & goto :eof
if /I "%~1"=="uninstall" call "%~dp0install_scripts\adc-uninstall.bat" & goto :eof

echo Unknown command: %~1
goto :help

:help
echo Usage: adc.bat ^<command^>
echo.
echo Commands:
echo   install     Install core, plugin and ADC admin app
echo   runtime     Install core and plugin without the admin app
echo   sample      Install the sample application
echo   ut          Install unit tests
echo   uninstall   Uninstall ADC including the admin app
echo   help        Show this help
exit /b 1
