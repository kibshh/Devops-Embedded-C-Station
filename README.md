# Embedded C DevOps Station

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Docker](https://img.shields.io/badge/docker-available-blue.svg)](https://hub.docker.com/)

A complete DevOps environment for embedded C projects, providing development, building, testing, deployment, and CI/CD capabilities.

## Overview

This project provides an isolated, reproducible development environment for embedded C programming. It includes:

- **Cross-compilation toolchains** (ARM, AVR, etc.)
- **CMake build system**
- **CI/CD integration**
- **Code quality tools**

## Quick Start

### Prerequisites
- Docker installed on your system

### Running the Development Environment

Projects created from the template include their own `.devops/run_dev_env.sh` script:

```bash
cd your_project
./.devops/run_dev_env.sh
```

The script uses the Dockerfile from `.devops/Dockerfile` to build and run the development container.

## Project Structure

```
.
├── templates/           # Project templates (not user projects)
│   └── template/       # Template for creating new projects
│       └── .devops/    # Contains Dockerfile and run_dev_env.sh
├── scripts/            # Utility scripts
│   └── create_project.sh  # Script to create new projects
└── README.md           # This file
```

## Creating a New Project

The template is used to create new projects. Projects are automatically created next to the DevOps station directory.

### Quick Start

```bash
# Create a new project
./scripts/create_project.sh my_project_name

# Or with GitHub URL
./scripts/create_project.sh my_project_name https://github.com/username/my_project.git
```

**Important:** Projects are created next to the DevOps station directory (one level up). If the station is at `/path/to/Devops_Embedded_C`, the project will be at `/path/to/my_project_name`.

This script will:
1. Copy the template to `../<project_name>/` (next to DevOps station folder)
2. Update project name in CMakeLists.txt
3. Initialize Git repository
4. Make initial commit
5. Add GitHub remote (if URL provided)

**Note:** GitHub URL is optional. You can add it later with `git remote add origin <url>`.

## Repository Structure

- **This repository**: Contains templates and infrastructure for embedded C development
- **Templates**: The `templates/template/` directory is a template for creating new projects
- **User projects**: Created next to the DevOps station directory (one level up)

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

1. Create your first embedded project using `./scripts/create_project.sh my_project`
2. Navigate to your project: `cd my_project`
3. Run `./.devops/run_dev_env.sh` to start the development environment
4. Push your project to GitHub
5. GitHub Actions will automatically build on push/PR using the project's own Dockerfile

