@echo off
setlocal

:: 检查是否管理员
net session >nul 2>&1
if errorlevel 1 (
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)
netsh interface set interface wlan2 enabled
netsh interface set interface lan2 disabled

set sysproxy=%pwd%../sysproxy/sysproxy.exe
%sysproxy% set 1 - - -
