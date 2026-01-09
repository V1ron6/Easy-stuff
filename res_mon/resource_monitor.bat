@echo off
:: This script monitors system resource usage and allows the user to terminate a process.

color 0b
title Resource Monitor

:main
cls
echo ===============================
echo         Resource Monitor
echo ===============================
echo Top 10 Memory-Consuming Processes:
echo.

:: List processes sorted by memory usage.
tasklist /v /fo csv | more +1 | sort /r /+67

echo.
echo --- Actions ---
echo To terminate a process, enter its PID (Process ID) below.
echo Leave blank and press Enter to refresh the list.
echo.

set /p pid="Enter PID to kill (or leave blank to refresh): "

if not "%pid%"=="" (
    taskkill /pid %pid% /f
    echo Attempted to kill process with PID: %pid%
    pause
)

goto main