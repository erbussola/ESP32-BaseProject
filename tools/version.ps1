<#
===============================================================================
 ESP32-BaseProject

 File      : version.ps1
 Versione  : 1.0.0

 Scopo:
 Visualizza le principali informazioni di versione del progetto e dello stato
 del repository Git.

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

try {

    Write-Section "INFORMAZIONI PROGETTO"

    $version = Get-Content ".\VERSION" -ErrorAction Stop

    Write-Host ("Versione progetto : {0}" -f $version)

    if (Get-Command git -ErrorAction SilentlyContinue) {

        $branch = git branch --show-current
        $commit = git rev-parse --short HEAD
        $status = git status --porcelain

        Write-Host ("Branch             : {0}" -f $branch)
        Write-Host ("Commit             : {0}" -f $commit)

        if ([string]::IsNullOrWhiteSpace($status)) {
            Write-Host "Repository         : Pulito" -ForegroundColor Green
        }
        else {
            Write-Host "Repository         : Modifiche non committate" -ForegroundColor Yellow
        }

    }
    else {

        Write-Host "Git non disponibile nel PATH." -ForegroundColor Yellow

    }

    exit 0

}
catch {

    Write-Host ""
    Write-Host "ERRORE: $($_.Exception.Message)" -ForegroundColor Red
    exit 1

}
