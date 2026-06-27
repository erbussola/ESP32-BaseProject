# Architecture Decision Records (ADR)

**Progetto:** ESP32-BaseProject
**Framework:** EmbeddedFramework
**Versione:** 2.0.0
**Stato:** APPROVATO
**Lingua:** Italiano

---

# Introduzione

Questo documento raccoglie tutte le decisioni architetturali approvate per il progetto.

Ogni ADR rappresenta una decisione definitiva.

Una volta approvata, una decisione non viene modificata durante la stessa major release (2.x).

Eventuali cambiamenti verranno introdotti esclusivamente nella release successiva.

---

# ADR-0001

## Nome del repository

### Stato

APPROVATO

### Decisione

Il repository principale manterrà il nome:

```
ESP32-BaseProject
```

### Motivazione

È il repository che verrà clonato per iniziare nuovi progetti.

Non rappresenta il framework ma il progetto completo.

---

# ADR-0002

## Nome del Framework

### Stato

APPROVATO

### Decisione

Il framework interno prende il nome di

```
EmbeddedFramework
```

### Motivazione

Il nome è indipendente dall'hardware.

Permette di riutilizzare il framework su:

* ESP32
* ESP32-S3
* ESP32-C3
* STM32
* RP2040
* RP2350

senza modificare l'architettura.

---

# ADR-0003

## Lingua ufficiale

### Stato

APPROVATO

### Decisione

La documentazione ufficiale del progetto è scritta in italiano.

Restano in inglese:

* codice sorgente
* namespace
* classi
* metodi
* variabili
* API
* convenzioni Git

### Motivazione

La documentazione deve essere immediatamente comprensibile durante le attività di manutenzione.

---

# ADR-0004

## IDE ufficiale

### Stato

APPROVATO

### Decisione

L'ambiente di sviluppo ufficiale è

```
Visual Studio Code
```

con

```
PlatformIO
```

### Motivazione

* multipiattaforma
* gratuito
* ottima integrazione con ESP32
* ampia disponibilità di estensioni

---

# ADR-0005

## Framework Embedded

### Stato

APPROVATO

### Decisione

Il framework utilizzato è

```
Arduino Framework
```

eseguito tramite PlatformIO.

### Motivazione

Garantisce semplicità, ampia documentazione e compatibilità con la maggior parte delle librerie ESP32.

---

# ADR-0006

## Standard C++

### Stato

APPROVATO

### Decisione

Il progetto utilizza

```
C++17
```

### Motivazione

Offre un buon equilibrio tra modernità e compatibilità con il toolchain ESP32.

---

# ADR-0007

## Sistema di Build

### Stato

APPROVATO

### Decisione

Il sistema di build ufficiale è

```
PlatformIO
```

### Motivazione

Centralizza compilazione, upload, librerie e monitor seriale.

---

# ADR-0008

## Controllo versione

### Stato

APPROVATO

### Decisione

Repository principale:

```
GitLab
```

Mirror:

```
GitHub
```

### Motivazione

GitLab sarà la sorgente ufficiale del progetto.

GitHub verrà mantenuto sincronizzato.

---

# ADR-0009

## Architettura a livelli

### Stato

APPROVATO

### Decisione

L'architettura è composta dai seguenti layer:

```
Application

↓

Services

↓

EmbeddedFramework

↓

HAL

↓

Board

↓

Hardware
```

Ogni layer può utilizzare esclusivamente quello immediatamente sottostante.

Sono vietate dipendenze trasversali.

### Motivazione

Ridurre l'accoppiamento tra i moduli.

---

# ADR-0010

## Astrazione Hardware

### Stato

APPROVATO

### Decisione

Il firmware non accederà mai direttamente ai pin hardware.

Ogni accesso avverrà esclusivamente tramite HAL.

### Motivazione

Portabilità.

Testabilità.

Manutenibilità.

---

# ADR-0011

## Board Support

### Stato

APPROVATO

### Decisione

Il supporto alle schede verrà separato dal framework.

Ogni nuova scheda sarà aggiunta senza modificare EmbeddedFramework.

### Motivazione

Permette di supportare nuove board senza modificare il framework.

---

# ADR-0012

## Gestione della configurazione

### Stato

APPROVATO

### Decisione

La configurazione non sarà concentrata in un unico file.

Verrà suddivisa per responsabilità.

Esempio:

```
Configuration/

    Application

    Logging

    Network

    OTA

    Diagnostics

    Build
```

### Motivazione

Maggiore manutenibilità.

---

# ADR-0013

## Versionamento

### Stato

APPROVATO

### Decisione

Il file

```
VERSION
```

costituisce l'unica sorgente della versione del progetto.

Ogni altra informazione verrà generata automaticamente.

### Motivazione

Evitare duplicazioni.

---

# ADR-0014

## Logging

### Stato

APPROVATO

### Decisione

Il logging sarà gestito da un componente dedicato.

Non verranno utilizzate chiamate dirette a

```
Serial.print()
```

all'interno del codice applicativo.

### Motivazione

Centralizzare la gestione dei log.

---

# ADR-0015

## Script PowerShell

### Stato

APPROVATO

### Decisione

Tutti gli script utilizzeranno un modulo comune condiviso.

Le funzioni duplicate sono vietate.

### Motivazione

Ridurre la manutenzione.

---

# ADR-0016

## Automazione

### Stato

APPROVATO

### Decisione

Qualsiasi operazione ripetitiva dovrà poter essere eseguita tramite PowerShell.

### Motivazione

Riproducibilità.

Riduzione degli errori.

---

# ADR-0017

## Documentazione

### Stato

APPROVATO

### Decisione

Ogni componente del framework dovrà essere documentato.

La documentazione è considerata parte integrante del codice.

### Motivazione

Facilitare manutenzione e onboarding.

---

# ADR-0018

## Git Workflow

### Stato

APPROVATO

### Decisione

Il progetto utilizza GitLab Flow.

Branch principali:

```
main
develop
feature/*
bugfix/*
release/*
hotfix/*
```

### Motivazione

Workflow semplice e consolidato.

---

# ADR-0019

## Convenzione Commit

### Stato

APPROVATO

### Decisione

Il progetto utilizza Conventional Commits.

Esempi:

```
feat:
fix:
docs:
refactor:
test:
build:
ci:
```

### Motivazione

Maggiore leggibilità della cronologia Git.

---

# ADR-0020

## Filosofia del Framework

### Stato

APPROVATO

### Decisione

Il framework deve poter essere mantenuto e compreso anche dopo molti anni.

Ogni scelta progettuale privilegia:

* semplicità
* modularità
* leggibilità
* automazione
* documentazione

rispetto alla sola velocità di sviluppo.

### Motivazione

Creare una base stabile e duratura per tutti i futuri progetti embedded.
