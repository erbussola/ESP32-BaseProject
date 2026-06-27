<#
===============================================================================
 ESP32-BaseProject

 File      : Bootstrap.ps1
 Versione  : 1.0.0

 Scopo:
 Esegue una verifica completa dell'ambiente di sviluppo prima di iniziare
 a lavorare sul progetto.

 Compatibilità:
 - Windows PowerShell 5.1
 - PowerShell 7.x
===============================================================================
#>

[CmdletBinding()]
param()

$ErrorActionPreference = "Stop"

function Write-Section {
    param([string]$Title)

    Write-Host ""
    Write-Host "===============================================================================" -ForegroundColor DarkCyan
    Write-Host " $Title" -ForegroundColor Cyan
    Write-Host "===============================================================================" -ForegroundColor DarkCyan
}

function Test-Command {
    param(
        [Parameter(Mandatory)]
        [string]$CommandName
    )

    return [bool](Get-Command $CommandName -ErrorAction SilentlyContinue)
}

$Failed = $false

try {

    Write-Section "BOOTSTRAP AMBIENTE DI SVILUPPO"

    Write-Host "Verifica prerequisiti..." -ForegroundColor Yellow
    Write-Host ""

    $Checks = @(
        @{ Name = "Git";        Command = "git"      },
        @{ Name = "PlatformIO"; Command = "pio"      },
        @{ Name = "VS Code";    Command = "code"     }
    )

    foreach ($Item in $Checks) {

        if (Test-Command $Item.Command) {

            Write-Host ("[OK]  {0}" -f $Item.Name) -ForegroundColor Green

        }
        else {

            Write-Host ("[KO]  {0}" -f $Item.Name) -ForegroundColor Red
            $Failed = $true

        }

    }

    Write-Host ""

    if (Test-Path ".\VERSION") {

        $Version = Get-Content ".\VERSION"
        Write-Host ("Versione progetto : {0}" -f $Version)

    }
    else {

        Write-Host "File VERSION non trovato." -ForegroundColor Yellow

    }

    if (Test-Path ".\platformio.ini") {

        Write-Host "platformio.ini     : OK" -ForegroundColor Green

    }
    else {

        Write-Host "platformio.ini     : Mancante" -ForegroundColor Red
        $Failed = $true

    }

    if (Test-Path ".\.vscode") {

        Write-Host ".vscode            : OK" -ForegroundColor Green

    }
    else {

        Write-Host ".vscode            : Mancante" -ForegroundColor Yellow

    }

    if ($Failed) {

        Write-Host ""
        Write-Host "Bootstrap completato con anomalie." -ForegroundColor Yellow
        exit 1

    }

    Write-Host ""
    Write-Host "Ambiente verificato con successo." -ForegroundColor Green
    exit 0

}
catch {

    Write-Host ""
    Write-Host "ERRORE: $($_.Exception.Message)" -ForegroundColor Red
    exit 1

}
