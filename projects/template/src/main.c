/**
 * @file main.c
 * @brief Main application entry point
 * 
 * This is a template main file for embedded C projects.
 * Modify it according to your project needs.
 */

#include "main.h"
#include <stdio.h>

// System state
static bool system_initialized = false;

/**
 * @brief Initialize the system
 */
void system_init(void)
{
    // Add your initialization code here
    system_initialized = true;
    printf("System initialized\n");
}

/**
 * @brief Process incoming data
 * @param data Data byte to process
 */
void process_data(uint8_t data)
{
    // Add your data processing logic here
    printf("Processing data: 0x%02X\n", data);
}

/**
 * @brief Check if system is ready
 * @return true if system is initialized, false otherwise
 */
bool is_system_ready(void)
{
    return system_initialized;
}

/**
 * @brief Main function - entry point of the application
 * @return Exit code (0 for success)
 */
int main(void)
{
    // Initialize system
    system_init();
    
    // Check if system is ready
    if (!is_system_ready()) {
        return 1;
    }
    
    // Example: Process some data
    process_data(0x42);
    process_data(0xFF);
    
    printf("Application running successfully\n");
    
    return 0;
}

