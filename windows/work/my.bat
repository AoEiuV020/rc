@echo off
rem	***************************************************
rem		^> File Name: my.bat
rem		^> Author: AoEiuV020
rem		^> Mail: 490674483@qq.com
rem		^> Created Time: 2015/06/17 - 17:38:14
rem	***************************************************
set my=%~dp0
set old_path=%cd%
set args=%2 %3 %4 %5 %6 %7 %8 %9
set local=%localappdata%\MyWork
if not exist %local% (
mkdir "%local%"
xcopy /e %my%\local_example %local%
notepad %local%\properties.txt
)
rem setlocal enabledelayedexpansion
for /f "eol=/ delims=" %%i in (%local%\properties.txt) do set %%i
rem if "%1"=="" (goto add) 
goto %1
goto end

:edit
vim %~f0
goto end

:properties
vim %local%\properties.txt
goto end

:save
xcopy /ey %local% %my%\local_example
goto end

:java
echo 		Working with java,
set JAVA_HOME=%JAVA_HOME%\
set lib=%JAVA_HOME%lib;%lib%
set include=%JAVA_HOME%include;%include%
set path=%JAVA_HOME%bin;%path%
call %0 gradle
goto end

:jadx
echo 		Working with jadx,
set lib=%JADX_HOME%\lib;%lib%
set path=%JADX_HOME%\bin;%path%
goto end

:mingw
echo 		Working with MinGW,
set lib=%MinGW_HOME%\lib;%lib%
set include=%MinGW_HOME%\include;%include%
set path=%MinGW_HOME%\bin;%path%
goto end

:jni
call %0 java
call %0 mingw 64
goto end

:flutter
echo 		Working with flutter,
call %0 android
set path=%FLUTTER_HOME%\bin;%path%
set PUB_HOSTED_URL=https://pub.flutter-io.cn
set FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
goto end

:android
call %0 adb
call %0 java
call %0 ant
call %0 sdk
call %0 ndk
goto end

:adb
echo 		Android Debug Bridge,
set path=%ADB_HOME%;%path%
goto end

:ant
echo 		Working with android ant,
set path=%ANT_HOME%\bin;%path%
goto end

:sdk
echo 		Working with android sdk,
set SDK_TOOLS=%SDK_HOME%\tools
set SDK_BUILD_TOOLS=%SDK_HOME%\build-tools\19.1.0
set path=%SDK_BUILD_TOOLS%;%SDK_TOOLS%;%path%
goto end

:ndk
echo 		Working with android ndk,
set path=%NDK_HOME%;%path%
goto end

:jadx
echo 		Working with jadx,
set path=%JADX_HOME%\bin;%path%
goto end

:apktool
echo 		Working with apktool,
call %0 java
set path=%APKTOOL_HOME%;%path%
goto end

:msys
echo 		Working with msys,
set path=%MSYS_HOME%;%path%
msys2
goto exit

:cmder
echo 		Working with cmder,
set path=%CMDER_HOME%\;%path%
cmder
goto exit

:shell
echo 		Working with shell,
set path=%SHELL_HOME%\usr\bin;%path%
goto end

:putty
echo 		SSH with putty,
echo 		putty -ssh aoeiuv020.top -l aoeiuv -pw aoeiuv
echo		psftp aoeiuv@aoeiuv020.top -pw aoeiuv
set path=%PUTTY_HOME%;%path%
goto end

:main
call %0 putty
start putty -load main
goto end

:linux
call %0 putty
start /b linux
goto end

:add
echo 		add my.bat,
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
echo 		add vim,
%VIM_HOME%/install.exe
goto end

:addreg
echo 		add reg,
regedit cmd.reg
regedit gvim.reg
::regedit utc.reg
goto end

:aria
echo 		aria2c,
set path=%ARIA_HOME%;%path%
cd /d %ARIA_DOWNLOAD%
goto end

:cs
echo		c# csharp,
call %VSTOOLS_HOME%\VsDevCmd.bat
goto end

:gradle
echo 		gradle,
set lib=%GRADLE_HOME%\lib;%lib%
set path=%GRADLE_HOME%\bin;%path%
goto end

:ffmpeg
echo 		ffmpeg,
set path=%FFMPEG_HOME%\bin;%path%
goto end

:ldd
echo 		ldd,
call %0 shell
set path=%LDD_HOME%;%path%
goto end


:exit
exit
:end
