@echo off
setlocal

if "%~1"=="" goto :help
if /I "%~1"=="help" goto :help
if /I "%~1"=="-h" goto :help
if /I "%~1"=="--help" goto :help

if /I "%~1"=="install" goto :install
if /I "%~1"=="runtime" goto :runtime
if /I "%~1"=="sample" goto :sample
if /I "%~1"=="ut" goto :ut
if /I "%~1"=="uninstall" goto :uninstall

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

:install
call "%~dp0install_scripts\adc-install.bat"
exit /b %ERRORLEVEL%

:runtime
call "%~dp0install_scripts\adc-runtime.bat"
exit /b %ERRORLEVEL%

:sample
call "%~dp0install_scripts\adc-sample.bat"
exit /b %ERRORLEVEL%

:ut
call "%~dp0install_scripts\adc-ut.bat"
exit /b %ERRORLEVEL%

:uninstall
call "%~dp0install_scripts\adc-uninstall.bat"
exit /b %ERRORLEVEL%
