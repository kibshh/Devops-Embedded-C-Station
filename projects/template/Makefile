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

# Debug build support
ifdef DEBUG
    CFLAGS += -g -O0 -DDEBUG
else
    CFLAGS += -DNDEBUG
endif

# Target-specific settings
ifeq ($(TARGET),arm)
    # ARM cross-compiler settings
    CC = arm-none-eabi-gcc
    CFLAGS += -mcpu=cortex-m4 -mthumb -mfloat-abi=hard -mfpu=fpv4-sp-d16
    ifndef DEBUG
        CFLAGS += -Os -ffunction-sections -fdata-sections
        LDFLAGS = -Wl,--gc-sections -T linker_script.ld
    else
        CFLAGS += -O0
        LDFLAGS = -T linker_script.ld
    endif
    OUTPUT = $(BUILD_DIR)/$(PROJECT_NAME).elf
else
    # Native build (for testing on host)
    CC = gcc
    ifndef DEBUG
        CFLAGS += -O2
    else
        CFLAGS += -g -O0
    endif
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

# Code quality targets
.PHONY: check format format-fix tidy cppcheck quality

# Run all code quality checks
quality: cppcheck tidy format
	@echo "✅ All code quality checks completed"

# Run cppcheck static analysis
# Uses .cppcheck-suppressions file if present
cppcheck:
	@echo "Running cppcheck..."
	@mkdir -p $(BUILD_DIR)
	@SUPPRESSIONS=""; \
	if [ -f .cppcheck-suppressions ]; then \
		SUPPRESSIONS="--suppressions-list=.cppcheck-suppressions"; \
	fi; \
	cppcheck --enable=all \
		--suppress=missingIncludeSystem \
		--suppress=unusedFunction \
		--suppress=unmatchedSuppression \
		--inline-suppr \
		$$SUPPRESSIONS \
		--xml --xml-version=2 --output-file=$(BUILD_DIR)/cppcheck-report.xml \
		-I$(INC_DIR) \
		$(SRC_DIR)/ $(INC_DIR)/ 2>&1 || true; \
	cppcheck --enable=all \
		--suppress=missingIncludeSystem \
		--suppress=unusedFunction \
		--suppress=unmatchedSuppression \
		--inline-suppr \
		$$SUPPRESSIONS \
		-I$(INC_DIR) \
		$(SRC_DIR)/ $(INC_DIR)/ || true

# Check code formatting
format:
	@echo "Checking code formatting..."
	@FORMAT_ERRORS=0; \
	CLANG_FORMAT_CONFIG=""; \
	if [ -f .clang-format ]; then \
		CLANG_FORMAT_CONFIG="--style=file"; \
	fi; \
	for file in $$(find $(SRC_DIR) $(INC_DIR) -name '*.c' -o -name '*.h' -o -name '*.cpp' -o -name '*.hpp' 2>/dev/null); do \
		if [ -f "$$file" ]; then \
			if ! clang-format $$CLANG_FORMAT_CONFIG --dry-run --Werror "$$file" > /dev/null 2>&1; then \
				echo "❌ Formatting issue in: $$file"; \
				FORMAT_ERRORS=1; \
			fi; \
		fi; \
	done; \
	if [ $$FORMAT_ERRORS -eq 0 ]; then \
		echo "✅ All files are properly formatted"; \
	else \
		echo "❌ Some files need formatting. Run: make format-fix"; \
		exit 1; \
	fi

# Fix code formatting automatically
format-fix:
	@echo "Fixing code formatting..."
	@CLANG_FORMAT_CONFIG=""; \
	if [ -f .clang-format ]; then \
		CLANG_FORMAT_CONFIG="--style=file"; \
	fi; \
	find $(SRC_DIR) $(INC_DIR) -name '*.c' -o -name '*.h' -o -name '*.cpp' -o -name '*.hpp' | \
	while read file; do \
		if [ -f "$$file" ]; then \
			clang-format $$CLANG_FORMAT_CONFIG -i "$$file"; \
			echo "Formatted: $$file"; \
		fi; \
	done
	@echo "✅ Formatting complete"

# Run clang-tidy static analysis
tidy:
	@echo "Running clang-tidy..."
	@if command -v clang-tidy > /dev/null 2>&1; then \
		CLANG_TIDY_CONFIG=""; \
		if [ -f .clang-tidy ]; then \
			CLANG_TIDY_CONFIG="-config-file=.clang-tidy"; \
		fi; \
		find $(SRC_DIR) -name '*.c' -o -name '*.cpp' | head -20 | while read file; do \
			clang-tidy $$CLANG_TIDY_CONFIG "$$file" -- -I$(INC_DIR) -std=c11 $(CFLAGS) 2>&1 || true; \
		done; \
	else \
		echo "⚠️  clang-tidy not found, skipping..."; \
	fi

.PHONY: all clean info check format format-fix tidy cppcheck quality

