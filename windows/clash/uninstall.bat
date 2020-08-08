@echo off
set pwd=%~dp0
set env=HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run
REG delete  "%env%" /v clash /f

:end
pause
:exit
