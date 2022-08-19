@echo off
set pwd=%~dp0
set sysproxy=%pwd%../sysproxy/sysproxy.exe
%sysproxy% set 1 - - -
