@echo off
set pwd=%~dp0
set exe=
if exist %pwd%path (
for /f "eol=/ delims=" %%i in (%pwd%path) do set exe=%%i
)
if "x%exe%" == "x" (
echo �Ҳ�����ִ�г���·��Ӧ���������ļ�%pwd%path�£�
goto :exit
)
if not exist %exe% (
echo �ļ������ڣ�%exe%
goto :exit
)
FOR %%i IN ("%exe%") DO (
set filename=%%~nxi
)
echo ����clash, %TIME%
taskkill /f /im %filename%


:exit
