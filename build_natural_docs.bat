@echo off
setlocal

set "PROJECT_DIR=%~dp0ND"
set "OUTPUT_DIR=%~dp0Docs\api_doc"

if exist "%ProgramFiles%\Natural Docs\NaturalDocs.exe" (
  set "ND_CMD=%ProgramFiles%\Natural Docs\NaturalDocs.exe"
) else (
  if exist "%ProgramFiles(x86)%\Natural Docs\NaturalDocs.exe" (
    set "ND_CMD=%ProgramFiles(x86)%\Natural Docs\NaturalDocs.exe"
  ) else (
    where /Q NaturalDocs.exe
    if not errorlevel 1 (
      set "ND_CMD=NaturalDocs.exe"
    ) else (
      where /Q naturaldocs
      if not errorlevel 1 (
        set "ND_CMD=naturaldocs"
      ) else (
        echo Natural Docs executable not found.
        echo Install Natural Docs or add it to PATH, then rerun this script.
        exit /b 1
      )
    )
  )
)

if not exist "%OUTPUT_DIR%" mkdir "%OUTPUT_DIR%"

echo Building Natural Docs into "%OUTPUT_DIR%"...
"%ND_CMD%" -p "%PROJECT_DIR%"
if errorlevel 1 exit /b %errorlevel%

echo Natural Docs build completed.
