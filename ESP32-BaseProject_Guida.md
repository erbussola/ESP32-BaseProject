# ESP32-BaseProject

## Guida Ufficiale

**Versione:** 1.0.0

**Autore:** Fabrizio Biscossi

**Target Hardware:** ESP32-WROOM-32 / ESP32-S3 / ESP32-C3

**IDE:** Visual Studio Code

**Framework:** PlatformIO

**Framework Embedded:** Arduino (con predisposizione ESP-IDF)

**Sistema Operativo:** Windows 11 x64

**Versione minima consigliata:**

* Visual Studio Code 1.125+
* PlatformIO Core 6.x
* Git 2.54+
* PowerShell 7.x (compatibile anche con Windows PowerShell 5.1)

---

# 1. Obiettivi del progetto

ESP32-BaseProject costituisce il repository base da cui derivare qualsiasi progetto ESP32.

Ogni nuovo repository dovrà essere creato clonando questo progetto.

L'obiettivo è garantire:

* uniformità
* manutenibilità
* versionamento
* documentazione
* automazione
* scalabilità
* integrazione GitLab
* integrazione futura CI/CD

---

# 2. Filosofia

Ogni repository deve poter essere aperto da un nuovo sviluppatore senza alcuna conoscenza preventiva.

La struttura deve essere autoesplicativa.

Il repository deve contenere:

* codice
* documentazione
* configurazioni
* script
* immagini
* datasheet
* procedure

Non devono esistere file sparsi.

---

# 3. Struttura definitiva

```text
ESP32-BaseProject
│
├── .git
│
├── .gitlab
│
├── .vscode
│   ├── extensions.json
│   ├── launch.json
│   ├── settings.json
│   └── tasks.json
│
├── docs
│   ├── datasheets
│   ├── diagrams
│   ├── hardware
│   ├── images
│   ├── notes
│   └── references
│
├── include
│
├── lib
│
├── src
│
├── test
│
├── tools
│   ├── build.ps1
│   ├── clean.ps1
│   ├── flash.ps1
│   ├── monitor.ps1
│   ├── release.ps1
│   ├── test.ps1
│   ├── update.ps1
│   └── version.ps1
│
├── .editorconfig
├── .gitattributes
├── .gitignore
├── CHANGELOG.md
├── LICENSE
├── platformio.ini
├── README.md
└── VERSION
```

---

# 4. Convenzioni di Naming

Repository

```
ESP32-BBQController

ESP32-MeteoStation

ESP32-Irrigation

ESP32-UPSMonitor

ESP32-SmartRelay
```

Mai:

```
progetto1

test

esp

NuovoProgetto
```

---

Branch

```
main

develop

feature/wifi

feature/mqtt

feature/display

bugfix/watchdog

release/v1.2.0

hotfix/crash
```

---

Tag

```
v1.0.0

v1.0.1

v1.1.0

v2.0.0
```

Semantic Versioning.

---

Commit

Formato consigliato

```
feat:

fix:

docs:

style:

refactor:

perf:

test:

build:

ci:

chore:
```

Esempio

```
feat: add MQTT reconnect

fix: resolve watchdog timeout

docs: update README

refactor: split WiFi manager

chore: update PlatformIO
```

---

# 5. Organizzazione del codice

src/

Solo file applicativi.

Esempio

```
main.cpp

wifi.cpp

mqtt.cpp

display.cpp

storage.cpp

ota.cpp
```

---

include/

Solo header.

```
wifi.h

mqtt.h

config.h

pins.h
```

---

lib/

Librerie locali.

Mai mettere qui librerie scaricate dal Registry PlatformIO.

---

test/

Test unitari.

---

docs/

Contiene tutta la documentazione.

```
Pinout

Datasheet

Diagrammi

Foto

Schemi

Manuali
```

---

tools/

Solo automazione.

Nessun file manuale.

---

# 6. Standard C++

## File

Uno scopo.

Una responsabilità.

---

Header

```cpp
#pragma once
```

Sempre.

Mai usare include guard manuali.

---

Namespace

Usare namespace quando il progetto supera poche migliaia di righe di codice.

---

Costanti

```cpp
constexpr
```

Preferito rispetto a

```
#define
```

---

Mai usare

```
using namespace std;
```

---

Preferire

```
std::
```

---

Preferire

```cpp
enum class
```

a

```cpp
enum
```

---

Preferire

```cpp
constexpr
```

a

```cpp
#define
```

---

Usare

```cpp
nullptr
```

mai

```cpp
NULL
```

---

Usare

```cpp
bool
```

mai

```
int flag
```

---

# 7. Standard Arduino

Mai scrivere tutta la logica dentro

```cpp
loop()
```

Il loop deve essere minimo.

Esempio

```cpp
void loop()
{
    WiFiManager.loop();

    MQTT.loop();

    Display.loop();

    OTA.loop();
}
```

---

Mai usare

```
delay()
```

Preferire

```
millis()
```

oppure timer.

---

Non usare variabili globali inutilmente.

---

Configurazioni sempre centralizzate.

```
config.h
```

---

Pin sempre definiti in

```
pins.h
```

mai numeri "hardcoded".

---

# ESP32-BaseProject

# 8. Standard di formattazione

## .editorconfig

Creare il seguente file nella root del repository.

```ini
root = true

[*]
charset = utf-8
end_of_line = lf
insert_final_newline = true
trim_trailing_whitespace = true
indent_style = space
indent_size = 4

[*.md]
trim_trailing_whitespace = false

[*.yml]
indent_size = 2

[*.yaml]
indent_size = 2

[*.json]
indent_size = 2

[*.toml]
indent_size = 4

[*.ps1]
indent_size = 4

[*.cpp]
indent_size = 4

[*.hpp]
indent_size = 4

[*.h]
indent_size = 4

[*.c]
indent_size = 4

[*.ino]
indent_size = 4
```

---

# 9. Standard Git

## .gitattributes

```gitattributes
###############################################################################
# Default
###############################################################################

* text=auto eol=lf

###############################################################################
# Source Code
###############################################################################

*.c           text
*.cpp         text
*.cc          text
*.cxx         text
*.h           text
*.hpp         text
*.ino         text

###############################################################################
# Scripts
###############################################################################

*.sh          text eol=lf
*.ps1         text eol=crlf
*.bat         text eol=crlf

###############################################################################
# Config
###############################################################################

*.json        text
*.yaml        text
*.yml         text
*.toml        text
*.ini         text
*.conf        text

###############################################################################
# Markdown
###############################################################################

*.md          text

###############################################################################
# Binary
###############################################################################

*.png         binary
*.jpg         binary
*.jpeg        binary
*.gif         binary
*.ico         binary
*.pdf         binary
*.zip         binary
*.7z          binary
*.bin         binary
*.hex         binary
*.elf         binary

###############################################################################
# PlatformIO
###############################################################################

.pio/** export-ignore
```

---

# 10. .gitignore

```gitignore
###############################################################################
# PlatformIO
###############################################################################

.pio/
.pioenvs/
.piolibdeps/

###############################################################################
# VS Code
###############################################################################

.vscode/ipch/
.vscode/*.db

###############################################################################
# C/C++
###############################################################################

*.o
*.obj
*.d
*.a
*.so
*.dll
*.exe
*.elf
*.bin
*.hex

###############################################################################
# Logs
###############################################################################

*.log

###############################################################################
# Temporary
###############################################################################

*.tmp
*.bak
*.old

###############################################################################
# OS
###############################################################################

Thumbs.db
Desktop.ini
.DS_Store

###############################################################################
# Python
###############################################################################

__pycache__/
*.pyc

###############################################################################
# Test
###############################################################################

coverage/

###############################################################################
# Release
###############################################################################

release/
dist/

###############################################################################
# User
###############################################################################

*.code-workspace
```

---

# 11. Configurazione Git globale

```powershell
git config --global init.defaultBranch main

git config --global core.autocrlf false

git config --global core.eol lf

git config --global color.ui auto

git config --global column.ui auto

git config --global fetch.prune true

git config --global rerere.enabled true

git config --global pull.rebase false
```

---

# 12. Configurazione repository

Ogni nuovo progetto deve essere inizializzato con:

```powershell
git init

git branch -M main

git add .

git commit -m "chore: initial project"
```

---

# 13. Workflow Git

```
main
│
├── develop
│
├── feature/wifi
├── feature/display
├── feature/ota
├── feature/mqtt
│
├── release/v1.0.0
│
└── hotfix/watchdog
```

Mai sviluppare direttamente su **main**.

---

# 14. Versioning

Utilizzare Semantic Versioning.

```
MAJOR.MINOR.PATCH
```

Esempio

```
1.0.0

1.0.1

1.1.0

2.0.0
```

File VERSION

```
1.0.0
```

---

# 15. Organizzazione della documentazione

```
docs
│
├── datasheets
│
├── diagrams
│
├── hardware
│
├── images
│
├── notes
│
└── references
```

Ogni progetto deve contenere almeno:

* datasheet dei componenti
* schema collegamenti
* foto hardware
* pinout
* documentazione installazione

---

# 16. Convenzioni Header

Ordine degli include.

```cpp
// Standard Library

// ESP-IDF

// Arduino

// Project
```

Esempio

```cpp
#include <memory>

#include <WiFi.h>

#include "config.h"

#include "wifi_manager.h"
```

---

# 17. Convenzioni nomi file

```
wifi_manager.cpp

wifi_manager.h

mqtt_client.cpp

mqtt_client.h

display_manager.cpp

display_manager.h
```

Mai:

```
wifi.cpp

wifi2.cpp

wifi_new.cpp
```

---

# 18. Convenzioni classi

```
WifiManager

DisplayManager

MqttClient

ConfigurationManager
```

---

# 19. Convenzioni variabili

Membri privati

```
_wifiClient
```

Variabili locali

```
wifiConnected
```

Costanti

```
constexpr uint32_t WIFI_TIMEOUT_MS
```

---

# 20. Convenzioni cartelle src

```
src
│
├── main.cpp
│
├── core
│
├── network
│
├── sensors
│
├── display
│
├── storage
│
├── services
│
├── ota
│
└── web
```

Anche se inizialmente vuote.

Consentono al progetto di crescere senza dover essere riorganizzato.

---

# 21. Librerie

Le librerie devono essere dichiarate esclusivamente in

```
platformio.ini
```

Mai copiare librerie scaricate nella cartella lib.

La cartella lib deve contenere solo librerie sviluppate internamente.

---

# 22. Logging

Livelli

```
ERROR

WARN

INFO

DEBUG

VERBOSE
```

Mai utilizzare Serial.println() sparsi nel codice.

Creare sempre un wrapper dedicato.

Esempio

```
LOG_ERROR()

LOG_WARN()

LOG_INFO()

LOG_DEBUG()
```

Questo permetterà in futuro di sostituire facilmente la destinazione del log (Seriale, rete, file, MQTT, ecc.) senza modificare il resto del codice.

---

# ESP32-BaseProject

# 23. Configurazione PlatformIO

## platformio.ini

Il file `platformio.ini` costituisce il cuore della configurazione del progetto.

Utilizzare la seguente configurazione come base.

```ini
; ============================================================================
; ESP32-BaseProject
; PlatformIO Configuration
; ============================================================================

[platformio]

default_envs = dev

description = ESP32 Base Project

; ============================================================================
; Shared Configuration
; ============================================================================

[env]

platform = espressif32

board = esp32dev

framework = arduino

monitor_speed = 115200

upload_speed = 460800

monitor_filters =
    colorize
    time
    esp32_exception_decoder

lib_ldf_mode = chain+

lib_compat_mode = strict

check_tool = cppcheck

check_flags =
    cppcheck:
        --enable=warning,style,performance

build_flags =
    -DCORE_DEBUG_LEVEL=3

extra_scripts =
    pre:tools/pre_build.py

; ============================================================================
; Development
; ============================================================================

[env:dev]

build_type = debug

build_flags =
    ${env.build_flags}
    -DENV_DEV

; ============================================================================
; Test
; ============================================================================

[env:test]

build_type = debug

build_flags =
    ${env.build_flags}
    -DENV_TEST

; ============================================================================
; Release
; ============================================================================

[env:release]

build_type = release

build_flags =
    ${env.build_flags}
    -DENV_RELEASE
```

---

# 24. Gestione ambienti

Sono previsti tre ambienti.

## dev

Utilizzato durante lo sviluppo.

Caratteristiche:

* Debug
* Logging completo
* Assert abilitati

---

## test

Utilizzato per:

* test hardware
* validazione
* collaudo

---

## release

Utilizzato per la produzione.

Caratteristiche:

* Ottimizzazione compilatore
* Logging minimo
* Firmware finale

---

# 25. Configurazione VS Code

Cartella

```text
.vscode
```

conterrà esclusivamente

```text
settings.json

tasks.json

launch.json

extensions.json
```

---

# 26. settings.json

```json
{
    "editor.formatOnSave": true,

    "editor.insertSpaces": true,

    "editor.tabSize": 4,

    "editor.rulers": [
        100
    ],

    "files.trimTrailingWhitespace": true,

    "files.insertFinalNewline": true,

    "files.eol": "\n",

    "editor.renderWhitespace": "selection",

    "editor.codeActionsOnSave": {

        "source.organizeImports": "always"

    },

    "C_Cpp.default.cppStandard": "c++17",

    "C_Cpp.default.cStandard": "c11",

    "terminal.integrated.defaultProfile.windows": "PowerShell",

    "files.associations": {

        "*.tcc": "cpp"

    }
}
```

---

# 27. extensions.json

```json
{
    "recommendations": [

        "platformio.platformio-ide",

        "ms-vscode.cpptools",

        "editorconfig.editorconfig",

        "usernamehw.errorlens",

        "redhat.vscode-yaml",

        "tamasfe.even-better-toml",

        "aaron-bond.better-comments",

        "github.vscode-pull-request-github",

        "gitlab.gitlab-workflow",

        "mechatroner.rainbow-csv"
    ]
}
```

---

# 28. tasks.json

```json
{
    "version": "2.0.0",

    "tasks": [

        {

            "label": "Build",

            "type": "shell",

            "command": ".\\tools\\build.ps1"

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

        }

    ]
}
```

---

# 29. launch.json

```json
{
    "version": "0.2.0",

    "configurations": [

        {

            "name": "PlatformIO Debug",

            "type": "platformio-debug",

            "request": "launch"

        }

    ]
}
```

---

# 30. PowerShell

Tutti gli script saranno presenti nella cartella

```text
tools
```

Ogni script deve:

* verificare gli errori
* terminare con Exit Code
* utilizzare colori
* restituire messaggi comprensibili

---

# build.ps1

```powershell
Clear-Host

Write-Host ""

Write-Host "========== BUILD ==========" -ForegroundColor Cyan

pio run

exit $LASTEXITCODE
```

---

# clean.ps1

```powershell
Clear-Host

Write-Host ""

Write-Host "========== CLEAN ==========" -ForegroundColor Yellow

pio run --target clean

exit $LASTEXITCODE
```

---

# flash.ps1

```powershell
Clear-Host

Write-Host ""

Write-Host "========== FLASH ==========" -ForegroundColor Green

pio run --target upload

exit $LASTEXITCODE
```

---

# monitor.ps1

```powershell
Clear-Host

Write-Host ""

Write-Host "========== SERIAL MONITOR ==========" -ForegroundColor Cyan

pio device monitor

exit $LASTEXITCODE
```

---

# test.ps1

```powershell
Clear-Host

Write-Host ""

Write-Host "========== UNIT TEST ==========" -ForegroundColor Magenta

pio test

exit $LASTEXITCODE
```

---

# release.ps1

```powershell
Clear-Host

Write-Host ""

Write-Host "========== RELEASE ==========" -ForegroundColor Green

pio run -e release

exit $LASTEXITCODE
```

---

# version.ps1

Legge il file

```text
VERSION
```

e restituisce il numero di versione corrente.

Questo file verrà utilizzato anche dalle future pipeline GitLab CI/CD.

---

# 31. Configurazione seriale

Velocità standard

```text
115200
```

Upload

```text
460800
```

Monitor

```text
115200
```

Le velocità devono essere centralizzate esclusivamente nel `platformio.ini`.

Non utilizzare valori differenti nel codice.

---

# 32. Gestione librerie

Tutte le dipendenze devono essere dichiarate in `platformio.ini`.

Esempio:

```ini
lib_deps =
    bblanchon/ArduinoJson@^7.4.2
    knolleary/PubSubClient
```

Non scaricare manualmente librerie da Internet.

Utilizzare sempre il Registry ufficiale di PlatformIO, salvo casi eccezionali in cui sia necessario integrare una libreria proprietaria o non disponibile nel registry.

---

# 33. Gestione della configurazione

Creare una struttura dedicata alla configurazione dell'applicazione.

```text
include
│
├── config.h
├── pins.h
├── version.h
└── build_info.h
```

Le costanti devono essere concentrate in questi file.

Mai inserire numeri "hardcoded" nel codice applicativo.

---

# ESP32-BaseProject

# 34. Architettura Software

Il progetto deve seguire una struttura modulare.

Ogni modulo deve avere una sola responsabilità.

```text
src
│
├── main.cpp
│
├── core
│   ├── application.cpp
│   ├── scheduler.cpp
│   ├── logger.cpp
│   └── watchdog.cpp
│
├── network
│   ├── wifi_manager.cpp
│   ├── mqtt_client.cpp
│   ├── ntp_client.cpp
│   └── web_server.cpp
│
├── storage
│   ├── preferences.cpp
│   ├── filesystem.cpp
│   └── configuration.cpp
│
├── sensors
│
├── display
│
├── ota
│
└── services
```

---

# 35. main.cpp

Il file `main.cpp` deve essere il più piccolo possibile.

Deve limitarsi a:

* inizializzare il sistema
* avviare i moduli
* eseguire il ciclo principale

Mai inserire logica applicativa complessa nel `loop()`.

Schema consigliato:

```cpp
setup()
{
    Logger.begin();

    Configuration.begin();

    Storage.begin();

    Wifi.begin();

    MQTT.begin();

    OTA.begin();

    Display.begin();

    Sensors.begin();
}

loop()
{
    Scheduler.run();
}
```

---

# 36. Scheduler

Evitare codice bloccante.

Mai utilizzare:

```cpp
delay()
```

Utilizzare sempre scheduler basati su:

* millis()
* timer
* FreeRTOS Task (quando necessario)

Ogni modulo dovrà implementare:

```cpp
begin()

loop()

stop()

reset()
```

---

# 37. Gestione Errori

Mai ignorare il valore di ritorno di una funzione.

Preferire:

```cpp
if (!wifi.connect())
{
    LOG_ERROR("WiFi connection failed");
}
```

piuttosto che:

```cpp
wifi.connect();
```

---

# 38. Logging

Creare un modulo dedicato.

```text
src/core/logger.cpp
include/logger.h
```

Interfaccia consigliata:

```cpp
LOG_ERROR()

LOG_WARN()

LOG_INFO()

LOG_DEBUG()

LOG_VERBOSE()
```

Livelli:

```text
ERROR

WARN

INFO

DEBUG

VERBOSE
```

Il livello deve poter essere modificato da `platformio.ini`.

---

# 39. Gestione Configurazione

Centralizzare tutta la configurazione.

```text
include
│
├── config.h
├── build_info.h
├── version.h
├── secrets.example.h
└── pins.h
```

Mai inserire:

SSID

Password

Token

API Key

direttamente nel codice.

Creare sempre

```text
secrets.h
```

ignorato dal repository.

---

# 40. secrets.h

Aggiungere in `.gitignore`

```text
include/secrets.h
```

e mantenere nel repository

```text
include/secrets.example.h
```

contenente valori fittizi.

---

# 41. Gestione Pin

Tutti i pin devono essere dichiarati in

```cpp
pins.h
```

Esempio

```cpp
constexpr gpio_num_t PIN_LED = GPIO_NUM_2;

constexpr gpio_num_t PIN_RELAY = GPIO_NUM_16;

constexpr gpio_num_t PIN_BUTTON = GPIO_NUM_4;
```

Mai:

```cpp
digitalWrite(2,HIGH);
```

---

# 42. Gestione Versione

Creare

```text
VERSION
```

esempio

```text
1.0.0
```

Creare anche

```cpp
version.h
```

che legge automaticamente la versione durante la build.

---

# 43. Build Information

Generare automaticamente:

* data build

* ora build

* commit Git

* branch

* versione

Queste informazioni saranno mostrate nella seriale all'avvio.

---

# 44. Watchdog

Ogni progetto deve prevedere il watchdog.

Creare

```text
watchdog.cpp

watchdog.h
```

anche se inizialmente vuoti.

---

# 45. OTA

Predisporre sempre

```text
src/ota

include/ota.h
```

Anche se OTA verrà implementato successivamente.

---

# 46. File System

Preparare già il supporto per

LittleFS

evitando SPIFFS nei nuovi progetti.

---

# 47. Organizzazione delle Librerie

Le librerie locali devono essere organizzate come:

```text
lib
│
├── Display
│
├── Network
│
├── Sensors
│
└── Utils
```

Ogni libreria deve essere indipendente.

---

# 48. Test

Ogni modulo dovrà avere test dedicati.

```text
test
│
├── test_wifi
│
├── test_storage
│
├── test_display
│
└── test_configuration
```

---

# 49. Debug

Attivare sempre:

* Exception Decoder

* Color Monitor

* Timestamp

nel monitor seriale.

Mai effettuare debug con semplici `Serial.println()` sparsi nel codice.

---

# 50. README

Ogni progetto deve contenere almeno i seguenti capitoli.

```text
1 Introduzione

2 Obiettivi

3 Hardware

4 Schema collegamenti

5 Software richiesto

6 Installazione

7 Compilazione

8 Upload

9 Monitor seriale

10 Configurazione

11 Librerie

12 OTA

13 Troubleshooting

14 Changelog

15 Licenza
```

---

# 51. CHANGELOG

Seguire il formato Keep a Changelog.

```text
## 1.0.0

### Added

### Changed

### Fixed

### Removed
```

---

# 52. Checklist iniziale

Prima di iniziare un nuovo progetto verificare:

* Repository creato
* README aggiornato
* VERSION inizializzato
* CHANGELOG creato
* PlatformIO aggiornato
* Librerie definite
* Board corretta
* Pin documentati
* Datasheet copiati
* Schema hardware disponibile

---

# 53. Checklist pre-release

Verificare:

* Build Release completata
* Nessun warning critico
* Test superati
* README aggiornato
* CHANGELOG aggiornato
* VERSION incrementato
* Tag Git creato
* Commit firmati
* Push su GitLab
* Mirror su GitHub aggiornato

---

# 54. Workflow di sviluppo

Per ogni nuova funzionalità:

1. Creare branch `feature/...`
2. Sviluppare
3. Testare
4. Commit firmati
5. Merge su `develop`
6. Validazione
7. Merge su `main`
8. Creazione Tag
9. Release

Mai sviluppare direttamente su `main`.

---

# 55. Aggiornamento PlatformIO

Procedura consigliata:

1. Aggiornare PlatformIO IDE.
2. Aggiornare PlatformIO Core.
3. Aggiornare piattaforme (`espressif32`).
4. Aggiornare librerie.
5. Eseguire una build completa.
6. Rieseguire tutti i test.
7. Aggiornare il CHANGELOG se necessario.

---

# 56. Manutenzione periodica

Con cadenza mensile:

* Aggiornare VS Code.
* Aggiornare estensioni.
* Aggiornare PlatformIO.
* Aggiornare Git.
* Verificare dipendenze obsolete.
* Controllare warning di compilazione.
* Verificare lo stato dei repository GitLab/GitHub.
* Eseguire backup dei repository locali.

---

# 57. Regole fondamentali

* Un modulo = una responsabilità.
* Nessun valore hardcoded.
* Nessun `delay()` nel codice applicativo.
* Nessuna credenziale nel repository.
* Tutte le dipendenze gestite da PlatformIO.
* Tutti i commit firmati.
* Tutti i file documentati.
* Tutti i progetti derivati da `ESP32-BaseProject`.
* Ogni nuova funzionalità sviluppata in un branch dedicato.
* Documentazione aggiornata contestualmente al codice.

---

# 58. Evoluzioni previste

Il template è predisposto per integrare senza modifiche strutturali:

* ESP-IDF come framework alternativo.
* FreeRTOS con task dedicate.
* OTA via Wi-Fi.
* MQTT.
* Web Server.
* BLE.
* LittleFS.
* Secure Boot.
* Flash Encryption.
* GitLab CI/CD.
* Analisi statica avanzata.
* Unit Test automatici.
* Release automatizzate.
* Firmware signing.
* Multi-board (ESP32, ESP32-S3, ESP32-C3) tramite ambienti dedicati nel `platformio.ini`.

Questo documento costituisce la baseline ufficiale del repository **ESP32-BaseProject** e dovrà essere mantenuto come riferimento per tutti i progetti derivati.

---

# ESP32-BaseProject

# 59. CI/CD GitLab

## Obiettivo

Ogni commit sul branch `main` deve poter produrre automaticamente:

* compilazione firmware;
* esecuzione test;
* analisi statica;
* generazione artefatti;
* creazione release.

---

## Pipeline consigliata

```text
Commit
    │
    ▼
GitLab Runner
    │
    ├── Install PlatformIO
    │
    ├── Build DEV
    │
    ├── Build TEST
    │
    ├── Build RELEASE
    │
    ├── Unit Test
    │
    ├── Static Analysis
    │
    ├── Firmware Artifact
    │
    └── Release
```

---

# 60. Gestione delle dipendenze

Le dipendenze devono essere classificate.

## Core

Librerie sempre presenti.

Esempio

* ArduinoJson
* Preferences
* WiFi

---

## Optional

Installate solo quando necessarie.

Esempio

* TFT_eSPI
* AsyncWebServer
* ESPAsyncWebServer
* LovyanGFX

---

## Local

Sviluppate internamente.

Devono risiedere esclusivamente nella cartella

```text
lib
```

---

# 61. Gestione Hardware

Ogni progetto deve contenere

```text
docs/hardware
```

con:

* schema elettrico
* schema collegamenti
* alimentazione
* BOM
* revisione hardware

---

# 62. Gestione Datasheet

Tutti i datasheet devono essere copiati nel repository.

Mai affidarsi esclusivamente ai link esterni.

Struttura consigliata

```text
docs
└── datasheets
    ├── ESP32
    ├── Display
    ├── Power
    ├── Sensors
    └── Misc
```

---

# 63. Gestione immagini

```text
docs
└── images
```

Contenuto

* foto assemblaggio
* PCB
* breadboard
* screenshot
* monitor seriale
* GUI

---

# 64. Diagrammi

```text
docs
└── diagrams
```

Formato consigliato

* Draw.io
* SVG
* PDF

Conservare sempre il sorgente `.drawio`.

---

# 65. Gestione configurazione WiFi

Mai compilare SSID e password nel firmware definitivo.

Creare un modulo dedicato.

```text
network
│
├── wifi_manager.cpp
├── wifi_manager.h
└── captive_portal.cpp
```

Predisporre fin dall'inizio la possibilità di configurazione tramite:

* Captive Portal
* File JSON
* Web UI

---

# 66. Gestione configurazione JSON

Tutte le configurazioni persistenti devono utilizzare JSON.

Esempio

```json
{
    "hostname": "esp32-base",

    "mqtt": {

        "server": "",

        "port": 1883

    },

    "wifi": {

        "ssid": "",

        "password": ""

    }
}
```

---

# 67. Gestione memoria

Regole.

Preferire

```cpp
std::array
```

a

```cpp
malloc()
```

Preferire

```cpp
std::vector
```

quando realmente necessario.

Evitare allocazioni continue nel `loop()`.

Mai utilizzare nuove allocazioni ad ogni iterazione.

---

# 68. Gestione String

Preferire

```cpp
std::string
```

oppure buffer statici.

Limitare l'utilizzo della classe `String` di Arduino nelle parti critiche.

---

# 69. FreeRTOS

Quando il progetto cresce:

Separare le responsabilità.

Esempio

```text
Task WiFi

Task MQTT

Task Display

Task Sensors

Task Web

Task OTA
```

Mai creare task senza documentarne:

* stack
* priorità
* frequenza

---

# 70. Gestione Watchdog

Ogni task deve alimentare periodicamente il watchdog.

Documentare:

* timeout
* strategia di recovery
* reset automatico

---

# 71. Gestione OTA

Predisporre sempre:

```text
ota
│
├── ota_manager.cpp
└── ota_manager.h
```

Separare:

* OTA WiFi
* OTA HTTPS
* OTA USB

---

# 72. Sicurezza

Mai pubblicare:

* password
* token
* certificati
* chiavi private

Ignorare sempre

```text
include/secrets.h
```

---

# 73. Gestione certificati

Creare

```text
certificates
```

solo se realmente necessario.

Distinguere

* CA
* Client
* Server

---

# 74. Gestione Release

Ogni release deve produrre

```text
release
│
├── firmware.bin
├── firmware.elf
├── changelog.txt
├── version.txt
└── checksum.sha256
```

---

# 75. Backup

Effettuare backup periodico di:

* repository Git
* documentazione
* datasheet
* script
* configurazioni VS Code

Il firmware compilato non costituisce un backup del progetto.

---

# 76. Aggiornamenti

Prima di aggiornare librerie:

1. creare branch dedicato;
2. aggiornare una libreria per volta;
3. compilare;
4. testare;
5. effettuare merge.

---

# 77. Gestione Issue

Ogni bug deve essere registrato.

Formato consigliato

```
Titolo

Descrizione

Hardware

Firmware

Versione

Riproducibilità

Log

Screenshot

Soluzione
```

---

# 78. Convenzioni README

Ogni repository derivato dovrà iniziare con:

```
Nome progetto

Descrizione

Stato

Hardware

Software

Requisiti

Installazione

Compilazione

Flash

Monitor

Licenza
```

---

# 79. Checklist Nuovo Progetto

* Creazione repository da `ESP32-BaseProject`
* Aggiornamento `README.md`
* Aggiornamento `VERSION`
* Aggiornamento `CHANGELOG.md`
* Definizione hardware
* Inserimento datasheet
* Definizione pin
* Configurazione librerie
* Primo commit firmato
* Push su GitLab
* Configurazione mirror GitHub

---

# 80. Checklist Pre-Rilascio

* Build `dev` completata
* Build `test` completata
* Build `release` completata
* Nessun errore
* Nessun warning bloccante
* Test completati
* Versione aggiornata
* CHANGELOG aggiornato
* Tag creato
* Commit firmato
* Push GitLab eseguito
* Mirror GitHub aggiornato

---

# 81. Convenzioni per l'uso dell'AI

Per favorire suggerimenti coerenti da GitHub Copilot, Amazon Q o altri assistenti AI, mantenere nel repository:

```text
.ai
│
├── architecture.md
├── coding-guidelines.md
├── hardware.md
├── project-context.md
└── roadmap.md
```

Questi documenti descrivono il contesto del progetto e consentono agli strumenti AI di generare codice più aderente all'architettura.

---

# 82. Evoluzione del Template

`ESP32-BaseProject` è il repository di riferimento.

Tutti i progetti futuri devono derivare da esso.

Ogni miglioramento apportato al template dovrà essere:

1. sviluppato nel repository `ESP32-BaseProject`;
2. documentato nel `CHANGELOG.md`;
3. versionato con tag Git;
4. propagato ai nuovi progetti.

I progetti già esistenti potranno integrare selettivamente le modifiche, evitando aggiornamenti massivi non necessari.

---

# Fine del documento

Questo manuale costituisce la baseline tecnica del repository **ESP32-BaseProject**.

Ogni progetto ESP32 sviluppato dovrà adottare questa struttura, queste convenzioni e questo workflow, così da garantire uniformità, manutenibilità e facilità di evoluzione nel tempo.
