@echo off
REM Uso: scripts\run-scan.bat https://mi-sitio.com
REM Opcional: set ZAP_PATH=C:\Program Files\ZAP\Zed Attack Proxy\zap.bat
setlocal
cd /d "%~dp0\.."

if "%~1"=="" (set "TARGET_URL=http://testphp.vulnweb.com") else (set "TARGET_URL=%~1")
set "CUR=%CD:\=/%"
set "REPORT_DIR=%CUR%/reports"

if not defined ZAP_PATH set "ZAP_PATH=C:\Program Files\ZAP\Zed Attack Proxy\zap.bat"
if not exist "%ZAP_PATH%" (
  echo No encontre zap.bat. Define ZAP_PATH con la ruta correcta.
  exit /b 1
)

echo Objetivo: %TARGET_URL%
if not exist reports mkdir reports
cd /d "%ZAP_PATH%\.." 
call "%ZAP_PATH%" -cmd -autorun "%CUR%/automation/plan.yaml"
echo Reporte: %REPORT_DIR%/zap-report.html
