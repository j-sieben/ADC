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
::::::: Einstellungen zu Branches
::
:::: Branchmodel, welches gepullt werden soll (master, release, feature)
set branch_model=feature
:::: Namen der Branches fuer Release und Standard
set branch_name_release=2024_Einsatz_2
set branch_name_standard=2024_Einsatz_2
::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: 
::::::: Hauptteil
::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

call :setbranchname "%branch_model%"
call :pullrepos "%base_folder%%folder_db%" "%branchname%"

call :setbranchname "standard" "%branch_model%"
call :pullrepos "%base_folder%%folder_standard_db%" "%branchname%"

call :setbranchname "%branch_model%"
call :pullrepos "%base_folder%%folder_app%" "%branchname%"

call :setbranchname "standard" "%branch_model%"
call :pullrepos "%base_folder%%folder_standard_app%" "%branchname%"

goto :end
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::



:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: 
::::::: Zusammensetzen von branchname
::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:setbranchname
set setbranchname_model=%~1
set setbranchname_alternative=%~2

IF "%setbranchname_model%" EQU "master" set branchname=master
IF "%setbranchname_model%" EQU "release" set branchname=master
IF "%setbranchname_model%" EQU "feature" set branchname=release/%branch_name_release%
IF "%setbranchname_model%" EQU "standard" set branchname=standard/%branch_name_standard%
IF "%setbranchname_model%" EQU "standard" IF "%setbranchname_alternative%" EQU "master" set branchname=master

set setbranchname_model=
goto :eof

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: 
::::::: Pull alle Repos im Ordner
::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:pullrepos
set pullrepos_folder=%~1
set pullrepos_branchname=%~2

IF EXIST %pullrepos_folder% ( 
  cd %pullrepos_folder%

  for /D %%i in (*) do (
    cd .\%%i
    echo ++++++++++++++++++++++++++++++++++++++++
    echo ++++++++++
    echo ++++++++++ Pull den Branch "%pullrepos_branchname%" vom Repository "%%i"
    echo ++++++++++
    echo ++++++++++++++++++++++++++++++++++++++++
    "%gitexe%" pull origin %pullrepos_branchname% 
    echo .  
    cd ..
  )
) ELSE ( 
  echo ++++++++++++++++++++++++++++++++++++++++
  echo ++++++++++
  echo ++++++++++ Der Ordner "%pullrepos_folder%" ist nicht vorhanden..
  echo ++++++++++
  echo ++++++++++++++++++++++++++++++++++++++++
)

set pullrepos_folder=
goto :eof


:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: 
::::::: Ende
::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:end
cd %current_folder%
echo git_pull_branch.bat wird beendet
pause
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
