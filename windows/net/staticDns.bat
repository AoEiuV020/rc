@echo off
setlocal

:: 检查是否管理员
net session >nul 2>&1
if errorlevel 1 (
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)
Netsh interface ipv4 set address name=lan2 static 192.168.2.41 mask=255.255.255.0 gateway=192.168.2.38
sleep 1
netsh interface ipv4 set dns name=lan2 static 192.168.2.40 primary
