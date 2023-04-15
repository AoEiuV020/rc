@echo off
setlocal enabledelayedexpansion
set pwd=%~dp0
cd %pwd%
set me=%~nx0
if exist list del list
set files=
for /d %%i in (*) do (
    set file=%%i
    set files=!files!,!file!
)
set files=%files:~1%
for %%i in (%files%) do (
    echo ~/%%~nxi =^> %pwd%/%%i
    mklink /j %USERPROFILE%\%%~nxi %pwd%%%i
)

