@echo off
set pwd=%~dp0
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
netsh interface set interface WLAN disabled
netsh interface set interface ÒÔÌ«Íø enabled

set sysproxy=%pwd%../sysproxy/sysproxy.exe
%sysproxy% set 3 192.168.2.1:1081 - -
