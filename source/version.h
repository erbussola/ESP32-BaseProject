/******************************************************************************
 * ESP32-BaseProject
 *
 * File        : version.h
 * Versione    : 1.0.0
 *
 * Descrizione:
 * Definizione centralizzata delle informazioni di versione del firmware.
 *
 * Questo file contiene le informazioni statiche del progetto e costituisce
 * il punto di accesso unificato alla versione dell'applicazione.
 *
 * Le informazioni dinamiche di compilazione (commit Git, data build, branch,
 * ecc.) saranno fornite dal file build_info.h generato automaticamente durante
 * la build.
 ******************************************************************************/

#pragma once

#include <Arduino.h>

/******************************************************************************
 * Informazioni progetto
 ******************************************************************************/

namespace Version
{
    inline constexpr char ProjectName[]    = "ESP32-BaseProject";
    inline constexpr char ProjectVersion[] = "1.0.0";
    inline constexpr char Author[]         = "Fabrizio Biscossi";
    inline constexpr char Company[]        = "";
    inline constexpr char Copyright[]      = "Copyright (C) 2026";

    constexpr uint16_t Major = 1;
    constexpr uint16_t Minor = 0;
    constexpr uint16_t Patch = 0;

    inline constexpr char VersionString[] = "1.0.0";
}

/******************************************************************************
 * Informazioni Firmware
 ******************************************************************************/

namespace Firmware
{
    inline constexpr char Board[]     = "ESP32 Dev Module";
    inline constexpr char MCU[]       = "ESP32-WROOM-32";
    inline constexpr char Framework[] = "Arduino";
    inline constexpr char Platform[]  = "PlatformIO";
}

/******************************************************************************
 * Funzioni di utilità
 ******************************************************************************/

namespace Version
{
    inline String GetVersion()
    {
        return String(VersionString);
    }

    inline String GetFullName()
    {
        return String(ProjectName) + " v" + VersionString;
    }
}

/******************************************************************************
 * Fine file
 ******************************************************************************/
