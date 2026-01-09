@echo off
:: This script allows the user to kill a process by its name.

:: Prompt the user to enter the process name.
set /p process_name="Enter the name of the process to kill (e.g., notepad.exe): "

:: Use taskkill to terminate the specified process.
:: /im - Specifies the image name of the process to be terminated.
:: /f - Specifies to forcefully terminate the process(es).
taskkill /im %process_name% /f

echo Attempted to kill process: %process_name%
pause