@echo off
set pwd=%~dp0
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
Netsh interface ipv4 set address name=lan2 static 192.168.2.41 mask=255.255.255.0 gateway=192.168.2.38
sleep 1
netsh interface ipv4 set dns name=lan2 static 192.168.0.1 primary
netsh interface ipv4 add dns name=lan2 223.5.5.5 index=2
