@echo off
cls
goto A:

:A
TIMEOUT /T 1
cd C:\Users\Anonbibi\FX3
TIMEOUT /T 1
run.cmd +exec server.cfg
pause >nul