@echo off
:: This script pings a website. You can specify an address as an argument.
:: Example: pinger.bat google.com

if ["%1"]==[""] (
    echo Pinging google.com...
    ping google.com
) else (
    echo Pinging %1...
    ping %1
)

pause