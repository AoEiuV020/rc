@echo off
setlocal

:: 检查是否管理员
net session >nul 2>&1
if errorlevel 1 (
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)
netsh interface ip set address name="lan2" gateway=192.168.2.40 gwmetric=0