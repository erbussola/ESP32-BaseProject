# ESP32-BaseProject

# Runbook Fase 3

## 23. Configurazione professionale PlatformIO

Il file `platformio.ini` dovrà essere il punto centrale di tutta la configurazione del progetto.

Sostituire il file generato automaticamente con il seguente.

```ini
; =============================================================================
; ESP32-BaseProject
; PlatformIO Configuration
; =============================================================================

[platformio]

description = ESP32 Base Project

default_envs = dev

; =============================================================================
; Shared configuration
; =============================================================================

[env]

platform = espressif32

board = esp32dev

framework = arduino

; -----------------------------------------------------------------------------
; SERIAL
; -----------------------------------------------------------------------------

monitor_speed = 115200

upload_speed = 460800

monitor_filters =
    colorize
    time
    esp32_exception_decoder

; -----------------------------------------------------------------------------
; LIBRARIES
; -----------------------------------------------------------------------------

lib_ldf_mode = chain+

lib_compat_mode = strict

; -----------------------------------------------------------------------------
; BUILD
; -----------------------------------------------------------------------------

build_unflags =
    -Os

build_flags =
    -Wall
    -Wextra
    -Winvalid-pch
    -DCORE_DEBUG_LEVEL=3
    -DAPP_NAME=\"ESP32-BaseProject\"

; -----------------------------------------------------------------------------
; CHECK
; -----------------------------------------------------------------------------

check_tool = cppcheck

check_flags =
    cppcheck:
        --enable=warning
        --enable=performance
        --enable=style

; =============================================================================
; Development
; =============================================================================

[env:dev]

build_type = debug

build_flags =
    ${env.build_flags}
    -DENV_DEV

; =============================================================================
; Test
; =============================================================================

[env:test]

build_type = debug

build_flags =
    ${env.build_flags}
    -DENV_TEST

; =============================================================================
; Release
; =============================================================================

[env:release]

build_type = release

build_flags =
    ${env.build_flags}
    -DENV_RELEASE
```

---

# 24. Configurazione EditorConfig

Creare

```
.editorconfig
```

contenuto

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

[*.json]

indent_size = 2

[*.yaml]

indent_size = 2

[*.yml]

indent_size = 2

[*.ps1]

indent_size = 4

[*.cpp]

indent_size = 4

[*.h]

indent_size = 4

[*.hpp]

indent_size = 4
```

---

# 25. Configurazione .gitattributes

Creare

```
.gitattributes
```

```gitattributes
* text=auto eol=lf

*.ps1 text eol=crlf
*.bat text eol=crlf

*.png binary
*.jpg binary
*.pdf binary
*.zip binary
*.bin binary
*.elf binary
*.hex binary

.pio/** export-ignore
```

---

# 26. Configurazione .gitignore

Creare

```
.gitignore
```

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

###############################################################################
# Binary
###############################################################################

*.bin

*.elf

*.hex

*.o

*.obj

###############################################################################
# Logs
###############################################################################

*.log

###############################################################################
# Temp
###############################################################################

*.tmp

*.bak

###############################################################################
# Windows
###############################################################################

Thumbs.db

Desktop.ini

###############################################################################
# Python
###############################################################################

__pycache__/

###############################################################################
# Release
###############################################################################

release/

###############################################################################
# Secrets
###############################################################################

include/secrets.h
```

---

# 27. Creazione struttura documentazione

```powershell
mkdir docs

mkdir docs\datasheets

mkdir docs\diagrams

mkdir docs\hardware

mkdir docs\images

mkdir docs\notes

mkdir docs\references
```

Verifica

```powershell
tree docs /A
```

---

# 28. Creazione struttura include

```powershell
New-Item include\config.h

New-Item include\pins.h

New-Item include\version.h

New-Item include\build_info.h

New-Item include\secrets.example.h
```

---

# 29. Creazione struttura src

```powershell
mkdir src\core

mkdir src\network

mkdir src\display

mkdir src\storage

mkdir src\sensors

mkdir src\services

mkdir src\ota

mkdir src\web
```

---

# 30. Creazione struttura lib

```powershell
mkdir lib\Display

mkdir lib\Network

mkdir lib\Sensors

mkdir lib\Utils
```

---

# 31. Creazione struttura test

```powershell
mkdir test\test_wifi

mkdir test\test_storage

mkdir test\test_display

mkdir test\test_configuration
```

---

# 32. Struttura finale

Verifica

```powershell
tree /A
```

Output atteso

```
ESP32-BaseProject
│
├── docs
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

# 33. Primo firmware

Sostituire

```
src/main.cpp
```

con

```cpp
#include <Arduino.h>

constexpr uint32_t LED_BLINK_MS = 1000;

void setup()
{
    pinMode(LED_BUILTIN, OUTPUT);

    Serial.begin(115200);

    while (!Serial)
    {
        delay(10);
    }

    Serial.println();
    Serial.println("=======================================");
    Serial.println("ESP32-BaseProject");
    Serial.println("Boot completed");
    Serial.println("=======================================");
}

void loop()
{
    static uint32_t previous = 0;

    if (millis() - previous >= LED_BLINK_MS)
    {
        previous = millis();

        digitalWrite(
            LED_BUILTIN,
            !digitalRead(LED_BUILTIN));

        Serial.println("Heartbeat");
    }
}
```

---

# 34. Prima compilazione

Da VS Code

```
Terminal

Run Task

Build
```

oppure

PowerShell

```powershell
.\tools\build.ps1
```

---

# 35. Primo Flash

```powershell
.\tools\flash.ps1
```

---

# 36. Monitor Seriale

```powershell
.\tools\monitor.ps1
```

Output atteso

```
=======================================
ESP32-BaseProject
Boot completed
=======================================

Heartbeat

Heartbeat

Heartbeat
```

---

# 37. Primo Commit

```powershell
git status
```

```powershell
git add .
```

```powershell
git commit -S -m "feat: bootstrap ESP32-BaseProject"
```

```powershell
git push origin main
```

```powershell
git push github main
```

---

# 38. Snapshot iniziale

Creare il primo tag.

```powershell
git tag -a v1.0.0 -m "ESP32-BaseProject bootstrap"
```

Push

```powershell
git push origin --tags
```

Mirror

```powershell
git push github --tags
```

---

## Fine della fase di bootstrap

Da questo punto il repository è completamente inizializzato e costituisce la **baseline** da cui derivare tutti i futuri progetti ESP32. La fase successiva del Runbook sarà dedicata all'automazione avanzata: script idempotenti, bootstrap completamente automatico, GitLab CI/CD, aggiornamenti del template, OTA, debugging avanzato e integrazione con strumenti di qualità del codice.
