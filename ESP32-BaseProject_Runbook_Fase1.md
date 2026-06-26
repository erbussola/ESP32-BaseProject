# ESP32-BaseProject

# Runbook Fase 1

## Installazione, Bootstrap e Manutenzione dell'Ambiente di Sviluppo

**Versione:** 1.0.0

**Target**

* Windows 11 x64
* Visual Studio Code
* PlatformIO
* Git
* ESP32-WROOM-32
* GitLab
* GitHub (Mirror)

---

# Indice

1. Prerequisiti
2. Installazione Software
3. Driver USB
4. Installazione VS Code
5. Installazione Estensioni
6. Configurazione Git
7. Configurazione SSH
8. Configurazione Repository
9. Creazione struttura C:\Dev
10. Configurazione PlatformIO
11. Bootstrap ESP32-BaseProject
12. Configurazione VS Code
13. Script PowerShell
14. Verifiche
15. Aggiornamenti
16. Backup
17. Troubleshooting

---

# 1. Prerequisiti

Windows aggiornato

```powershell
winver
```

PowerShell

```powershell
$PSVersionTable.PSVersion
```

Git

```powershell
git --version
```

VS Code

```powershell
code --version
```

Python (solo verifica)

```powershell
python --version
```

Winget

```powershell
winget --version
```

---

# 2. Installazione Software

## Git

```powershell
winget install Git.Git
```

Verifica

```powershell
git --version
```

---

## Visual Studio Code

```powershell
winget install Microsoft.VisualStudioCode
```

Verifica

```powershell
code --version
```

---

## PlatformIO

Da VS Code

```
Ctrl+Shift+X

PlatformIO IDE

Install
```

Attendere la completa installazione.

---

# 3. Driver CP2102

Verifica periferica

```powershell
Get-PnpDevice | Where-Object FriendlyName -like "*CP210*"
```

Verifica porte seriali

```powershell
[System.IO.Ports.SerialPort]::GetPortNames()
```

Output atteso

```
COM4
```

---

# 4. Installazione Estensioni

## Installazione automatica

```powershell
$extensions = @(
"platformio.platformio-ide",
"ms-vscode.cpptools",
"editorconfig.editorconfig",
"redhat.vscode-yaml",
"tamasfe.even-better-toml",
"aaron-bond.better-comments",
"usernamehw.errorlens",
"mechatroner.rainbow-csv",
"github.vscode-pull-request-github",
"gitlab.gitlab-workflow",
"ms-vscode.powershell",
"ms-vscode.remote-explorer",
"ms-vscode-remote.remote-ssh",
"ms-vscode-remote.remote-containers",
"docker.docker"
)

foreach($e in $extensions)
{
    code --install-extension $e
}
```

---

## Verifica

```powershell
code --list-extensions
```

---

# 5. Configurazione Git

## Nome

```powershell
git config --global user.name "ErBussola"
```

## Email

```powershell
git config --global user.email "f.biscossi@gmail.com"
```

## Branch

```powershell
git config --global init.defaultBranch main
```

## Fine riga

```powershell
git config --global core.autocrlf false
git config --global core.eol lf
```

## Colori

```powershell
git config --global color.ui auto
```

## Colonne

```powershell
git config --global column.ui auto
```

## Pull

```powershell
git config --global pull.rebase false
```

## Prune

```powershell
git config --global fetch.prune true
```

## Reuse Resolution

```powershell
git config --global rerere.enabled true
```

---

## Verifica

```powershell
git config --global --list --show-origin
```

---

# 6. Configurazione SSH

Verifica

```powershell
Get-ChildItem $HOME\.ssh
```

Test GitLab

```powershell
ssh -T git@gitlab.com
```

Output atteso

```
Welcome to GitLab
```

---

# 7. Creazione struttura sviluppo

Creazione

```powershell
$Root="C:\Dev"

$Folders=@(

"Documentation",

"Documentation\Datasheets",

"Documentation\Diagrams",

"Documentation\Hardware",

"Documentation\Images",

"Documentation\Notes",

"Projects",

"Projects\ESP32",

"Projects\Linux",

"Projects\Windows",

"Projects\RaspberryPi",

"Projects\IoT",

"Repositories",

"Repositories\GitLab",

"Repositories\Archive",

"Templates",

"Templates\ESP32",

"Templates\PowerShell",

"Templates\Markdown",

"Templates\Bash",

"Tools"

)

foreach($Folder in $Folders)
{
New-Item -ItemType Directory `
-Path (Join-Path $Root $Folder) `
-Force | Out-Null
}
```

Verifica

```powershell
tree C:\Dev /A
```

---

# 8. Bootstrap Repository

Entrare nella cartella

```powershell
cd C:\Dev\Projects\ESP32
```

Creare progetto

```
PIO Home

New Project

ESP32-BaseProject

Framework Arduino

Board esp32dev
```

Al termine

```powershell
cd ESP32-BaseProject
```

---

## Git

```powershell
git init
```

```powershell
git branch -M main
```

```powershell
git add .
```

```powershell
git commit -m "chore: initial project"
```

---

# 9. Collegamento GitLab

Creazione Remote

```powershell
git remote add origin git@gitlab.com:USERNAME/ESP32-BaseProject.git
```

Verifica

```powershell
git remote -v
```

Push

```powershell
git push -u origin main
```

---

# 10. Mirror GitHub

Aggiungere il secondo remoto

```powershell
git remote add github git@github.com:USERNAME/ESP32-BaseProject.git
```

Verifica

```powershell
git remote -v
```

Push

```powershell
git push github main
```

---

# 11. Verifiche finali

Git

```powershell
git status
```

Branch

```powershell
git branch
```

Remote

```powershell
git remote -v
```

PlatformIO

```powershell
pio run
```

oppure tramite il task di VS Code se `pio` non è disponibile nel `PATH`.

Driver

```powershell
[System.IO.Ports.SerialPort]::GetPortNames()
```

Monitor seriale

```powershell
pio device monitor
```

---

## Fine Fase 1

Al termine di questa fase l'ambiente di sviluppo è operativo e pronto per essere completato con i file di configurazione del repository (`.editorconfig`, `.gitignore`, `.gitattributes`, `platformio.ini` avanzato, configurazioni VS Code e script PowerShell), che costituiranno il bootstrap definitivo del progetto `ESP32-BaseProject`.