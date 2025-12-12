# Embedded C Project Template

## Build

```bash
make              # Native build
make TARGET=arm   # ARM build
make clean        # Clean artifacts
make test         # Run unit tests
make quality      # Code quality checks
```

## Development Environment

This template includes a `.devops/` folder with scripts to run the development environment:

```bash
# Run development environment
./.devops/run_dev_env.sh
```

The script uses the Dockerfile from `.devops/Dockerfile` to build and run the development container.

## Project Structure

The template separates DevOps infrastructure from project code:

```
template/
├── .devops/             # DevOps scripts (Dockerfile, run_dev_env.sh)
├── .github/             # CI/CD workflows
├── project/             # Your project code (src/, include/, tests/, CMakeLists.txt)
├── quality/             # Code quality configs (.clang-format, .clang-tidy, .cppcheck-suppressions)
├── Makefile             # Build wrapper around CMake
└── README.md
```

The structure is preserved when creating a project. Customize `project/CMakeLists.txt` to match your project structure.

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

1. Add your custom folder structure and source files
2. Customize `project/CMakeLists.txt` for your project structure
3. Add your unit tests in `project/tests/` directory


