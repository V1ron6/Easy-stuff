@echo off
:: This script gathers basic system information and saves it to a file named system_info.txt.

:: Create or overwrite the report file and add a header.
echo System Information Report > system_info.txt
echo ========================= >> system_info.txt
echo. >> system_info.txt

:: Get the OS Name and Version and append it to the report.
echo Operating System: >> system_info.txt
systeminfo | findstr /B /C:"OS Name" /C:"OS Version" >> system_info.txt
echo. >> system_info.txt

:: Get the CPU information and append it to the report.
echo Processor: >> system_info.txt
wmic cpu get name >> system_info.txt
echo. >> system_info.txt

:: Get the total physical memory and append it to the report.
echo Memory: >> system_info.txt
systeminfo | findstr /C:"Total Physical Memory" >> system_info.txt
echo. >> system_info.txt

:: Get the IPv4 address and append it to the report.
echo IP Address: >> system_info.txt
ipconfig | findstr /i "ipv4" >> system_info.txt
echo. >> system_info.txt

:: Add a timestamp to the report.
echo Report generated on %date% at %time% >> system_info.txt

:: Notify the user that the report has been saved.
echo Report saved to system_info.txt
pause