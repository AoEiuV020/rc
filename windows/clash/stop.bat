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
FOR %%i IN ("%exe%") DO (
set filename=%%~nxi
)
echo 结束clash, %TIME%
taskkill /f /im %filename%


:exit
