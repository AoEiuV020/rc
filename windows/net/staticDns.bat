@echo off
set pwd=%~dp0
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
Netsh interface ipv4 set address name=lan2 static 192.168.2.41 mask=255.255.255.0 gateway=192.168.2.38
sleep 1
netsh interface ipv4 set dns name=lan2 static 192.168.2.40 primary
