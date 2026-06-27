<#
===============================================================================
 ESP32-BaseProject

 File      : clean.ps1
 Versione  : 1.0.0

 Scopo:
 Rimuove gli artefatti di compilazione del progetto PlatformIO.

 Compatibilità:
 - Windows PowerShell 5.1
 - PowerShell 7.x
===============================================================================
#>

[CmdletBinding()]
param(
    [ValidateSet("dev","test","release")]
    [string]$Environment = "dev"
)

$ErrorActionPreference = "Stop"

function Write-Section {
    param([string]$Title)

    Write-Host ""
    Write-Host "===============================================================================" -ForegroundColor DarkYellow
    Write-Host " $Title" -ForegroundColor Yellow
    Write-Host "===============================================================================" -ForegroundColor DarkYellow
}

try {

    Write-Section "PULIZIA PROGETTO"

    Write-Host "Ambiente : $Environment"
    Write-Host ""

    pio run -e $Environment --target clean

    if ($LASTEXITCODE -ne 0) {
        throw "Pulizia del progetto terminata con errori."
    }

    Write-Host ""
    Write-Host "Pulizia completata con successo." -ForegroundColor Green
    exit 0

}
catch {

    Write-Host ""
    Write-Host "ERRORE: $($_.Exception.Message)" -ForegroundColor Red
    exit 1

}
