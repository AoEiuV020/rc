@echo off
rem	***************************************************
rem		^> File Name: my.bat
rem		^> Author: AoEiuV020
rem		^> Mail: 490674483@qq.com
rem		^> Created Time: 2015/06/17 - 17:38:14
rem	***************************************************
set my=%~dp0
set args=%2 %3 %4 %5 %6 %7 %8 %9
set JAVA_HOME=D:\Development\Java\jdk1.8.0_40\
set MinGW_HOME=D:\Development\MinGW%2
set ANDROID_HOME=D:\Development\Android\android
set SDK_HOME=D:\Development\Android\sdk
set NDK_HOME=D:\Development\Android\ndk
set ANT_HOME=D:\Development\Android\ant
set MSYS_HOME=D:\Development\msys64
set ADB_HOME=D:\Android\adb
set PUTTY_HOME=D:\Development\SSH\putty
rem if "%1"=="" (goto add) 
goto %1
goto end

:edit
vim %~f0
goto end

:java
echo 		Working with java...
set lib=%JAVA_HOME%\lib;%lib%
set include=%JAVA_HOME%\include;%include%
set path=%JAVA_HOME%\bin;%path%
goto end

:mingw
echo 		Working with MinGW...
set mf=D:\Development\Code\makefile
set lib=%MinGW_HOME%\lib;%lib%
set include=%MinGW_HOME%\include;%include%
set path=%MinGW_HOME%\bin;%path%
goto end

:jni
call %0 java
call %0 mingw 64
goto end

:android
call %0 adb
call %0 java
call %0 ant
call %0 sdk
call %0 ndk
goto end

:adb
echo 		Android Debug Bridge...
set path=%ADB_HOME%;%path%
goto end

:ant
echo 		Working with android ant...
set path=%ANT_HOME%\bin;%path%
goto end

:sdk
echo 		Working with android sdk...
set SDK_TOOLS=%SDK_HOME%\tools
set SDK_BUILD_TOOLS=%SDK_HOME%\build-tools\19.1.0
set path=%SDK_BUILD_TOOLS%;%SDK_TOOLS%;%path%
goto end

:ndk
echo 		Working with android ndk...
set path=%NDK_HOME%;%path%
goto end

:msys
echo 		Working with msys...
echo msys2_shell %args%
call %MSYS_HOME%\msys2_shell %args%
goto end

:putty
echo 		SSH with putty...
echo 		putty -ssh aoeiuv020.top -l aoeiuv -pw aoeiuv
echo		psftp aoeiuv@aoeiuv020.top -pw aoeiuv
set path=%PUTTY_HOME%;%path%
goto end

:add
echo 		add my.bat...
set env=HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment
set temp=
set MYWORK_HOME=%~dp0
set MYWORK_HOME=%MYWORK_HOME:~0,-1%
REG ADD  "%env%" /v MYWORK_HOME /t REG_SZ /d "%MYWORK_HOME%" /f
for /f "skip=1 tokens=2*" %%i in ('reg query  "%env%" /v path') do set temp=%%j
REG ADD  "%env%" /v path /t REG_EXPAND_SZ /d "%%MYWORK_HOME%%;%temp%" /f
call %0 addvim
call %0 addreg
goto end

:addvim
echo 		add vim...
set VIM_HOME=D:\Program Files\tool\edit\Vim\vim74
REG ADD "%env%" /v VIM_HOME /t REG_SZ /d "%VIM_HOME%" /f
for /f "skip=1 tokens=2*" %%i in ('reg query  "%env%" /v path') do set temp=%%j
REG ADD "%env%" /v path /t REG_EXPAND_SZ /d "%%VIM_HOME%%;%temp%" /f
goto end

:addreg
echo 		add reg...
regedit cmd.reg
regedit gvim.reg
goto end

:exit
exit
:end
