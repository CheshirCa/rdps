# Утилита для подключения в режиме наблюдения (Shadow) к RDP сессиям

Скрипт PowerShell для упрощения подключения в режиме наблюдения к сессиям Remote Desktop Protocol (RDP) через интерактивное меню выбора хостов и активных сессий.

## Возможности

- Чтение списка хостов из файла конфигурации (`rdps.ini`) или ручной ввод
- Отображение активных RDP сессий на выбранных хостах
- Возможность подключения в режиме "только просмотр" или "полное управление"
- Поддержка IP-адресов и доменных имен
- Простой интерактивный интерфейс с меню

## Требования

- Операционная система Windows
- PowerShell 5.1 или новее
- Необходимые разрешения для подключения в режиме наблюдения к RDP сессиям
- Настроенные службы удаленных рабочих столов на целевых машинах

## Установка

1. Сохраните скрипт как `Show-RDPShadowConnection.ps1`
2. При необходимости создайте файл конфигурации `rdps.ini` в той же директории с вашими хостами в формате:
   ```
   192.168.1.10    Сервер1
   192.168.1.20    Сервер2
   ```

## Использование

1. Откройте PowerShell
2. Перейдите в директорию со скриптом
3. Запустите скрипт:
   ```powershell
   .\Show-RDPShadowConnection.ps1
   ```
4. Следуйте инструкциям на экране, чтобы:
   - Выбрать хост из списка или ввести вручную
   - Выбрать активную сессию
   - Выбрать режим "только просмотр" или "полное управление"

## Параметры командной строки

| Параметр     | Описание                              | Значение по умолчанию |
|-------------|--------------------------------------|----------------------|
| `-ConfigPath` | Путь к файлу конфигурации INI       | `rdps.ini`           |

Пример:
```powershell
.\Show-RDPShadowConnection.ps1 -ConfigPath "C:\путь\к\custom.ini"
```

## Примечания

- Необходимы соответствующие разрешения для подключения к сессиям на целевых машинах
- Скрипт требует наличия `mstsc.exe` (Подключение к удаленному рабочему столу)
- Для подключения к локальному компьютеру оставьте поле имени хоста пустым
- Введите "null" в качестве ID сессии для отмены операции

## Устранение неполадок

При возникновении ошибок:
1. Убедитесь, что у вас есть необходимые разрешения для подключения к RDP сессиям
2. Проверьте, что службы удаленных рабочих столов работают на целевых машинах
3. Убедитесь, что файл конфигурации (если используется) имеет правильный формат
4. Убедитесь, что ваша учетная запись имеет привилегию "Удаленное управление"

## Лицензия

Скрипт предоставляется "как есть" без каких-либо гарантий. Вы можете свободно изменять и распространять его.

----------------------------------------

# RDP Shadow Connection Tool

A PowerShell script that simplifies shadowing Remote Desktop Protocol (RDP) sessions by providing an interactive menu to select hosts and active sessions.

## Features

- Reads hosts from a configuration file (`rdps.ini`) or allows manual input
- Displays active RDP sessions on selected hosts
- Provides options to connect in either view-only or control mode
- Supports both IP addresses and hostnames
- Simple interactive menu interface

## Prerequisites

- Windows operating system
- PowerShell 5.1 or later
- Appropriate permissions to shadow RDP sessions
- Remote Desktop Services configured on target machines

## Installation

1. Save the script as `Show-RDPShadowConnection.ps1`
2. Optionally create a configuration file `rdps.ini` in the same directory with your hosts in the format:
   ```
   192.168.1.10    Server1
   192.168.1.20    Server2
   ```

## Usage

1. Open PowerShell
2. Navigate to the directory containing the script
3. Run the script:
   ```powershell
   .\Show-RDPShadowConnection.ps1
   ```
4. Follow the on-screen prompts to:
   - Select a host from the list or enter manually
   - Choose an active session
   - Select view-only or control mode

## Command Line Parameters

| Parameter    | Description                          | Default Value |
|-------------|--------------------------------------|---------------|
| `-ConfigPath` | Path to the configuration INI file | `rdps.ini`    |

Example:
```powershell
.\Show-RDPShadowConnection.ps1 -ConfigPath "C:\path\to\custom.ini"
```

## Notes

- You must have appropriate permissions to shadow sessions on target machines
- The script requires `mstsc.exe` (Remote Desktop Connection) to be available
- For localhost connections, leave the hostname prompt empty
- Enter "null" as session ID to cancel the operation

## Troubleshooting

If you encounter errors:
1. Verify you have proper permissions to shadow RDP sessions
2. Check that Remote Desktop Services are running on target machines
3. Ensure the configuration file (if used) has the correct format
4. Make sure your account has the "Remote Control" privilege

## License

This script is provided as-is without warranty. Feel free to modify and distribute.
