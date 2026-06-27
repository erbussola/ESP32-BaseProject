/******************************************************************************
 * ESP32-BaseProject
 *
 * File        : pins.h
 * Versione    : 1.0.0
 *
 * Descrizione:
 * Definizione centralizzata dei pin hardware utilizzati dal progetto.
 *
 * Tutti i pin devono essere definiti in questo file. Evitare l'utilizzo di
 * valori numerici ("magic numbers") direttamente nel codice sorgente.
 ******************************************************************************/

#pragma once

#include <Arduino.h>

/******************************************************************************
 * LED integrato
 *
 * Nota:
 * Sulla maggior parte delle schede ESP32 Dev Module il LED integrato è
 * collegato al GPIO 2. Se la scheda utilizzata impiega un GPIO differente,
 * modificare esclusivamente questa definizione.
 ******************************************************************************/

constexpr gpio_num_t PIN_STATUS_LED = GPIO_NUM_2;

/******************************************************************************
 * UART
 ******************************************************************************/

constexpr uint32_t UART_BAUDRATE = 115200;

/******************************************************************************
 * I²C
 ******************************************************************************/

constexpr gpio_num_t PIN_I2C_SDA = GPIO_NUM_21;
constexpr gpio_num_t PIN_I2C_SCL = GPIO_NUM_22;

/******************************************************************************
 * SPI
 ******************************************************************************/

constexpr gpio_num_t PIN_SPI_MOSI = GPIO_NUM_23;
constexpr gpio_num_t PIN_SPI_MISO = GPIO_NUM_19;
constexpr gpio_num_t PIN_SPI_SCK  = GPIO_NUM_18;
constexpr gpio_num_t PIN_SPI_CS   = GPIO_NUM_5;

/******************************************************************************
 * ADC
 ******************************************************************************/

constexpr gpio_num_t PIN_ADC_1 = GPIO_NUM_34;
constexpr gpio_num_t PIN_ADC_2 = GPIO_NUM_35;

/******************************************************************************
 * DAC
 ******************************************************************************/

constexpr gpio_num_t PIN_DAC_1 = GPIO_NUM_25;
constexpr gpio_num_t PIN_DAC_2 = GPIO_NUM_26;

/******************************************************************************
 * PWM
 ******************************************************************************/

constexpr gpio_num_t PIN_PWM_1 = GPIO_NUM_27;
constexpr gpio_num_t PIN_PWM_2 = GPIO_NUM_14;

/******************************************************************************
 * Pulsanti
 ******************************************************************************/

constexpr gpio_num_t PIN_BUTTON_BOOT = GPIO_NUM_0;
constexpr gpio_num_t PIN_BUTTON_USER = GPIO_NUM_4;

/******************************************************************************
 * Espansione futura
 *
 * Definire qui eventuali pin aggiuntivi utilizzati da display, sensori,
 * relè, moduli di comunicazione o periferiche custom.
 ******************************************************************************/

/******************************************************************************
 * Fine file
 ******************************************************************************/
