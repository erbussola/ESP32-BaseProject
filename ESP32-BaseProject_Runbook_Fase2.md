# ESP32-BaseProject

# Runbook Fase 2

## 12. Configurazione del Repository

---

# 12.1 Creazione file VERSION

```powershell
Set-Content `
-Path .\VERSION `
-Value "1.0.0"
```

Verifica

```powershell
Get-Content .\VERSION
```

Output

```text
1.0.0
```

---

# 12.2 Creazione CHANGELOG

```powershell
@"
# Changelog

All notable changes to this project will be documented in this file.

## [1.0.0]

### Added

- Initial project
"@ | Set-Content CHANGELOG.md
```

---

# 12.3 Creazione LICENSE

Se progetto Open Source

```powershell
New-Item LICENSE
```

oppure

MIT License

Apache 2.0

GPLv3

In ambiente privato:

```text
Copyright (C)

All Rights Reserved
```

---

# 12.4 README

Creare

```powershell
New-Item README.md
```

Struttura iniziale

```text
Titolo

Descrizione

Hardware

Software

Build

Upload

OTA

Licenza
```

---

# 13. Configurazione VS Code

Entrare nella cartella

```powershell
mkdir .vscode
```

---

## settings.json

```powershell
New-Item .vscode\settings.json
```

Contenuto

```json
{
    "editor.formatOnSave": true,
    "editor.insertSpaces": true,
    "editor.tabSize": 4,
    "editor.rulers": [
        100
    ],
    "files.eol": "\n",
    "files.trimTrailingWhitespace": true,
    "files.insertFinalNewline": true,
    "terminal.integrated.defaultProfile.windows": "PowerShell",
    "editor.renderWhitespace": "selection",
    "editor.renderControlCharacters": true,
    "editor.minimap.enabled": false,
    "files.autoSave": "off",
    "files.exclude": {
        "**/.pio": true
    }
}
```

---

## extensions.json

```powershell
New-Item .vscode\extensions.json
```

Contenuto

```json
{
    "recommendations": [
        "platformio.platformio-ide",
        "ms-vscode.cpptools",
        "editorconfig.editorconfig",
        "redhat.vscode-yaml",
        "tamasfe.even-better-toml",
        "usernamehw.errorlens",
        "aaron-bond.better-comments",
        "ms-vscode.powershell",
        "gitlab.gitlab-workflow",
        "github.vscode-pull-request-github"
    ]
}
```

---

## launch.json

```powershell
New-Item .vscode\launch.json
```

```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "PIO Debug",
            "type": "platformio-debug",
            "request": "launch"
        }
    ]
}
```

---

## tasks.json

```powershell
New-Item .vscode\tasks.json
```

```json
{
    "version": "2.0.0",
    "tasks": [
        {
            "label": "Build",
            "type": "shell",
            "command": ".\\tools\\build.ps1",
            "group": "build"
        },
        {
            "label": "Flash",
            "type": "shell",
            "command": ".\\tools\\flash.ps1"
        },
        {
            "label": "Monitor",
            "type": "shell",
            "command": ".\\tools\\monitor.ps1"
        },
        {
            "label": "Clean",
            "type": "shell",
            "command": ".\\tools\\clean.ps1"
        },
        {
            "label": "Test",
            "type": "shell",
            "command": ".\\tools\\test.ps1"
        }
    ]
}
```

---

# 14. Creazione cartella tools

```powershell
mkdir tools
```

Verifica

```powershell
tree tools
```

---

# 15. build.ps1

```powershell
@'
Clear-Host

Write-Host ""
Write-Host "=============================" -ForegroundColor Cyan
Write-Host "BUILD" -ForegroundColor Cyan
Write-Host "=============================" -ForegroundColor Cyan

pio run

exit $LASTEXITCODE
'@ | Set-Content .\tools\build.ps1
```

---

# 16. clean.ps1

```powershell
@'
Clear-Host

Write-Host ""
Write-Host "=============================" -ForegroundColor Yellow
Write-Host "CLEAN" -ForegroundColor Yellow
Write-Host "=============================" -ForegroundColor Yellow

pio run --target clean

exit $LASTEXITCODE
'@ | Set-Content .\tools\clean.ps1
```

---

# 17. flash.ps1

```powershell
@'
Clear-Host

Write-Host ""
Write-Host "=============================" -ForegroundColor Green
Write-Host "FLASH" -ForegroundColor Green
Write-Host "=============================" -ForegroundColor Green

pio run --target upload

exit $LASTEXITCODE
'@ | Set-Content .\tools\flash.ps1
```

---

# 18. monitor.ps1

```powershell
@'
Clear-Host

Write-Host ""
Write-Host "=============================" -ForegroundColor Cyan
Write-Host "SERIAL MONITOR" -ForegroundColor Cyan
Write-Host "=============================" -ForegroundColor Cyan

pio device monitor

exit $LASTEXITCODE
'@ | Set-Content .\tools\monitor.ps1
```

---

# 19. test.ps1

```powershell
@'
Clear-Host

Write-Host ""
Write-Host "=============================" -ForegroundColor Magenta
Write-Host "UNIT TEST" -ForegroundColor Magenta
Write-Host "=============================" -ForegroundColor Magenta

pio test

exit $LASTEXITCODE
'@ | Set-Content .\tools\test.ps1
```

---

# 20. release.ps1

```powershell
@'
Clear-Host

Write-Host ""
Write-Host "=============================" -ForegroundColor Green
Write-Host "RELEASE BUILD" -ForegroundColor Green
Write-Host "=============================" -ForegroundColor Green

pio run -e release

exit $LASTEXITCODE
'@ | Set-Content .\tools\release.ps1
```

---

# 21. version.ps1

```powershell
@'
$Version = Get-Content .\VERSION

Write-Host ""
Write-Host "Project Version:" -ForegroundColor Cyan
Write-Host $Version -ForegroundColor Green
'@ | Set-Content .\tools\version.ps1
```

---

# 22. Verifica strumenti

```powershell
Get-ChildItem .\tools
```

Output atteso

```text
build.ps1

clean.ps1

flash.ps1

monitor.ps1

release.ps1

test.ps1

version.ps1
```

---

## Fine Fase 2

La fase successiva del Runbook completerà il repository con:

* `.editorconfig`
* `.gitignore`
* `.gitattributes`
* `platformio.ini` professionale e commentato
* struttura completa di `include/`, `src/`, `lib/`, `docs/`
* bootstrap del primo firmware
* logging
* configurazione degli ambienti `dev`, `test` e `release`
* template del codice C++ pronto per tutti i futuri progetti ESP32.
