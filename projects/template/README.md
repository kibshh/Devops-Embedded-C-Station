# Embedded C Project Template

[![CI](https://github.com/USERNAME/REPO_NAME/actions/workflows/ci.yml/badge.svg)](https://github.com/USERNAME/REPO_NAME/actions/workflows/ci.yml)
[![Build Status](https://github.com/USERNAME/REPO_NAME/workflows/CI/badge.svg)](https://github.com/USERNAME/REPO_NAME/actions)

This is a template project structure for embedded C development.

## Project Structure

```
template/
├── src/           # Source files (.c files)
├── include/       # Header files (.h files)
├── build/         # Build output directory (generated, gitignored)
├── tests/         # Test files
├── Makefile       # Build configuration
└── README.md      # This file
```

## Building the Project

### Native Build (for testing on host)
```bash
make
```

### ARM Build (for ARM microcontrollers)
```bash
make TARGET=arm
```

### Clean build artifacts
```bash
make clean
```

### Code Quality Checks

Run all code quality checks:
```bash
make quality
```

Individual checks:
```bash
make cppcheck    # Static analysis with cppcheck
make tidy        # Static analysis with clang-tidy
make format      # Check code formatting
make format-fix  # Auto-fix formatting issues
```

## Usage

1. Copy this template to create a new project
2. Add your source files to `src/`
3. Add your headers to `include/`
4. Modify `Makefile` as needed for your target platform
5. Configure GitHub Actions workflow (`.github/workflows/ci.yml`) - update the DevOps repo URL

## Code Quality

This project includes code quality tools configured:

- **cppcheck**: Static analysis for C/C++
- **clang-tidy**: Advanced static analysis
- **clang-format**: Code formatting (see `.clang-format`)

Configuration files:
- `.clang-format` - Code formatting rules
- `.clang-tidy` - Static analysis rules
- `.cppcheckrc` - Cppcheck configuration
- `.cppcheck-suppressions` - Suppressions for false positives

## GitHub Actions

This template includes a CI workflow that builds your project and runs code quality checks. Before using it:

1. Update `.github/workflows/ci.yml`:
   - Change `repository: yourusername/Devops_Embedded_C` to your actual DevOps repo
   - If your DevOps repo is private, add a GitHub token secret

2. Update README.md badges:
   - Replace `USERNAME/REPO_NAME` in the badge URLs with your GitHub username and repository name

3. Configure notifications (optional):
   - **Email**: Set secrets `SMTP_SERVER`, `SMTP_PORT`, `SMTP_USERNAME`, `SMTP_PASSWORD`, `SMTP_FROM`, `NOTIFICATION_EMAIL`
   - **Slack**: Set secret `SLACK_WEBHOOK_URL`

4. Alternative: Publish the Docker image to Docker Hub/GHCR and update the workflow to use it directly

