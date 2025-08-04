function Show-RDPShadowConnection {
    param(
        [string]$ConfigPath = "rdps.ini"
    )

    Write-Host "=== RDP shadow connection ===" -ForegroundColor Cyan
    
    # Чтение INI файла с хостами (исправленное регулярное выражение)
    $hosts = @()
    if (Test-Path $ConfigPath) {
        $hosts = Get-Content $ConfigPath | Where-Object { $_ -match '^\s*([0-9.]+)\s+(\S+)\s*$' } | ForEach-Object {
            $ip, $name = ($_ -split '\s+', 2).Trim()
            [PSCustomObject]@{
                IP = $ip
                Name = $name
            }
        }
        
        # Отладочная информация (можно удалить после проверки)
        Write-Host "Loaded hosts from $ConfigPath`:"
        $hosts | Format-Table -AutoSize | Out-Host
    }
    else {
        Write-Host "Config file $ConfigPath not found, using manual input only" -ForegroundColor Yellow
    }

    # Функция для выбора хоста
    function Select-Host {
        param([bool]$Retry = $false)
        
        if ($Retry) {
            Write-Host "`nNo active sessions found on this host. Please select another host." -ForegroundColor Yellow
        }

        if ($hosts.Count -gt 0) {
            Write-Host "`nAvailable hosts:" -ForegroundColor Green
            $counter = 1
            $hosts | ForEach-Object {
                Write-Host ("{0}: {1} ({2})" -f $counter++, $_.Name, $_.IP)
            }

            $input = Read-Host "`nEnter host (name, IP or number), or leave empty for manual input"
            Write-Host ""
            
            if (-not [string]::IsNullOrEmpty($input)) {
                # Проверяем, ввели ли номер
                if ($input -match '^\d+$' -and [int]$input -le $hosts.Count -and [int]$input -ge 1) {
                    return $hosts[[int]$input - 1].Name
                }
                # Ищем по имени или IP
                else {
                    $selectedHost = $hosts | Where-Object { 
                        $_.Name -eq $input -or $_.IP -eq $input 
                    } | Select-Object -First 1
                    
                    if ($selectedHost) {
                        return $selectedHost.Name
                    }
                    return $input
                }
            }
        }

        # Ручной ввод
        $manualInput = Read-Host "WS name (or leave empty for localhost)"
        Write-Host ""
        if ([string]::IsNullOrEmpty($manualInput)) {
            return "localhost"
        }
        return $manualInput
    }

    # Основной цикл выбора хоста
    do {
        $pcName = Select-Host -Retry ($pcName -ne $null)
        
        # Получаем список сессий
        try {
            $sessions = (quser /server:$pcName 2>&1 | Out-String) -replace "`r",""
            if ($LASTEXITCODE -ne 0) {
                throw $sessions
            }
            
            # Проверяем есть ли активные сессии
            if ($sessions -match "No User exists" -or $sessions -match "No users exist") {
                $sessions = $null
            } else {
                Write-Host "`nActive sessions on $pcName`:"
                Write-Host $sessions
                Write-Host ""
                break
            }
        } catch {
            Write-Host "Error getting sessions: $_" -ForegroundColor Red
            $sessions = $null
        }
    } while ($true)

    # Запрашиваем ID сессии
    $sessID = Read-Host "Session ID"
    Write-Host ""
    if ($sessID -eq "null") {
        return
    }
    
    # Выбираем режим
    Write-Host "1: View"
    Write-Host "2: Control"
    $ctrlMode = Read-Host "Select mode (1)"
    Write-Host ""
    if ([string]::IsNullOrEmpty($ctrlMode)) {
        $ctrlMode = "1"
    }
    
    # Собираем аргументы для mstsc
    $arguments = @(
        "/shadow:$sessID",
        "/v:$pcName",
        "/noConsentPrompt"
    )
    
    # Добавляем параметр контроля только если выбран режим 2
    if ($ctrlMode -eq "2") {
        $arguments += "/control"
    }
    
    # Запускаем подключение
    try {
        Write-Host "Connecting to $pcName, session $sessID..." -ForegroundColor Cyan
        Start-Process mstsc.exe -ArgumentList $arguments
    } catch {
        Write-Host "Error starting mstsc: $_" -ForegroundColor Red
    }
}

# Вызываем функцию
Show-RDPShadowConnection

