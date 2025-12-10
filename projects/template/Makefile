TARGET ?= native
BUILD_DIR = build
CHECK_DIRS ?= 

all:
	@mkdir -p $(BUILD_DIR)
	@cd $(BUILD_DIR) && cmake .. -DTARGET_ARM=$(if $(findstring arm,$(TARGET)),ON,OFF) -DDEBUG=$(if $(DEBUG),ON,OFF)
	@cmake --build $(BUILD_DIR)

clean:
	rm -rf $(BUILD_DIR)

test:
	@cd $(BUILD_DIR) && ctest || echo "No tests defined"

_get_source_dirs:
	@if [ -n "$(CHECK_DIRS)" ]; then \
		echo "$(CHECK_DIRS)"; \
	else \
		find . -name '*.c' -o -name '*.cpp' | grep -v build/ | grep -v .git/ | xargs dirname | sort -u | tr '\n' ' '; \
	fi

_get_source_files:
	@if [ -n "$(CHECK_DIRS)" ]; then \
		for d in $(CHECK_DIRS); do find $$d -name '*.c' -o -name '*.h' -o -name '*.cpp' -o -name '*.hpp' 2>/dev/null; done; \
	else \
		find . -name '*.c' -o -name '*.h' -o -name '*.cpp' -o -name '*.hpp' | grep -v build/ | grep -v .git/; \
	fi

_get_cpp_files:
	@if [ -n "$(CHECK_DIRS)" ]; then \
		for d in $(CHECK_DIRS); do find $$d -name '*.c' -o -name '*.cpp' 2>/dev/null; done | head -20; \
	else \
		find . -name '*.c' -o -name '*.cpp' | grep -v build/ | grep -v .git/ | head -20; \
	fi

cppcheck:
	@mkdir -p $(BUILD_DIR)
	@DIRS=$$(make -s _get_source_dirs); \
	SUPPRESSIONS=$(if $(wildcard .cppcheck-suppressions),--suppressions-list=.cppcheck-suppressions,); \
	cppcheck --enable=all --suppress=missingIncludeSystem --suppress=unusedFunction \
		--inline-suppr $$SUPPRESSIONS --xml --xml-version=2 \
		--output-file=$(BUILD_DIR)/cppcheck-report.xml $$DIRS || true

format:
	@FILES=$$(make -s _get_source_files); \
	STYLE=$(if $(wildcard .clang-format),--style=file,); \
	for f in $$FILES; do \
		clang-format $$STYLE --dry-run --Werror "$$f" >/dev/null 2>&1 || exit 1; \
	done

format-fix:
	@FILES=$$(make -s _get_source_files); \
	STYLE=$(if $(wildcard .clang-format),--style=file,); \
	for f in $$FILES; do clang-format $$STYLE -i "$$f"; done

tidy:
	@FILES=$$(make -s _get_cpp_files); \
	CONFIG=$(if $(wildcard .clang-tidy),-config-file=.clang-tidy,); \
	for f in $$FILES; do clang-tidy $$CONFIG "$$f" -- -std=c11 || true; done

quality: cppcheck tidy format

.PHONY: all clean test cppcheck format format-fix tidy quality _get_source_dirs _get_source_files _get_cpp_files
