# Makefile for Embedded C Project
# This Makefile supports multiple targets: native (host) and ARM embedded

# Default target (native build for testing)
TARGET ?= native

# Project name
PROJECT_NAME = embedded_project

# Directories
SRC_DIR = src
INC_DIR = include
BUILD_DIR = build
TESTS_DIR = tests

# Source files
SOURCES = $(wildcard $(SRC_DIR)/*.c)
OBJECTS = $(SOURCES:$(SRC_DIR)/%.c=$(BUILD_DIR)/%.o)

# Compiler flags
CFLAGS = -Wall -Wextra -std=c11
INCLUDES = -I$(INC_DIR)

# Target-specific settings
ifeq ($(TARGET),arm)
    # ARM cross-compiler settings
    CC = arm-none-eabi-gcc
    CFLAGS += -mcpu=cortex-m4 -mthumb -mfloat-abi=hard -mfpu=fpv4-sp-d16
    CFLAGS += -Os -ffunction-sections -fdata-sections
    LDFLAGS = -Wl,--gc-sections -T linker_script.ld
    OUTPUT = $(BUILD_DIR)/$(PROJECT_NAME).elf
else
    # Native build (for testing on host)
    CC = gcc
    CFLAGS += -g -O0
    OUTPUT = $(BUILD_DIR)/$(PROJECT_NAME)
endif

# Default target
all: $(OUTPUT)
	@echo "Build complete: $(OUTPUT)"

# Link object files into executable
$(OUTPUT): $(OBJECTS) | $(BUILD_DIR)
	$(CC) $(OBJECTS) -o $@ $(LDFLAGS)
	@echo "Linking complete"

# Compile source files to object files
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c | $(BUILD_DIR)
	$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@
	@echo "Compiled: $<"

# Create build directory
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# Clean build artifacts
clean:
	rm -rf $(BUILD_DIR)
	@echo "Clean complete"

# Show build information
info:
	@echo "Project: $(PROJECT_NAME)"
	@echo "Target: $(TARGET)"
	@echo "Compiler: $(CC)"
	@echo "Sources: $(SOURCES)"
	@echo "Objects: $(OBJECTS)"
	@echo "Output: $(OUTPUT)"

.PHONY: all clean info

