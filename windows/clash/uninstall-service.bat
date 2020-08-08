@echo off
set pwd=%~dp0
set nssm=%pwd%..\nssm\nssm.exe
echo É¾³ý·þÎñ£¬
%nssm% remove clash confirm


:end
pause
:exit
