# Embedded C Project Template

[![CI](https://github.com/USERNAME/REPO_NAME/actions/workflows/ci.yml/badge.svg)](https://github.com/USERNAME/REPO_NAME/actions)

## Build

```bash
make              # Native build
make TARGET=arm   # ARM build
make clean        # Clean artifacts
make test         # Run unit tests
make quality      # Code quality checks
```

## Project Structure

Customize `CMakeLists.txt` to match your project structure. The template provides a basic example - modify it as needed.

### Code Quality Checks

Code quality tools (`make quality`) check all source files by default. To limit checks to specific directories:

```bash
make quality CHECK_DIRS="dir1 dir2 dir3"
```

## Testing

Unit tests can be placed anywhere in your project. By default, CMake looks for test files in `tests/` directory recursively. Customize test locations in `CMakeLists.txt`:

```cmake
# Example: specify custom test directories
file(GLOB_RECURSE TEST_SOURCES "my_tests/*.c" "unit_tests/*.c")
```

Tests work for both native and ARM targets. The template includes a simple example test framework - replace it with your preferred testing framework (Unity, Google Test, Check, etc.).

## Setup

1. Update `.github/workflows/ci.yml` with your DevOps repo URL
2. Update badge URLs in README.md
3. Customize `CMakeLists.txt` for your project structure
4. Add your unit tests in `tests/` directory
