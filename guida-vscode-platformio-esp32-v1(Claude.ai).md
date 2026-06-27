# Guida Completa: Visual Studio Code + PlatformIO per ESP32-WROOM-32
### Ambiente Windows — Setup da zero, CLI-first

**Versione:** 1.0 — Giugno 2026  
**Target hardware:** ESP32-WROOM-32 (EZDIY / EzDelivery)  
**Target software:** Windows 10/11 x64, VS Code, PlatformIO Core + IDE

---

## Indice

1. [Prerequisiti e panoramica](#1-prerequisiti-e-panoramica)
2. [Installazione di Winget (gestore pacchetti Windows)](#2-installazione-di-winget)
3. [Installazione di Git](#3-installazione-di-git)
4. [Installazione di Python](#4-installazione-di-python)
5. [Installazione di Visual Studio Code](#5-installazione-di-visual-studio-code)
6. [Installazione di PlatformIO IDE (estensione VS Code)](#6-installazione-di-platformio-ide)
7. [Installazione di PlatformIO Core CLI](#7-installazione-di-platformio-core-cli)
8. [Driver USB per ESP32 (CP210x / CH340)](#8-driver-usb)
9. [Creazione di un nuovo progetto da CLI](#9-creazione-progetto-da-cli)
10. [Struttura del progetto generato](#10-struttura-del-progetto)
11. [Configurazione di platformio.ini per ESP32-WROOM-32](#11-configurazione-platformioini)
12. [Compilazione del firmware](#12-compilazione)
13. [Upload del firmware sulla scheda](#13-upload)
14. [Monitor seriale](#14-monitor-seriale)
15. [Pulizia e ricompilazione completa](#15-clean-e-rebuild)
16. [Gestione delle librerie](#16-gestione-librerie)
17. [Template di progetto riutilizzabile](#17-template-riutilizzabile)
18. [Riferimento rapido ai comandi](#18-riferimento-rapido)
19. [Troubleshooting comune](#19-troubleshooting)

---

## 1. Prerequisiti e panoramica

### Cosa installeremo

| Componente | Scopo | Metodo |
|---|---|---|
| Winget | Package manager Windows | Già presente su Win 10/11 aggiornato |
| Git | Version control, richiesto da PlatformIO | `winget` |
| Python 3.x | Richiesto da PlatformIO Core | `winget` |
| Visual Studio Code | IDE principale | `winget` |
| PlatformIO IDE | Estensione VS Code | `code --install-extension` |
| PlatformIO Core (CLI) | Toolchain, build, upload | `pip` |
| CP210x / CH340 driver | Comunicazione USB con ESP32 | Installer manuale |

### Requisiti di sistema

- Windows 10 (21H2+) o Windows 11
- Almeno 4 GB di RAM (8 GB consigliati)
- Almeno 5 GB di spazio libero su disco (toolchain ESP32 è ~2 GB)
- Connessione internet per scaricare le dipendenze
- Accesso come amministratore per installare i driver

### Architettura dell'ambiente

```
Windows
├── Git                    ← Version control
├── Python 3.x             ← Runtime per PlatformIO Core
│   └── pip
│       └── platformio     ← PlatformIO Core (CLI)
│           └── ~/.platformio/
│               ├── packages/      ← Toolchain, framework, SDK
│               ├── platforms/     ← espressif32
│               └── lib/           ← Librerie globali
├── Visual Studio Code
│   └── estensioni/
│       └── platformio.platformio-ide  ← UI integrata
└── Progetto ESP32/
    ├── platformio.ini     ← Configurazione build
    ├── src/main.cpp       ← Codice sorgente
    └── .pio/              ← Artefatti di build (non versionare)
```

---

## 2. Installazione di Winget

**Scopo:** Winget è il package manager ufficiale di Windows. Permette di installare e aggiornare software da riga di comando, analogamente ad `apt` su Linux.

### Verifica se Winget è già disponibile

Apri **PowerShell** o **Prompt dei comandi** e digita:

```powershell
winget --version
```

**Output atteso:**
```
v1.8.1911 (o versione superiore)
```

Se il comando non viene riconosciuto, aggiorna Windows tramite Windows Update oppure installa [App Installer](https://aka.ms/getwinget) dal Microsoft Store.

### Aggiorna Winget all'ultima versione

```powershell
winget upgrade winget
```

---

## 3. Installazione di Git

**Scopo:** Git è richiesto da PlatformIO per scaricare e aggiornare framework, librerie e strumenti. Senza Git molte operazioni di `pio pkg install` fallirebbero.

### Installazione via Winget

```powershell
winget install --id Git.Git -e --source winget
```

**Flag usati:**
- `--id Git.Git` — identificatore univoco del pacchetto
- `-e` — corrispondenza esatta del nome
- `--source winget` — usa solo il repository ufficiale Microsoft

### Verifica dell'installazione

Chiudi e riapri il terminale (necessario per aggiornare il PATH), poi:

```powershell
git --version
```

**Output atteso:**
```
git version 2.45.x (o superiore)
```

### Configurazione minima di Git

Imposta identità globale (necessaria per operazioni con repository):

```powershell
git config --global user.name "Tuo Nome"
git config --global user.email "tua@email.com"
git config --global core.autocrlf true
```

> `core.autocrlf true` su Windows converte automaticamente i line ending (CRLF ↔ LF), evitando problemi di compatibilità con ambienti Linux/Mac.

---

## 4. Installazione di Python

**Scopo:** PlatformIO Core è scritto in Python. Serve Python 3.8+ per installare `platformio` tramite `pip` e per eseguire tutti i comandi CLI.

### Installazione via Winget

```powershell
winget install --id Python.Python.3.12 -e --source winget
```

> PlatformIO supporta Python 3.8–3.12. Si consiglia 3.11 o 3.12 per la stabilità attuale.

### Verifica dell'installazione

```powershell
python --version
pip --version
```

**Output atteso:**
```
Python 3.12.x
pip 24.x from C:\Users\...\Python312\Lib\site-packages\pip (python 3.12)
```

### Aggiorna pip all'ultima versione

```powershell
python -m pip install --upgrade pip
```

### Nota su PATH

Winget aggiunge automaticamente Python al PATH di sistema. Se i comandi `python` o `pip` non vengono trovati, verifica in:
`Sistema → Variabili d'ambiente → Path` che esistano voci simili a:
```
C:\Users\<utente>\AppData\Local\Programs\Python\Python312\
C:\Users\<utente>\AppData\Local\Programs\Python\Python312\Scripts\
```

---

## 5. Installazione di Visual Studio Code

**Scopo:** VS Code è l'IDE su cui si integra PlatformIO. Leggero, estensibile, e con supporto nativo per C/C++.

### Installazione via Winget

```powershell
winget install --id Microsoft.VisualStudioCode -e --source winget
```

### Verifica dell'installazione

```powershell
code --version
```

**Output atteso:**
```
1.90.x
<commit hash>
x64
```

> Se `code` non viene trovato, riapri il terminale o verifica che `C:\Users\<utente>\AppData\Local\Programs\Microsoft VS Code\bin` sia nel PATH.

### Installazione delle estensioni C/C++ (raccomandate)

```powershell
code --install-extension ms-vscode.cpptools
code --install-extension ms-vscode.cpptools-extension-pack
```

Queste estensioni forniscono syntax highlighting, IntelliSense e debugging per C/C++, complementari a PlatformIO.

---

## 6. Installazione di PlatformIO IDE

**Scopo:** L'estensione PlatformIO per VS Code fornisce l'interfaccia grafica integrata: project manager, build toolbar, device management, e accesso rapido al terminale PlatformIO.

### Installazione via CLI

```powershell
code --install-extension platformio.platformio-ide
```

**Output atteso:**
```
Installing extensions...
Extension 'platformio.platformio-ide' v3.x.x was successfully installed.
```

### Verifica nell'IDE

1. Apri VS Code
2. Nella barra laterale sinistra deve comparire l'icona di PlatformIO (una formica stilizzata)
3. Al primo avvio, PlatformIO installa automaticamente PlatformIO Core — questo richiede qualche minuto

> **Nota:** Se hai già installato PlatformIO Core via `pip` (vedi sezione successiva), l'estensione lo rileva e lo usa. Non installa una copia duplicata.

---

## 7. Installazione di PlatformIO Core CLI

**Scopo:** PlatformIO Core è il motore vero e proprio — gestisce la toolchain, la compilazione, l'upload e le librerie. Installarlo separatamente via `pip` permette di usarlo da qualsiasi terminale, indipendentemente da VS Code.

### Installazione via pip

```powershell
pip install platformio
```

### Verifica dell'installazione

```powershell
pio --version
```

**Output atteso:**
```
PlatformIO Core, version 6.x.x
```

### Aggiunta al PATH (se necessario)

Se `pio` non viene trovato, il problema è che `pip install` mette gli script in una directory non nel PATH. Trova la directory:

```powershell
python -c "import site; print(site.USER_SCRIPTS)"
```

Aggiungila manualmente al PATH di sistema oppure usa:

```powershell
python -m platformio --version
```

come alternativa temporanea (meno comodo ma sempre funzionante).

### Aggiornamento futuro di PlatformIO Core

```powershell
pip install --upgrade platformio
```

### Download della piattaforma ESP32

Installa ora la piattaforma Espressif32 in modo da averla già pronta (operazione ~2 GB, fatta una sola volta):

```powershell
pio platform install espressif32
```

**Output atteso (esempio):**
```
Platform Manager: Installing espressif32
Downloading  [####################################]  100%
...
Platform Manager: espressif32 @ 6.x.x has been successfully installed!
```

---

## 8. Driver USB

**Scopo:** L'ESP32-WROOM-32 di EzDelivery usa tipicamente uno dei due chip USB-to-serial seguenti. Senza il driver corretto, il PC non vede la porta COM.

### Identificazione del chip

Collega la scheda via USB. Apri **Gestione dispositivi** (`devmgmt.msc`):
- Se compare "Silicon Labs CP210x" → installa **CP210x**
- Se compare "CH340" o "CH341" → installa **CH340**
- Se compare "Porta COM" già funzionante → il driver è già installato

In alternativa, da PowerShell:

```powershell
Get-PnpDevice -Class Ports | Select-Object FriendlyName, Status
```

### Installazione driver CP210x (Silicon Labs)

Download diretto dal sito ufficiale Silicon Labs:

```powershell
winget install --id SiliconLaboratories.CP210xUniversalWindowsDriver -e
```

Se non disponibile su Winget, scarica manualmente da:
`https://www.silabs.com/developers/usb-to-uart-bridge-vcp-drivers`

Esegui l'installer e riavvia se richiesto.

### Installazione driver CH340 / CH341

Scarica da: `https://www.wch-ic.com/downloads/CH341SER_ZIP.html`

Esegui `CH341SER.EXE` come amministratore → Install.

### Verifica della porta COM

Dopo l'installazione del driver, con la scheda collegata:

```powershell
mode
```

Oppure, più preciso:

```powershell
Get-PnpDevice -Class Ports -Status OK | Select-Object FriendlyName
```

**Output atteso (esempio):**
```
Silicon Labs CP210x USB to UART Bridge (COM3)
```

Annota il numero di porta (es. `COM3`) — ti servirà per la configurazione di `platformio.ini`.

---

## 9. Creazione di un nuovo progetto da CLI

**Scopo:** Creare la struttura del progetto PlatformIO per ESP32, con tutti i file di configurazione necessari, senza usare la GUI di VS Code.

### Creazione della directory del progetto

```powershell
mkdir C:\Progetti\ESP32\MioProgetto
cd C:\Progetti\ESP32\MioProgetto
```

### Inizializzazione del progetto PlatformIO

```powershell
pio project init --board esp32dev --project-option "framework=arduino"
```

**Parametri:**
- `--board esp32dev` — identificatore della board ESP32-WROOM-32 generica (compatibile con EzDelivery)
- `--project-option "framework=arduino"` — usa Arduino framework (il più comune per ESP32)

**Output atteso:**
```
The current working directory C:\Progetti\ESP32\MioProgetto will be used for the project.

The next files/directories have been created in C:\Progetti\ESP32\MioProgetto
include - Put project header files here
lib - Put project specific (private) libraries here
src - Put project source files here
platformio.ini - Project Configuration File

Project has been successfully initialized! Useful commands:
`pio run` - process/build project from the current directory
`pio run --target upload` - upload firmware to a target
`pio run --target clean` - clean project files
`pio device list` - list available devices/outputs
`pio device monitor` - open a serial port for communication
```

### Verifica della board

Per confermare che `esp32dev` sia la board corretta:

```powershell
pio boards | findstr esp32dev
```

**Output atteso:**
```
esp32dev    Espressif ESP32 Dev Module    240MHz    4MB    320KB    espressif32
```

> La scheda EzDelivery ESP32-WROOM-32 è identica funzionalmente all'"Espressif ESP32 Dev Module". L'identificatore `esp32dev` è quello corretto.

### Apertura del progetto in VS Code

```powershell
code .
```

---

## 10. Struttura del progetto generato

Dopo `pio project init`, la struttura è la seguente:

```
MioProgetto/
│
├── platformio.ini          ← File di configurazione principale (EDITARE QUESTO)
│
├── src/                    ← Codice sorgente del progetto
│   └── main.cpp            ← File principale (da creare manualmente)
│
├── include/                ← Header file del progetto (.h)
│   └── README              ← Placeholder con istruzioni
│
├── lib/                    ← Librerie private del progetto
│   └── README              ← Placeholder con istruzioni
│
├── test/                   ← Test unitari (opzionale)
│   └── README
│
└── .pio/                   ← Directory di build (generata automaticamente)
    ├── build/              ← Firmware compilato (.elf, .bin, .hex)
    └── libdeps/            ← Dipendenze scaricate
```

> **Importante:** `.pio/` NON va versionata con Git. PlatformIO la ricrea automaticamente.

### Crea il file .gitignore corretto

```powershell
@"
.pio/
.vscode/
"@ | Out-File -FilePath .gitignore -Encoding UTF8
```

### Crea il file sorgente principale

PlatformIO non crea `src/main.cpp` automaticamente. Crealo con un esempio base:

```powershell
@"
#include <Arduino.h>

void setup() {
  Serial.begin(115200);
  Serial.println("ESP32 pronto!");
  pinMode(2, OUTPUT);  // LED interno su GPIO2
}

void loop() {
  digitalWrite(2, HIGH);
  delay(500);
  digitalWrite(2, LOW);
  delay(500);
  Serial.println("blink");
}
"@ | Out-File -FilePath src\main.cpp -Encoding UTF8
```

---

## 11. Configurazione di platformio.ini

**Scopo:** `platformio.ini` è il cuore della configurazione PlatformIO. Definisce la board, il framework, la porta seriale, la velocità di upload e tutte le opzioni di build.

### Configurazione base per ESP32-WROOM-32 EzDelivery

Sostituisci il contenuto di `platformio.ini` con:

```ini
; ============================================================
; PlatformIO Configuration — ESP32-WROOM-32 (EzDelivery)
; ============================================================

[platformio]
; Directory di default per i sorgenti
src_dir = src
; Directory per le librerie private
lib_dir = lib
; Directory per gli include
include_dir = include
; Directory di build (non modificare)
build_dir = .pio/build
; Librerie globali scaricate
libdeps_dir = .pio/libdeps

; ============================================================
; Ambiente di sviluppo principale
; ============================================================
[env:esp32dev]

; --- Board e Framework ---
platform  = espressif32
board     = esp32dev
framework = arduino

; --- Velocità CPU ---
; ESP32-WROOM-32 supporta 80, 160, 240 MHz
board_build.f_cpu = 240000000L

; --- Flash ---
; esp32dev ha 4MB di Flash
board_build.flash_size = 4MB
board_build.flash_mode = dio
board_build.flash_freq = 80m

; --- Partition Scheme ---
; default_8MB: per schede 8MB | huge_app: app grande senza OTA
; default: 4MB con OTA (raccomandato)
board_build.partitions = default.csv

; --- Porta seriale ---
; Modifica COM3 con la porta rilevata sul tuo PC (vedi sezione 8)
; Lascia commentato per rilevamento automatico (meno affidabile)
upload_port = COM3
monitor_port = COM3

; --- Velocità upload ---
; 921600 è il massimo stabile su CP210x; abbassa a 460800 se hai errori
upload_speed = 921600

; --- Monitor seriale ---
monitor_speed = 115200
monitor_filters = esp32_exception_decoder, default

; --- Flags di compilazione ---
build_flags =
    -DCORE_DEBUG_LEVEL=3    ; 0=None 1=Error 2=Warn 3=Info 4=Debug 5=Verbose
    -DARDUINO_ESP32_DEV
    -std=gnu++17            ; C++17

; --- Flags solo per il linker ---
; build_unflags = -std=gnu++11  ; Rimuovi flag di default se necessario

; --- Librerie (aggiunte tramite PlatformIO Registry o Git) ---
; lib_deps =
;     knolleary/PubSubClient @ ^2.8
;     bblanchon/ArduinoJson @ ^7.0

; --- Timeout upload (secondi) ---
upload_resetmethod = default
```

### Verifica della configurazione

```powershell
pio project config
```

**Output atteso (esempio):**
```
[env:esp32dev]
platform = espressif32
board = esp32dev
framework = arduino
upload_port = COM3
...
```

### Identificatori di porta alternativi

Se preferisci non hardcodare la porta, usa il rilevamento automatico per upload:

```ini
; Rimuovi upload_port dal .ini e usa --upload-port al momento dell'upload:
; pio run -t upload --upload-port COM3
```

---

## 12. Compilazione del firmware

**Scopo:** Tradurre il codice sorgente C++ in un binario `.bin` pronto per l'ESP32. La prima compilazione scarica la toolchain e l'SDK (~1 GB) — richiede qualche minuto.

### Compilazione standard

Dalla directory del progetto:

```powershell
pio run
```

Oppure, specificando l'ambiente esplicitamente:

```powershell
pio run --environment esp32dev
```

**Output atteso (prima compilazione):**
```
Processing esp32dev (platform: espressif32; board: esp32dev; framework: arduino)
----------------------------------------------------------------------
Tool Manager: Installing platformio/toolchain-xtensa-esp32 @ ~2.80400.0
Downloading  [####################################]  100%
...
Compiling .pio/build/esp32dev/src/main.cpp.o
Linking .pio/build/esp32dev/firmware.elf
Checking size .pio/build/esp32dev/firmware.elf
Advanced Memory Usage is available via "PlatformIO Home > Project Inspect"
RAM:   [=         ]   9.0% (used 29556 bytes from 327680 bytes)
Flash: [==        ]  15.3% (used 201065 bytes from 1310720 bytes)
Building .pio/build/esp32dev/firmware.bin
============================= [SUCCESS] Took 45.23 seconds
```

### Compilazione con output verboso (per debug)

```powershell
pio run -v
```

### Verifica del binario generato

```powershell
dir .pio\build\esp32dev\
```

I file chiave sono:
- `firmware.bin` — immagine completa da flashare
- `firmware.elf` — con simboli di debug
- `partitions.bin` — tabella delle partizioni

---

## 13. Upload del firmware sulla scheda

**Scopo:** Trasferire il firmware compilato sulla Flash dell'ESP32 tramite USB.

### Prima dell'upload: modalità boot

La scheda EzDelivery ESP32-WROOM-32 generalmente supporta l'auto-reset tramite DTR/RTS del chip USB-serial. Non dovresti dover premere nulla manualmente.

Se l'upload fallisce con `Failed to connect`, tieni premuto il pulsante **BOOT** (GPIO0) sulla scheda durante l'avvio dell'upload, poi rilascialo dopo i primi "Connecting...".

### Upload standard

```powershell
pio run --target upload
```

Oppure in forma abbreviata:

```powershell
pio run -t upload
```

**Output atteso:**
```
Processing esp32dev (platform: espressif32; board: esp32dev; framework: arduino)
----------------------------------------------------------------------
Uploading .pio/build/esp32dev/firmware.bin
esptool.py v4.x.x
Serial port COM3
Connecting....
Chip is ESP32-D0WDQ6 (revision v1.0)
Features: WiFi, BT, Dual Core, 240MHz, VRef calibration in efuse, ...
Crystal is 26MHz
MAC: xx:xx:xx:xx:xx:xx
Uploading stub...
Running stub...
Stub running...
Changing baud rate to 921600
Changed.
Configuring flash size...
Flash will be erased from 0x00001000 to 0x000b2fff...
...
Writing at 0x00001000... (100 %)
Wrote 660000 bytes (424012 compressed) at 0x00001000 in 8.2 seconds
Hash of data verified.

Leaving...
Hard resetting via RTS pin...
============================= [SUCCESS] Took 12.56 seconds
```

### Upload + compilazione in un solo comando

```powershell
pio run -t upload
```

PlatformIO compila automaticamente prima dell'upload se ci sono modifiche al sorgente.

### Specifica manuale della porta (override del .ini)

```powershell
pio run -t upload --upload-port COM5
```

---

## 14. Monitor seriale

**Scopo:** Leggere l'output seriale dell'ESP32 (Serial.println, log, debug) in tempo reale dal terminale.

### Avvio del monitor

```powershell
pio device monitor
```

Con la porta esplicitamente specificata:

```powershell
pio device monitor --port COM3 --baud 115200
```

**Output atteso:**
```
--- Terminal on COM3 | 115200 8-N-1
--- Available filters and text transformations: colorize, debug, default, ...
--- More details at https://bit.ly/pio-monitor-filters
--- Quit: Ctrl+C | Menu: Ctrl+T | Help: Ctrl+T followed by Ctrl+H
ESP32 pronto!
blink
blink
blink
```

### Comandi utili nel monitor

| Tasto | Azione |
|---|---|
| `Ctrl+C` | Chiude il monitor |
| `Ctrl+T` | Apre il menu interattivo |
| `Ctrl+T` poi `Ctrl+R` | Reset della scheda |
| `Ctrl+T` poi `Ctrl+H` | Help completo |

### Filter esp32_exception_decoder

Il filter `esp32_exception_decoder` nel `platformio.ini` decodifica automaticamente i backtrace di eccezioni/crash dell'ESP32, trasformando gli indirizzi esadecimali in riferimenti a file e riga:

```
Guru Meditation Error: Core 0 panic'ed (LoadProhibited)
Backtrace: 0x400d3f7a:0x3ffb2160
  -> File: src/main.cpp, Line: 42
```

### Lista dispositivi disponibili

```powershell
pio device list
```

**Output atteso:**
```
/dev/COM3
----------
Hardware ID: USB VID:PID=10C4:EA60 SER=0001 LOCATION=1-1
Description: Silicon Labs CP210x USB to UART Bridge
```

---

## 15. Pulizia e ricompilazione completa

**Scopo:** Rimuovere tutti gli artefatti di build precedenti e ricompilare da zero. Utile quando si sospettano problemi di cache o dopo modifiche strutturali al progetto.

### Pulizia degli artefatti di build

```powershell
pio run --target clean
```

Oppure:

```powershell
pio run -t clean
```

**Output atteso:**
```
Processing esp32dev (platform: espressif32; board: esp32dev; framework: arduino)
----------------------------------------------------------------------
Removed .pio/build/esp32dev
============================= [SUCCESS] Took 0.56 seconds
```

### Ricompilazione completa (clean + build)

```powershell
pio run -t clean && pio run
```

### Pulizia totale incluse le librerie scaricate

```powershell
pio run -t clean
Remove-Item -Recurse -Force .pio\libdeps
```

> Dopo aver rimosso `libdeps`, il prossimo `pio run` riscarica tutte le librerie dichiarate in `lib_deps`.

### Pulizia totale (equivalente a reset completo)

```powershell
Remove-Item -Recurse -Force .pio
```

Il prossimo `pio run` ricostruisce tutto da zero. La toolchain rimane installata globalmente in `~\.platformio\`.

---

## 16. Gestione delle librerie

**Scopo:** PlatformIO ha un sistema di gestione librerie potente. Le librerie possono essere installate globalmente, per ambiente o per singolo progetto.

### Ricerca di una libreria

```powershell
pio pkg search "ArduinoJson"
```

**Output atteso:**
```
Found N packages (page 1 of M)
...
bblanchon/ArduinoJson      A JSON parser and printer library for Arduino
                           and embedded C++.
```

### Installazione di una libreria nel progetto (metodo consigliato)

Il metodo più robusto è dichiarare le dipendenze in `platformio.ini`:

```ini
[env:esp32dev]
...
lib_deps =
    bblanchon/ArduinoJson @ ^7.0.0
    knolleary/PubSubClient @ ^2.8.0
    ESP8266WiFi @ *
```

Poi PlatformIO le scarica automaticamente al prossimo build:

```powershell
pio run
```

### Installazione manuale di una libreria (via CLI)

```powershell
pio pkg install --library "bblanchon/ArduinoJson@^7.0"
```

Installa nella directory locale del progetto (`.pio/libdeps/`).

### Installazione globale (disponibile per tutti i progetti)

```powershell
pio pkg install --global --library "bblanchon/ArduinoJson@^7.0"
```

### Installazione da URL Git

```powershell
pio pkg install --library "https://github.com/autor/libreria.git"
```

Con tag specifico:

```powershell
pio pkg install --library "https://github.com/autor/libreria.git#v1.2.0"
```

### Lista librerie installate nel progetto

```powershell
pio pkg list
```

### Aggiornamento di una libreria

```powershell
pio pkg update --library "bblanchon/ArduinoJson"
```

Aggiorna tutte le librerie del progetto:

```powershell
pio pkg update
```

### Rimozione di una libreria

```powershell
pio pkg uninstall --library "bblanchon/ArduinoJson"
```

### Dove si trovano le librerie

| Tipo | Percorso |
|---|---|
| Progetto (locale) | `.pio/libdeps/esp32dev/` |
| Globali | `C:\Users\<utente>\.platformio\lib\` |
| Private (sorgente) | `lib/<NomeLibreria>/` |

### Librerie private nel progetto

Per includere librerie scritte da te, crea la struttura in `lib/`:

```
lib/
└── MiaLibreria/
    ├── MiaLibreria.h
    └── MiaLibreria.cpp
```

PlatformIO le rileva e include automaticamente nel build.

---

## 17. Template di progetto riutilizzabile

**Scopo:** Creare una struttura standard di progetto che possa essere copiata e riusata per ogni nuovo sviluppo ESP32, con configurazione già pronta.

### Struttura del template

```
ESP32-Template/
├── .gitignore
├── platformio.ini
├── README.md
├── src/
│   └── main.cpp
├── include/
│   └── config.h
├── lib/
│   └── .gitkeep
└── test/
    └── .gitkeep
```

### Script PowerShell per generare il template

Salva il seguente script come `Crea-Progetto-ESP32.ps1`:

```powershell
# ============================================================
# Crea-Progetto-ESP32.ps1
# Genera un nuovo progetto PlatformIO per ESP32-WROOM-32
# Uso: .\Crea-Progetto-ESP32.ps1 -NomeProgetto "MioProgetto"
# ============================================================

param(
    [Parameter(Mandatory=$true)]
    [string]$NomeProgetto,
    
    [string]$Destinazione = "C:\Progetti\ESP32",
    
    [string]$PortaCOM = "COM3"
)

$ProgettoPath = Join-Path $Destinazione $NomeProgetto

# Crea directory
New-Item -ItemType Directory -Path $ProgettoPath -Force | Out-Null
Set-Location $ProgettoPath

Write-Host "Inizializzazione progetto PlatformIO..." -ForegroundColor Cyan
pio project init --board esp32dev --project-option "framework=arduino" --silent

# ============================================================
# platformio.ini
# ============================================================
@"
[platformio]
src_dir     = src
lib_dir     = lib
include_dir = include
build_dir   = .pio/build
libdeps_dir = .pio/libdeps

[env:esp32dev]
platform             = espressif32
board                = esp32dev
framework            = arduino
board_build.f_cpu    = 240000000L
board_build.flash_size = 4MB
board_build.flash_mode = dio
board_build.flash_freq = 80m
board_build.partitions = default.csv
upload_port          = $PortaCOM
monitor_port         = $PortaCOM
upload_speed         = 921600
monitor_speed        = 115200
monitor_filters      = esp32_exception_decoder, default
build_flags          =
    -DCORE_DEBUG_LEVEL=3
    -std=gnu++17
"@ | Out-File -FilePath platformio.ini -Encoding UTF8

# ============================================================
# src/main.cpp
# ============================================================
@"
#include <Arduino.h>
#include "config.h"

void setup() {
    Serial.begin(SERIAL_BAUD);
    Serial.printf("Progetto: %s\n", PROJECT_NAME);
    Serial.printf("Versione: %s\n", PROJECT_VERSION);
    pinMode(LED_BUILTIN, OUTPUT);
}

void loop() {
    digitalWrite(LED_BUILTIN, HIGH);
    delay(500);
    digitalWrite(LED_BUILTIN, LOW);
    delay(500);
}
"@ | Out-File -FilePath src\main.cpp -Encoding UTF8

# ============================================================
# include/config.h
# ============================================================
@"
#pragma once

// Identificazione progetto
#define PROJECT_NAME    "$NomeProgetto"
#define PROJECT_VERSION "0.1.0"

// Seriale
#define SERIAL_BAUD     115200

// GPIO
#define LED_BUILTIN     2      // GPIO2 = LED interno ESP32-WROOM-32
"@ | Out-File -FilePath include\config.h -Encoding UTF8

# ============================================================
# .gitignore
# ============================================================
@"
# PlatformIO build artifacts
.pio/

# VS Code settings (keep or remove based on preference)
.vscode/

# OS files
.DS_Store
Thumbs.db
"@ | Out-File -FilePath .gitignore -Encoding UTF8

# ============================================================
# README.md
# ============================================================
@"
# $NomeProgetto

Progetto ESP32-WROOM-32 sviluppato con PlatformIO + VS Code.

## Hardware

- **Board:** EZDIY/EzDelivery ESP32-WROOM-32
- **CPU:** Xtensa LX6 dual-core @ 240 MHz
- **Flash:** 4 MB
- **Framework:** Arduino

## Comandi principali

| Operazione | Comando |
|---|---|
| Compilazione | ``pio run`` |
| Upload | ``pio run -t upload`` |
| Monitor seriale | ``pio device monitor`` |
| Clean | ``pio run -t clean`` |
| Rebuild | ``pio run -t clean && pio run`` |

## Configurazione

Modifica ``include/config.h`` per le costanti del progetto.
Modifica ``platformio.ini`` per la porta COM e le opzioni di build.
"@ | Out-File -FilePath README.md -Encoding UTF8

# File placeholder
"" | Out-File -FilePath lib\.gitkeep -Encoding UTF8
"" | Out-File -FilePath test\.gitkeep -Encoding UTF8

# Inizializzazione Git
git init | Out-Null
git add . | Out-Null
git commit -m "Initial commit: ESP32 project template" | Out-Null

Write-Host ""
Write-Host "✓ Progetto '$NomeProgetto' creato in: $ProgettoPath" -ForegroundColor Green
Write-Host ""
Write-Host "Prossimi passi:" -ForegroundColor Yellow
Write-Host "  1. cd '$ProgettoPath'"
Write-Host "  2. code ."
Write-Host "  3. pio run          (prima compilazione)"
Write-Host "  4. pio run -t upload (upload sulla scheda)"
Write-Host "  5. pio device monitor (monitor seriale)"
```

### Utilizzo dello script

```powershell
# Permettere l'esecuzione di script locali (una tantum)
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# Creare un nuovo progetto
.\Crea-Progetto-ESP32.ps1 -NomeProgetto "TestLED" -PortaCOM "COM3"
```

---

## 18. Riferimento rapido ai comandi

### Tabella completa PlatformIO CLI

| Operazione | Comando |
|---|---|
| Nuova versione PlatformIO | `pip install --upgrade platformio` |
| Crea progetto | `pio project init --board esp32dev` |
| Compila | `pio run` |
| Compila verboso | `pio run -v` |
| Upload | `pio run -t upload` |
| Compila + Upload | `pio run -t upload` |
| Upload su porta specifica | `pio run -t upload --upload-port COM5` |
| Monitor seriale | `pio device monitor` |
| Monitor su porta/baud specifici | `pio device monitor --port COM3 --baud 115200` |
| Lista dispositivi | `pio device list` |
| Clean | `pio run -t clean` |
| Clean + Rebuild | `pio run -t clean && pio run` |
| Mostra config progetto | `pio project config` |
| Cerca libreria | `pio pkg search "nome"` |
| Installa libreria (progetto) | `pio pkg install --library "autore/nome@^versione"` |
| Installa libreria (globale) | `pio pkg install -g --library "autore/nome"` |
| Lista librerie | `pio pkg list` |
| Aggiorna librerie | `pio pkg update` |
| Rimuovi libreria | `pio pkg uninstall --library "nome"` |
| Lista board disponibili | `pio boards` |
| Info su una board | `pio boards esp32dev` |
| Lista piattaforme installate | `pio platform list` |
| Installa piattaforma | `pio platform install espressif32` |
| Aggiorna piattaforma | `pio platform update` |
| Help generale | `pio --help` |
| Help comando specifico | `pio run --help` |

---

## 19. Troubleshooting comune

### Errore: "Failed to connect to ESP32"

**Sintomi:** L'upload si blocca su `Connecting....` e va in timeout.

**Soluzioni:**
1. Tieni premuto il pulsante **BOOT** sulla scheda durante l'upload
2. Verifica che la porta COM nel `platformio.ini` sia corretta (`pio device list`)
3. Riduci la velocità di upload: `upload_speed = 460800`
4. Controlla il cavo USB (alcuni cavi sono solo per la ricarica, non per dati)
5. Reinstalla il driver USB

---

### Errore: "Port COM3 not found"

**Sintomi:** PlatformIO non trova la porta seriale.

**Soluzioni:**
1. `pio device list` — verifica quale porta è assegnata
2. Scollega e ricollega il cavo USB
3. Controlla Gestione Dispositivi per errori sul driver
4. Prova una porta USB diversa sul PC

---

### Errore: "Python not found" o "pip not found"

**Soluzioni:**
```powershell
# Verifica installazione Python
python --version
where python

# Aggiungi Python al PATH manualmente
$env:PATH += ";C:\Users\$env:USERNAME\AppData\Local\Programs\Python\Python312\"
$env:PATH += ";C:\Users\$env:USERNAME\AppData\Local\Programs\Python\Python312\Scripts\"
```

---

### Errore: "espressif32 package not found" o toolchain mancante

**Soluzioni:**
```powershell
# Forza reinstallazione della piattaforma
pio platform uninstall espressif32
pio platform install espressif32

# Oppure aggiorna tutto
pio platform update
```

---

### Errore di compilazione: "Arduino.h: No such file or directory"

**Causa:** Il framework Arduino non è ancora scaricato, o c'è un problema con l'installazione.

**Soluzione:**
```powershell
pio run -v  # Output verboso per vedere l'errore esatto
pio platform install espressif32 --with-package framework-arduinoespressif32
```

---

### Monitor seriale: nessun output o caratteri corrotti

**Soluzioni:**
1. Verifica che `monitor_speed` in `platformio.ini` corrisponda a `Serial.begin()` nel codice (entrambi 115200)
2. Premi il pulsante **EN/RST** sulla scheda per resettare dopo aver aperto il monitor
3. Assicurati che nessun altro programma stia usando la porta COM (Arduino IDE, PuTTY, ecc.)

---

### VS Code non riconosce i simboli ESP32 (IntelliSense rotto)

**Soluzione:**
1. Apri la Command Palette di VS Code (`Ctrl+Shift+P`)
2. Digita: `PlatformIO: Rebuild IntelliSense Index`
3. Attendi il completamento

Oppure da CLI:
```powershell
pio run --target compiledb
```

Genera `compile_commands.json` che VS Code/clangd usano per IntelliSense.

---

### Memoria insufficiente per il firmware

**Sintomi:** Errore "sketch too big" o warning sull'occupazione della RAM.

**Soluzioni:**
```ini
; In platformio.ini — cambia partition scheme
board_build.partitions = huge_app.csv    ; più spazio app, niente OTA
; oppure
board_build.partitions = min_spiffs.csv  ; minimo SPIFFS, più app
```

Abilita ottimizzazione in `platformio.ini`:
```ini
build_flags =
    -Os        ; Ottimizza per dimensione (invece di -O2)
```

---

*Fine guida. Versione 1.0 — Giugno 2026*
