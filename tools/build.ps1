<#
===============================================================================
 ESP32-BaseProject

 File      : build.ps1
 Versione  : 1.0.0

 Scopo:
 Compila il progetto PlatformIO utilizzando l'ambiente selezionato.

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
    Write-Host "===============================================================================" -ForegroundColor DarkCyan
    Write-Host " $Title" -ForegroundColor Cyan
    Write-Host "===============================================================================" -ForegroundColor DarkCyan
}

try {

    Write-Section "COMPILAZIONE PROGETTO"

    Write-Host "Ambiente : $Environment"
    Write-Host ""

    pio run -e $Environment

    if ($LASTEXITCODE -ne 0) {
        throw "Compilazione terminata con errori."
    }

    Write-Host ""
    Write-Host "Compilazione completata con successo." -ForegroundColor Green
    exit 0

}
catch {

    Write-Host ""
    Write-Host "ERRORE: $($_.Exception.Message)" -ForegroundColor Red
    exit 1

}
