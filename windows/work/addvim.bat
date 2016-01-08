@echo off
rem	***************************************************
rem		^> File Name: addvim.bat
rem		^> Author: AoEiuV
rem		^> Mail: 490674483@qq.com
rem		^> Created Time: 2014/12/25 - 09:49:03
rem	***************************************************
echo    vim...
set env=HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment
set temp=
set VIM_HOME=D:\Program Files\tool\edit\Vim\vim74
REG ADD "%env%" /v VIM_HOME /t REG_SZ /d "%VIM_HOME%" /f
for /f "skip=1 tokens=2*" %%i in ('reg query  "%env%" /v path') do set temp=%%j
REG ADD "%env%" /v path /t REG_EXPAND_SZ /d "%%VIM_HOME%%;%temp%" /f
pause

