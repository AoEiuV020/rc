@echo off
set pwd=%~dp0
set exe=
if exist %pwd%path (
for /f "eol=/ delims=" %%i in (%pwd%path) do set exe=%%i
)
if "x%exe%" == "x" (
echo �Ҳ�����ִ�г���·��Ӧ���������ļ�%pwd%path�£�
exit /b 1
)
if not exist %exe% (
echo �ļ������ڣ�%exe%
exit /b 2
)
set sysproxy=%pwd%../sysproxy/sysproxy.exe
echo ����ie����
%sysproxy% set 3 127.0.0.1:1081 - -
echo ����clash, %TIME%
%exe%
echo �ѽ���clash, %TIME%
echo �ر�ie����
%sysproxy% set 1 - - -


:exit
