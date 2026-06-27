/******************************************************************************
 * ESP32-BaseProject
 *
 * File        : config.h
 * Versione    : 1.0.0
 *
 * Descrizione:
 * Configurazione generale del firmware.
 *
 * Tutte le impostazioni modificabili dall'applicazione devono essere
 * centralizzate in questo file.
 ******************************************************************************/

#pragma once

/******************************************************************************
 * Informazioni applicazione
 ******************************************************************************/

#define APP_NAME            "ESP32-BaseProject"
#define APP_VERSION         "1.0.0"
#define APP_AUTHOR          "Fabrizio Biscossi"

/******************************************************************************
 * Modalità di compilazione
 ******************************************************************************/

#if defined(ENV_DEV)
    #define BUILD_ENVIRONMENT "Development"
#elif defined(ENV_TEST)
    #define BUILD_ENVIRONMENT "Test"
#elif defined(ENV_RELEASE)
    #define BUILD_ENVIRONMENT "Release"
#else
    #define BUILD_ENVIRONMENT "Unknown"
#endif

/******************************************************************************
 * Debug
 ******************************************************************************/

#ifndef DEBUG_ENABLED
#define DEBUG_ENABLED       1
#endif

/******************************************************************************
 * Seriale
 ******************************************************************************/

constexpr uint32_t SERIAL_BAUDRATE = 115200;

/******************************************************************************
 * LED di stato
 ******************************************************************************/

constexpr bool STATUS_LED_ENABLED = true;
constexpr uint32_t STATUS_LED_BLINK_MS = 1000;

/******************************************************************************
 * Wi-Fi
 ******************************************************************************/

constexpr bool WIFI_AUTO_CONNECT = true;
constexpr uint32_t WIFI_CONNECT_TIMEOUT_MS = 15000;

/******************************************************************************
 * Logging
 ******************************************************************************/

enum class LogLevel : uint8_t
{
    Error = 0,
    Warning,
    Info,
    Debug
};

constexpr LogLevel DEFAULT_LOG_LEVEL = LogLevel::Info;

/******************************************************************************
 * Watchdog
 ******************************************************************************/

constexpr bool WATCHDOG_ENABLED = true;

/******************************************************************************
 * OTA
 ******************************************************************************/

constexpr bool OTA_ENABLED = true;

/******************************************************************************
 * Time
 ******************************************************************************/

constexpr char DEFAULT_TIMEZONE[] = "CET-1CEST,M3.5.0,M10.5.0/3";

/******************************************************************************
 * Fine file
 ******************************************************************************/
