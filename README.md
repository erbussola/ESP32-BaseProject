# ESP32-BaseProject

> Professional baseline template for ESP32 projects based on PlatformIO, Visual Studio Code and Git.

## Overview

ESP32-BaseProject is the reference repository used to bootstrap every new ESP32 firmware project.

The goal is to provide:

- A consistent project structure
- Reproducible development environment
- Professional Git workflow
- PlatformIO configuration
- VS Code configuration
- Reusable PowerShell automation
- Documentation-first approach
- Long-term maintainability

---

## Supported Hardware

- ESP32-WROOM-32
- ESP32 Dev Module (`esp32dev`)
- ESP32-S3 *(planned)*
- ESP32-C3 *(planned)*

---

## Development Environment

| Component | Recommended Version |
|-----------|--------------------:|
| Windows | 11 x64 |
| Visual Studio Code | Latest |
| PlatformIO | Latest 6.x |
| Git | 2.54+ |
| PowerShell | 7.x (compatible with Windows PowerShell 5.1) |

---

## Repository Structure

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

## Getting Started

1. Clone the repository.
2. Open it with Visual Studio Code.
3. Install the recommended extensions.
4. Connect the ESP32 board.
5. Build the firmware.
6. Upload the firmware.
7. Open the serial monitor.

---

## Build

```powershell
.\tools\build.ps1
```

## Upload

```powershell
.\tools\flash.ps1
```

## Serial Monitor

```powershell
.\tools\monitor.ps1
```

## Clean

```powershell
.\tools\clean.ps1
```

---

## Git Workflow

- `main` → production-ready code
- `develop` → integration branch
- `feature/*` → new features
- `bugfix/*` → fixes
- `release/*` → release preparation
- `hotfix/*` → production fixes

All commits should be signed.

---

## Documentation

Project documentation is stored in the `docs/` directory.

---

## Versioning

Semantic Versioning (SemVer):

```
MAJOR.MINOR.PATCH
```

Example:

```
1.0.0
```

---

## License

See the `LICENSE` file.

---

## Status

This repository is the official baseline template for all future ESP32 projects.
