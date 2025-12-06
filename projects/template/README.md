# Embedded C Project Template

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

## Usage

1. Copy this template to create a new project
2. Add your source files to `src/`
3. Add your headers to `include/`
4. Modify `Makefile` as needed for your target platform
5. Configure GitHub Actions workflow (`.github/workflows/ci.yml`) - update the DevOps repo URL

## GitHub Actions

This template includes a CI workflow that builds your project. Before using it:

1. Update `.github/workflows/ci.yml`:
   - Change `repository: yourusername/Devops_Embedded_C` to your actual DevOps repo
   - If your DevOps repo is private, add a GitHub token secret

2. Alternative: Publish the Docker image to Docker Hub/GHCR and update the workflow to use it directly

