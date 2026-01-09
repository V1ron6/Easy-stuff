@echo off
:: This script boosts the priority of a specified application.

color 0c
title Priority Booster

:main
cls
echo ===============================
echo       Priority Booster
echo ===============================
echo This script will set the priority of a specified application to "High".
echo.

:: List common running applications to help the user.
echo --- Currently Running Applications ---
tasklist /fo table /fi "sessionname eq console" | findstr /v "svchost.exe conhost.exe"
echo.

set /p process_name="Enter the name of the app to boost (e.g., chrome.exe): "

if "%process_name%"=="" goto main

:: Set the priority of the specified process to High.
wmic process where name="%process_name%" call setpriority "high priority"

echo.
echo Successfully attempted to set the priority of %process_name% to High.

echo.
set /p choice="Boost another process? (y/n): "
if /i "%choice%"=="y" goto main

exit