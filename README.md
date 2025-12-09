# Embedded C DevOps Station

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Docker](https://img.shields.io/badge/docker-available-blue.svg)](https://hub.docker.com/)

A complete DevOps environment for embedded C projects, providing development, building, testing, deployment, and CI/CD capabilities.

## Overview

This project provides an isolated, reproducible development environment for embedded C programming. It includes:

- **Cross-compilation toolchains** (ARM, AVR, etc.)
- **Build systems** (Make, CMake)
- **Testing frameworks**
- **CI/CD integration**
- **Code quality tools**

## Quick Start

### Prerequisites
- Docker installed on your system

### Running the Development Environment

```bash
./scripts/run_dev_env.sh
```

The script will automatically build the Docker image if needed and start the container.

## Project Structure

```
.
├── docker/              # Docker-related files
│   └── Dockerfile      # Main development environment
├── projects/            # Your embedded C projects go here
├── scripts/            # Utility scripts
└── README.md           # This file
```

## Creating a New Project

Each project gets its own Git repository and GitHub Actions workflow.

### Quick Start

```bash
# Create a new project from template
./scripts/create_project.sh my_project_name

# Or with GitHub URL
./scripts/create_project.sh my_project_name https://github.com/username/my_project_name.git
```

This script will:
1. Copy the template to `projects/my_project_name/`
2. Initialize a Git repository in the project directory
3. Make an initial commit
4. Optionally set up GitHub remote

### Manual Setup

If you prefer to set up manually:

```bash
# 1. Copy template
cp -r projects/template projects/my_project_name
cd projects/my_project_name

# 2. Initialize Git
git init
git add .
git commit -m "Initial commit"

# 3. Create GitHub repo and push
git remote add origin https://github.com/username/my_project_name.git
git branch -M main
git push -u origin main
```

## Git Repository Structure

- **Root repository** (optional): This DevOps infrastructure can be version controlled separately
- **Individual projects**: Each project in `projects/` has its own Git repository
- **Template**: The `projects/template/` directory is NOT a Git repo (it's just a template)

### Why Separate Repos?

- Each project can have its own GitHub repository
- Independent version control and release cycles
- Separate GitHub Actions workflows per project
- Easier collaboration on individual projects
- Cleaner CI/CD pipelines

## GitHub Actions

Each project includes a GitHub Actions workflow template (`.github/workflows/ci.yml`) that:
- Builds the project natively (for testing)
- Builds for ARM target (for embedded deployment)
- Uploads build artifacts
- Automatically cleans up old artifacts (90+ days)
- Sends failure notifications (email/Slack) when configured

### Features

- **Artifact Retention**: Native artifacts kept for 7 days, ARM artifacts for 30 days
- **Automatic Cleanup**: Old artifacts (>90 days) are automatically deleted
- **Failure Notifications**: 
  - PR comments on workflow failures
  - Email notifications (when SMTP configured)
  - Slack notifications (when webhook configured)

The workflow automatically uses the Docker container for consistent builds.

## Next Steps

1. Run `./scripts/run_dev_env.sh` to start the development environment
2. Create your first embedded project using `./scripts/create_project.sh`
3. Push your project to GitHub
4. GitHub Actions will automatically build on push/PR

