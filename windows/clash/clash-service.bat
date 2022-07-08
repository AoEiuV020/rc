@echo off
set pwd=%~dp0
set exe=
if exist %pwd%path (
for /f "eol=/ delims=" %%i in (%pwd%path) do set exe=%%i
)
if "x%exe%" == "x" (
echo 找不到可执行程序，路径应当保存在文件%pwd%path下，
exit /b 1
)
if not exist %exe% (
echo 文件不存在，%exe%
exit /b 2
)
set sysproxy=%pwd%../sysproxy/sysproxy.exe
echo 设置ie代理，
%sysproxy% set 3 127.0.0.1:1081 - -
echo 启动clash, %TIME%
%exe%
echo 已结束clash, %TIME%
echo 关闭ie代理，
%sysproxy% set 1 - - -


:exit
