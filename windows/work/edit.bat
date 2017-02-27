@echo off
rem	***************************************************
rem		^> File Name: edit.bat
rem		^> Author: AoEiuV020
rem		^> Mail: aoeiuv020@qq.com
rem		^> Created Time: 2017/01/12 - 16:23:00
rem	***************************************************
set my=%~dp0
set local=%localappdata%\MyWork
notepad %local%\properties.txt
copy %local%\properties.txt %my%\local_example\properties.txt
pause
