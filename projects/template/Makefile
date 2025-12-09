TARGET ?= native
PROJECT_NAME = embedded_project
SRC_DIR = src
INC_DIR = include
BUILD_DIR = build

SOURCES = $(wildcard $(SRC_DIR)/*.c)
OBJECTS = $(SOURCES:$(SRC_DIR)/%.c=$(BUILD_DIR)/%.o)
CFLAGS = -Wall -Wextra -std=c11 -I$(INC_DIR)

ifdef DEBUG
    CFLAGS += -g -O0 -DDEBUG
else
    CFLAGS += -DNDEBUG
endif

ifeq ($(TARGET),arm)
    CC = arm-none-eabi-gcc
    CFLAGS += -mcpu=cortex-m4 -mthumb -mfloat-abi=hard -mfpu=fpv4-sp-d16
    CFLAGS += $(if $(DEBUG),-O0,-Os -ffunction-sections -fdata-sections)
    LDFLAGS = -Wl,--gc-sections -T linker_script.ld
    OUTPUT = $(BUILD_DIR)/$(PROJECT_NAME).elf
else
    CC = gcc
    CFLAGS += $(if $(DEBUG),-g -O0,-O2)
    OUTPUT = $(BUILD_DIR)/$(PROJECT_NAME)
endif

all: $(OUTPUT)

$(OUTPUT): $(OBJECTS) | $(BUILD_DIR)
	$(CC) $(OBJECTS) -o $@ $(LDFLAGS)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c | $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

clean:
	rm -rf $(BUILD_DIR)

test:
	@echo "No test target defined"

cppcheck:
	@mkdir -p $(BUILD_DIR)
	@SUPPRESSIONS=$(if $(wildcard .cppcheck-suppressions),--suppressions-list=.cppcheck-suppressions,)
	@cppcheck --enable=all --suppress=missingIncludeSystem --suppress=unusedFunction \
		--inline-suppr $$SUPPRESSIONS --xml --xml-version=2 \
		--output-file=$(BUILD_DIR)/cppcheck-report.xml -I$(INC_DIR) $(SRC_DIR)/ $(INC_DIR)/ || true

format:
	@STYLE=$(if $(wildcard .clang-format),--style=file,)
	@find $(SRC_DIR) $(INC_DIR) -name '*.c' -o -name '*.h' -o -name '*.cpp' -o -name '*.hpp' 2>/dev/null | \
	while read f; do clang-format $$STYLE --dry-run --Werror "$$f" >/dev/null 2>&1 || exit 1; done

format-fix:
	@STYLE=$(if $(wildcard .clang-format),--style=file,)
	@find $(SRC_DIR) $(INC_DIR) -name '*.c' -o -name '*.h' -o -name '*.cpp' -o -name '*.hpp' | \
	while read f; do clang-format $$STYLE -i "$$f"; done

tidy:
	@CONFIG=$(if $(wildcard .clang-tidy),-config-file=.clang-tidy,)
	@find $(SRC_DIR) -name '*.c' -o -name '*.cpp' | head -20 | \
	while read f; do clang-tidy $$CONFIG "$$f" -- -I$(INC_DIR) -std=c11 $(CFLAGS) || true; done

quality: cppcheck tidy format

.PHONY: all clean test cppcheck format format-fix tidy quality

