<#
===============================================================================
 ESP32-BaseProject

 File      : monitor.ps1
 Versione  : 1.0.0

 Scopo:
 Avvia il monitor seriale di PlatformIO per visualizzare l'output dell'ESP32.

 Compatibilità:
 - Windows PowerShell 5.1
 - PowerShell 7.x
===============================================================================
#>

[CmdletBinding()]
param(
    [string]$Port = "",

    [int]$BaudRate = 115200
)

$ErrorActionPreference = "Stop"

function Write-Section {
    param([string]$Title)

    Write-Host ""
    Write-Host "===============================================================================" -ForegroundColor DarkCyan
    Write-Host " $Title" -ForegroundColor Cyan
    Write-Host "===============================================================================" -ForegroundColor DarkCyan
}

try {

    Write-Section "MONITOR SERIALE"

    if ([string]::IsNullOrWhiteSpace($Port)) {

        Write-Host "Porta      : Rilevamento automatico"
        Write-Host "Baud Rate  : $BaudRate"
        Write-Host ""

        pio device monitor --baud $BaudRate

    }
    else {

        Write-Host "Porta      : $Port"
        Write-Host "Baud Rate  : $BaudRate"
        Write-Host ""

        pio device monitor --port $Port --baud $BaudRate

    }

    exit $LASTEXITCODE

}
catch {

    Write-Host ""
    Write-Host "ERRORE: $($_.Exception.Message)" -ForegroundColor Red
    exit 1

}
