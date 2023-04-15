@echo off
set pwd=%~dp0
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
netsh interface ip set address name="lan2" gateway=192.168.2.40 gwmetric=0