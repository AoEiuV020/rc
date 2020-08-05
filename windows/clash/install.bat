@echo off
set pwd=%~dp0
set exe=
if exist %pwd%path (
for /f "eol=/ delims=" %%i in (%pwd%path) do set exe=%%i
)
if "x%exe%" == "x" (
echo 输入clash可执行文件全路径，支持拖动，
set /p exe=
)
if not exist %exe% (
echo 文件不存在，
if exist %pwd%path (
del %pwd%path
)
call %0
goto :exit
) else (
echo %exe% > %pwd%path
)
set env=HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run
set launch=%pwd%launch.vbs
set start=%pwd%start.bat
set log=%pwd%log
echo 设置开机自启，
REG ADD  "%env%" /v clash /t REG_SZ /d "%launch:"=\"% %start:"=\"% > %log:"=\"%" /f

:end
pause
:exit
