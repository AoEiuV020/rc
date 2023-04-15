@echo off
set pwd=%~dp0
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
netsh interface set interface wlan2 enabled
netsh interface set interface lan2 disabled

set sysproxy=%pwd%../sysproxy/sysproxy.exe
%sysproxy% set 1 - - -
