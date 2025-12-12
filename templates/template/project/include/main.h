/**
 * @file main.h
 * @brief Main header file for embedded project
 */

#ifndef MAIN_H
#define MAIN_H

#include <stdint.h>
#include <stdbool.h>

// Function declarations
void system_init(void);
void process_data(uint8_t data);
bool is_system_ready(void);

#endif // MAIN_H

