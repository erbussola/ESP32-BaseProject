<#
===============================================================================
 ESP32-BaseProject

 File      : test.ps1
 Versione  : 1.0.0

 Scopo:
 Esegue i test del progetto tramite PlatformIO.

 Compatibilità:
 - Windows PowerShell 5.1
 - PowerShell 7.x
===============================================================================
#>

[CmdletBinding()]
param(
    [ValidateSet("dev","test","release")]
    [string]$Environment = "test"
)

$ErrorActionPreference = "Stop"

function Write-Section {
    param([string]$Title)

    Write-Host ""
    Write-Host "===============================================================================" -ForegroundColor DarkMagenta
    Write-Host " $Title" -ForegroundColor Magenta
    Write-Host "===============================================================================" -ForegroundColor DarkMagenta
}

try {

    Write-Section "ESECUZIONE TEST"

    Write-Host "Ambiente : $Environment"
    Write-Host ""

    pio test -e $Environment

    if ($LASTEXITCODE -ne 0) {
        throw "Uno o più test sono terminati con errori."
    }

    Write-Host ""
    Write-Host "Tutti i test sono stati completati con successo." -ForegroundColor Green
    exit 0

}
catch {

    Write-Host ""
    Write-Host "ERRORE: $($_.Exception.Message)" -ForegroundColor Red
    exit 1

}
