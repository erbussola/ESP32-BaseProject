# ESP32-BaseProject

> Template professionale di riferimento per tutti i progetti basati su ESP32, PlatformIO, Visual Studio Code e Git.

---

# Stato del Progetto

**Versione Template:** 1.0.0

Questo repository costituisce la baseline ufficiale da cui creare tutti i futuri progetti ESP32.

---

# Obiettivi

L'obiettivo del progetto è fornire un ambiente di sviluppo professionale, uniforme e facilmente manutenibile.

Caratteristiche principali:

- Struttura standardizzata del repository
- Configurazione completa di PlatformIO
- Configurazione completa di Visual Studio Code
- Workflow Git professionale
- Commit firmati (SSH Signing)
- Script PowerShell per l'automazione
- Documentazione completa
- Predisposizione per GitLab CI/CD
- Predisposizione OTA
- Architettura modulare

---

# Hardware supportato

Attualmente:

- ESP32-WROOM-32
- ESP32 Dev Module (`board = esp32dev`)

Previsto:

- ESP32-S3
- ESP32-C3

---

# Requisiti Software

| Componente | Versione consigliata |
|------------|---------------------:|
| Windows | 11 x64 |
| Git | 2.54 o superiore |
| Visual Studio Code | Ultima versione |
| PlatformIO IDE | Ultima versione |
| PowerShell | 7.x (compatibile con Windows PowerShell 5.1) |

---

# Struttura del Repository

```text
ESP32-BaseProject
├── docs/
├── include/
├── lib/
├── src/
├── test/
├── tools/
├── .vscode/
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

# Avvio rapido

1. Clonare il repository.
2. Aprire la cartella con Visual Studio Code.
3. Installare le estensioni consigliate.
4. Collegare la scheda ESP32.
5. Compilare il firmware.
6. Caricare il firmware.
7. Aprire il monitor seriale.

---

# Comandi principali

## Compilazione

```powershell
.\tools\build.ps1
```

## Caricamento firmware

```powershell
.\tools\flash.ps1
```

## Monitor seriale

```powershell
.\tools\monitor.ps1
```

## Pulizia progetto

```powershell
.\tools\clean.ps1
```

---

# Workflow Git

- `main` → Produzione
- `develop` → Integrazione
- `feature/*` → Nuove funzionalità
- `bugfix/*` → Correzioni
- `release/*` → Preparazione rilascio
- `hotfix/*` → Correzioni urgenti

Tutti i commit devono essere firmati.

---

# Versionamento

Il progetto utilizza **Semantic Versioning (SemVer)**.

Formato:

```text
MAJOR.MINOR.PATCH
```

Esempio:

```text
1.0.0
```

---

# Documentazione

La documentazione tecnica è disponibile nella cartella `docs/`.

---

# Licenza

Consultare il file `LICENSE`.

---

# Note

Questo repository rappresenta il template ufficiale di sviluppo per tutti i progetti ESP32 derivati.
