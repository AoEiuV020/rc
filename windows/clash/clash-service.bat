@echo off
set pwd=%~dp0
set exe=
if exist %pwd%path (
for /f "eol=/ delims=" %%i in (%pwd%path) do set exe=%%i
)
if "x%exe%" == "x" (
echo 找不到可执行程序，路径应当保存在文件%pwd%path下，
goto :exit
)
if not exist %exe% (
echo 文件不存在，%exe%
goto :exit
)
set sysproxy=%pwd%../sysproxy/sysproxy.exe
echo 设置ie代理，
%sysproxy% global 127.0.0.1:1081 "localhost;127.*;10.*;172.16.*;172.17.*;172.18.*;172.19.*;172.20.*;172.21.*;172.22.*;172.23.*;172.24.*;172.25.*;172.26.*;172.27.*;172.28.*;172.29.*;172.30.*;172.31.*;192.168.*;<local>"
echo 启动clash, %TIME%
%exe%
echo 已结束clash, %TIME%
echo 关闭ie代理，
%sysproxy% set 1 - - -


:exit
