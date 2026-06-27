<#
===============================================================================
 ESP32-BaseProject

 File      : release.ps1
 Versione  : 1.0.0

 Scopo:
 Compila il firmware di rilascio (Release) del progetto ESP32 utilizzando
 PlatformIO.

 Compatibilità:
 - Windows PowerShell 5.1
 - PowerShell 7.x
===============================================================================
#>

[CmdletBinding()]
param(
    [switch]$Clean
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

    Write-Section "BUILD DI RILASCIO"

    if ($Clean) {

        Write-Host "Pulizia preventiva del progetto..."
        pio run -e release --target clean

        if ($LASTEXITCODE -ne 0) {
            throw "Errore durante la pulizia del progetto."
        }

        Write-Host ""
    }

    Write-Host "Compilazione ambiente: release"
    Write-Host ""

    pio run -e release

    if ($LASTEXITCODE -ne 0) {
        throw "Build Release terminata con errori."
    }

    Write-Host ""
    Write-Host "Build Release completata con successo." -ForegroundColor Green

    Write-Host ""
    Write-Host "Firmware generato in:"
    Write-Host ".pio\build\release\" -ForegroundColor Cyan

    exit 0

}
catch {

    Write-Host ""
    Write-Host "ERRORE: $($_.Exception.Message)" -ForegroundColor Red
    exit 1

}
