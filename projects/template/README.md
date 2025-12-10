# Embedded C Project Template

[![CI](https://github.com/USERNAME/REPO_NAME/actions/workflows/ci.yml/badge.svg)](https://github.com/USERNAME/REPO_NAME/actions)

## Build

```bash
make              # Native build
make TARGET=arm   # ARM build
make clean        # Clean artifacts
make quality      # Code quality checks
```

## Project Structure

Customize `CMakeLists.txt` to match your project structure. The template provides a basic example - modify it as needed.

### Code Quality Checks

Code quality tools (`make quality`) check all source files by default. To limit checks to specific directories:

```bash
make quality CHECK_DIRS="dir1 dir2 dir3"
```

## Setup

1. Update `.github/workflows/ci.yml` with your DevOps repo URL
2. Update badge URLs in README.md
3. Customize `CMakeLists.txt` for your project structure
