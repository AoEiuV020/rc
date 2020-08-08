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
for /f "eol=/ delims=" %%i in ('whoami') do set user=%%i
echo 输入当前用户 %user% 的密码以便自动设置系统代理，
set /p password=
set nssm=%pwd%..\nssm\nssm.exe
set start=%pwd%clash-service.bat
set log=%temp%\clash-log
%nssm% install clash %start%
%nssm% set clash AppStdin nul
%nssm% set clash AppStdout %log%
%nssm% set clash AppStderr %log%
%nssm% set clash AppStdoutCreationDisposition 2
%nssm% set clash AppStderrCreationDisposition 2
%nssm% set clash AppExit Default Exit
%nssm% set clash ObjectName %user% "%password%"

:end
pause
:exit
