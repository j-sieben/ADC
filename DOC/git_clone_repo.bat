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
:::: Branchmodel, welches gecloned werden soll (master, release, feature)
set branch_model=feature
:::: Namen der Branches fuer Release, Feature, Standard und Hotfix
set branch_name_release=2024_Einsatz_2
set branch_name_feature=SusanneH
set branch_name_standard=2024_Einsatz_2
set branch_name_hotfix=20240605_Leerfreigabe
::
::::::: Einstellungen zu Ordnernamen
::
:::: Sortierung der Unterordner von DB und App - ja(1) oder nein(0)
set set_folder_prefix_db_sort=1
set set_folder_prefix_app_sort=1
:::: Suffix des Branch-Namens an den Repo-Ordner - ja(1) oder nein(0)
set set_folder_suffix_branch_name=0
set set_folder_suffix_hotfix_branch_name=1
::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: 
::::::: Hauptteil - :: bei gewuenschten Repos entfernen
::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:main
:: call :cloneStdAPP 601 std_AppStyleGuideStart
:: call :cloneStdAPP 600 std_AppPflege
:: call :cloneStdAPP 602 std_AppStyleGuideKomponente
:: call :cloneStdAPP 603 std_AppKonfigTool
:: call :cloneStdAPP 604 std_AppEntwicklerTools
:: call :cloneStdAPP 608 std_AppVersionshinweise
:: call :cloneStdAPP 612 std_AppPit
:: call :cloneStdAPP 615 std_AppAnwendungsVerwaltung
:: call :cloneStdAPP 627 std_AppAdc
:: call :cloneStdAPP 628 std_AppAdcBeispiel
::
:: call :cloneStdDB 01 std_util_ownerDB
:: call :cloneStdDB 02 std_apex_ownerDB
:: call :cloneStdDB 03 std_bl_ownerDB
::
:: call :cloneAPP 506 AppSct 
:: call :cloneAPP 508 AppVersionshinweise 
:: call :cloneAPP 606 AppSignatur
:: call :cloneAPP 609 AppKassenanwendungen 
:: call :cloneAPP 610 AppAnordnungsdialog 
:: call :cloneAPP 511 AppDebs 
:: call :cloneAPP 516 AppEska 
:: call :cloneAPP 518 AppReturnCode 
:: call :cloneAPP 621 AppKassenanordnungen 
:: call :cloneAPP 622 AppKaPflegedialog 
:: call :cloneAPP 525 AppKaBestandsaktualisierung
:: call :cloneAPP 530 AppPBogenVerwaltung 
:: call :cloneAPP 532 AppDetailanzeige  
:: call :cloneAPP 533 AppKvDazo 
:: call :cloneAPP 534 AppKvEazo 
:: call :cloneAPP 635 AppKvFord 
:: call :cloneAPP 636 AppKvBuch 
:: call :cloneAPP 637 AppQsDialog 
:: call :cloneAPP 538 AppHkDoku 
:: call :cloneAPP 639 AppHauptkassenTools 
:: call :cloneAPP 540 AppBerechtigungsverwaltung
:: call :cloneAPP 541 AppUdkVerwaltung   
:: call :cloneAPP 642 AppProduktionsTools 
:: call :cloneAPP 543 AppKaZuordnungen
::
:: call :cloneDB 01 ekut_ownDB 
:: call :cloneDB 01 ekut_ownDB_only_ENTW 
:: call :cloneDB 02 v226hDB 
:: call :cloneDB 03 v226DB 
:: call :cloneDB 04 v470DB 
:: call :cloneDB 05 hkdoku_ownDB 
:: call :cloneDB 10 ekasse_apexDB 
:: call :cloneDB 10 ekasse_apexDB_only_ENTW 
:: call :cloneDB 11 ekasse_restDB 
:: call :cloneDB 21 hkasse_extDB 
:: call :cloneDB 22 hkasse_batDB 
:: call :cloneDB 30 ekasse_rpaDB 
:: call :cloneDB 31 ekasse_extDB 
:: call :cloneDB 32 ekasse_batDB 
:: call :cloneDB 40 perskto_ownDB 
:: call :cloneDB 41 persktoDB 
:: call :cloneDB 50 hkasse_idm_ownDB 
:: call :cloneDB 51 hkasse_idmDB 
::
:: call :cloneHOTFIX 01 einmalekut_ownDB "Einmal_ekut_ownDB\"
:: call :cloneHOTFIX 02 einmalv226hDB "Einmal_v226hDB\"
:: call :cloneHOTFIX 03 einmalv226DB "Einmal_v226DB\"
:: call :cloneHOTFIX 04 einmalv470DB "Einmal_v470DB\"
:: call :cloneHOTFIX 05 einmalhkdoku_ownDB "Einmal_hkdoku_ownDB\"
:: call :cloneHOTFIX 10 einmalekasse_apexDB "Einmal_ekasse_apexDB\"
::
:: call :cloneInstall prepareinstall
goto :end
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::



:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: 
::::::: Clone eines Standard-DB Repos
::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:cloneStdDB
set clonestddb_sorting=%~1
set clonestddb_repo_name=%~2
set clonestddb_sub_folder=%~3

call :setbranchname "%branch_model%"
call :setfoldername "%base_folder%%folder_standard_db%%clonestddb_sub_folder%" "%set_folder_prefix_db_sort%" "%clonestddb_sorting%" "%clonestddb_repo_name%" "%set_folder_suffix_branch_name%" "%branchname%"

call :clonerepo "%foldername%" "%clonestddb_repo_name%" "%branchclonename%"

set clonestddb_sorting=
set clonestddb_repo_name=
set clonestddb_sub_folder=
goto :eof
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::



:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: 
::::::: Clone eines DB Repos
::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:cloneDB
set clonedb_sorting=%~1
set clonedb_repo_name=%~2
set clonedb_sub_folder=%~3

call :setbranchname "%branch_model%"
call :setfoldername "%base_folder%%folder_db%%clonedb_sub_folder%" "%set_folder_prefix_db_sort%" "%clonedb_sorting%" "%clonedb_repo_name%" "%set_folder_suffix_branch_name%" "%branchname%"

call :clonerepo "%foldername%" "%clonedb_repo_name%" "%branchclonename%"

set clonedb_sorting=
set clonedb_repo_name=
set clonedb_sub_folder=
goto :eof
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::



:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: 
::::::: Clone eines Standard-App Repos
::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:cloneStdAPP
set clonestd_app_app_id=%~1
set clonestdapp_repo_name=%~2
set clonestd_subfolder=%~3

call :setbranchname "%branch_model%"
call :setfoldername "%base_folder%%folder_standard_app%%clonestd_subfolder%" "%set_folder_prefix_app_sort%" "%clonestd_app_app_id%" "%clonestdapp_repo_name%" "%set_folder_suffix_branch_name%" "%branchname%"

call :clonerepo "%foldername%" "%clonestdapp_repo_name%" "%branchclonename%"

set clonestd_app_app_id=
set clonestdapp_repo_name=
set clonestd_subfolder=
goto :eof
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::



:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: 
::::::: Clone eines App Repos
::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:cloneAPP
set cloneapp_app_id=%~1
set cloneapp_repo_name=%~2
set cloneapp_subfolder=%~3

call :setbranchname "%branch_model%"
call :setfoldername "%base_folder%%folder_app%%cloneapp_subfolder%" "%set_folder_prefix_app_sort%" "%cloneapp_app_id%" "%cloneapp_repo_name%" "%set_folder_suffix_branch_name%" "%branchname%"

call :clonerepo "%foldername%" "%cloneapp_repo_name%" "%branchclonename%"

set cloneapp_app_id=
set cloneapp_repo_name=
set cloneapp_subfolder=
goto :eof
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::



:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: 
::::::: Clone eines Hotfix Repos
::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:cloneHOTFIX
set clonehotfix_sorting=%~1
set clonehotfix_repo_name=%~2
set clonehotfix_subfolder=%~3

call :setbranchname "%branch_model%"
call :setfoldername "%base_folder%%folder_hotfix%%clonehotfix_subfolder%" "%set_folder_prefix_db_sort%" "%clonehotfix_sorting%" "%clonehotfix_repo_name%" "%set_folder_suffix_hotfix_branch_name%" "%branchname%"

call :clonerepo "%foldername%" "%clonehotfix_repo_name%" "%branchclonename%"

set clonehotfix_sorting=
set clonehotfix_repo_name=
set clonehotfix_subfolder=
goto :eof
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::



:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: 
::::::: Clone pepareInstall
::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:cloneInstall
set cloneinstall_repo_name=%~1

call :setbranchname "%branch_model%"
call :setfoldername "%base_folder%%cloneapp_subfolder%" 0 "" "%cloneinstall_repo_name%" "%set_folder_suffix_branch_name%" "%branchname%"

call :clonerepo "%foldername%" "%cloneinstall_repo_name%" "%branchclonename%"

set cloneinstall_repo_name=
goto :eof
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::



:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: 
::::::: Zusammensetzen von foldername
::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:setfoldername
set setfoldername_base=%~1
set setfoldername_sorting=%~2
set setfoldername_sorting_by=%~3
set setfoldername_repo_name=%~4
set setfoldername_suffix_branchname=%~5
set setfoldername_branchname=%~6

set foldername=%setfoldername_base%
IF "%setfoldername_sorting%" EQU "1" set foldername=%foldername%%setfoldername_sorting_by%_
set foldername=%foldername%%setfoldername_repo_name%
IF "%setfoldername_suffix_branchname%" EQU "1" set foldername=%foldername%_%setfoldername_branchname%

set setfoldername_base=
set setfoldername_sorting=
set setfoldername_sorting_by=
set setfoldername_repo_name=
set setfoldername_suffix_branchname=
set setfoldername_branchname=
goto :eof
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::



:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: 
::::::: Zusammensetzen von branchname
::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:setbranchname
set setbranchname_model=%~1

IF "%setbranchname_model%" EQU "master" set branchname=master
IF "%setbranchname_model%" EQU "release" set branchname=%branch_name_release%
IF "%setbranchname_model%" EQU "feature" set branchname=%branch_name_feature%
IF "%setbranchname_model%" EQU "hotfix" set branchname=%branch_name_hotfix%
IF "%setbranchname_model%" EQU "standard" set branchname=%branch_name_standard%

IF "%setbranchname_model%" EQU "master" set branchclonename=master
IF "%setbranchname_model%" EQU "release" set branchclonename=release/%branch_name_release%
IF "%setbranchname_model%" EQU "feature" set branchclonename=feature/%branch_name_feature%
IF "%setbranchname_model%" EQU "hotfix" set branchclonename=hotfix/%branch_name_hotfix%
IF "%setbranchname_model%" EQU "standard" set branchclonename=standard/%branch_name_standard%

set setbranchname_model=
goto :eof
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::



:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: 
::::::: Clone eines Repos
::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:clonerepo
set clonerepo_folder=%~1
set clonerepo_repo_name=%~2
set clonerepo_branch=%~3

IF EXIST %clonerepo_folder% ( 
  echo ++++++++++++++++++++++++++++++++++++++++
  echo ++++++++++
  echo ++++++++++ Das Repository "%clonerepo_repo_name%" kann nicht geklont werden, da der Ordner "%clonerepo_folder%" schon vorhanden ist..
  echo ++++++++++
  echo ++++++++++++++++++++++++++++++++++++++++
  
) ELSE ( 
  
  echo ++++++++++++++++++++++++++++++++++++++++
  echo ++++++++++
  echo ++++++++++ Clone den Branch "%clonerepo_branch%" vom Repository "%clonerepo_repo_name%" in den Ordner "%clonerepo_folder%"
  echo ++++++++++
  echo ++++++++++++++++++++++++++++++++++++++++
  call "%gitexe%" clone %gitprojekt%%clonerepo_repo_name%.git "%clonerepo_folder%" --branch "%clonerepo_branch%"
)
goto :eof
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::



:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: 
::::::: Ende
::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:end
echo git_clone_repos.bat wird beendet
pause
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::