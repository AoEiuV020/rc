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
set sysproxy=%pwd%../sysproxy/sysproxy.exe
echo ����ie����
%sysproxy% global 127.0.0.1:1081 "localhost;127.*;10.*;172.16.*;172.17.*;172.18.*;172.19.*;172.20.*;172.21.*;172.22.*;172.23.*;172.24.*;172.25.*;172.26.*;172.27.*;172.28.*;172.29.*;172.30.*;172.31.*;192.168.*;<local>"
echo ����clash, %TIME%
%exe%
echo �ѽ���clash, %TIME%
echo �ر�ie����
%sysproxy% set 1 - - -


:exit
