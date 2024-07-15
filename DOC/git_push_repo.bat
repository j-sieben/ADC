@echo off
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
::::::: Einstellungen zu GIT
::
set gitexe=C:\Program Files\Git\bin\git.exe
set gitprojekt=ssh://git@git.service.zd.drv:7999/bdb-kassem/
::
::::::: Einstellungen zu Ordnern
::
:::: Basis Ordner
set current_folder=%cd%
set base_folder=C:\dev\Git_KASSEM\
:::: Unterordner fuer DB, Standard-DB, App, Standard-App und Hotfix
set folder_db=DB\
set folder_standard_db=Standard_DB\
set folder_app=Apps\
set folder_standard_app=Standard_Apps\
set folder_hotfix=DB_Einmal\
::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: 
::::::: Hauptteil
::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

call :pushrepos "%base_folder%%folder_db%"
call :pushrepos "%base_folder%%folder_standard_db%"
call :pushrepos "%base_folder%%folder_app%"
call :pushrepos "%base_folder%%folder_standard_app%"

goto :end
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::




:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: 
::::::: Push alle Repos im Ordner
::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:pushrepos
set pushrepos_folder=%~1

IF EXIST %pushrepos_folder% ( 
  cd %pushrepos_folder%

  for /D %%i in (*) do (
    cd .\%%i
    echo ++++++++++++++++++++++++++++++++++++++++
    echo ++++++++++
    echo ++++++++++ Pushe den Ordner "%pushrepos_folder%%%i" 
    echo ++++++++++
    echo ++++++++++++++++++++++++++++++++++++++++
    "%gitexe%" push
    echo .  
    cd ..
  )
) ELSE ( 
  echo ++++++++++++++++++++++++++++++++++++++++
  echo ++++++++++
  echo ++++++++++ Der Ordner "%pushrepos_folder%" ist nicht vorhanden..
  echo ++++++++++
  echo ++++++++++++++++++++++++++++++++++++++++
)

set pushrepos_folder=
goto :eof
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::



:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: 
::::::: Ende
::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:end
cd %current_folder%
echo git_push_repos.bat wird beendet
pause
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::