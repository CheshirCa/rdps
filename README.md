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
