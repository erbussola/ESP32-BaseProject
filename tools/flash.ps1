<#
===============================================================================
 ESP32-BaseProject

 File      : flash.ps1
 Versione  : 1.0.0

 Scopo:
 Compila (se necessario) e carica il firmware sulla scheda ESP32 utilizzando
 PlatformIO.

 Compatibilità:
 - Windows PowerShell 5.1
 - PowerShell 7.x
===============================================================================
#>

[CmdletBinding()]
param(
    [ValidateSet("dev","test","release")]
    [string]$Environment = "dev",

    [string]$UploadPort = ""
)

$ErrorActionPreference = "Stop"

function Write-Section {
    param([string]$Title)

    Write-Host ""
    Write-Host "===============================================================================" -ForegroundColor DarkGreen
    Write-Host " $Title" -ForegroundColor Green
    Write-Host "===============================================================================" -ForegroundColor DarkGreen
}

try {

    Write-Section "CARICAMENTO FIRMWARE"

    Write-Host "Ambiente : $Environment"

    if ([string]::IsNullOrWhiteSpace($UploadPort)) {
        Write-Host "Porta     : Rilevamento automatico"
        Write-Host ""
        pio run -e $Environment --target upload
    }
    else {
        Write-Host "Porta     : $UploadPort"
        Write-Host ""
        pio run -e $Environment --target upload --upload-port $UploadPort
    }

    if ($LASTEXITCODE -ne 0) {
        throw "Caricamento firmware terminato con errori."
    }

    Write-Host ""
    Write-Host "Firmware caricato correttamente." -ForegroundColor Green
    exit 0

}
catch {

    Write-Host ""
    Write-Host "ERRORE: $($_.Exception.Message)" -ForegroundColor Red
    exit 1

}
