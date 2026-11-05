@echo off
echo =============================================
echo  Installing Antigravity Favorite Skills (Windows)
echo =============================================

set "TARGET_DIR=%USERPROFILE%\.gemini\config\skills"
echo Creating target skills directory: %TARGET_DIR%
if not exist "%TARGET_DIR%" mkdir "%TARGET_DIR%"

set "SCRIPT_DIR=%~dp0"
set "SKILLS_DIR=%SCRIPT_DIR%skills"

if not exist "%SKILLS_DIR%" (
  echo Error: skills folder not found at %SKILLS_DIR%
  pause
  exit /b 1
)

echo Copying favorite skills to %TARGET_DIR%...
xcopy /E /I /Y "%SKILLS_DIR%\*" "%TARGET_DIR%\"

echo.
echo Installation complete!
echo Antigravity will automatically detect and load these skills on startup.
pause
