#!/bin/bash
# Script to create a new embedded C project from template
# Usage: ./scripts/create_project.sh <project_name> [github_repo_url]

set -e  # Exit on error

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}")" && pwd )"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
TEMPLATE_DIR="$PROJECT_ROOT/templates/template"

# Check arguments
if [ $# -lt 1 ]; then
    echo -e "${RED}Error: Project name required${NC}"
    echo "Usage: $0 <project_name> [github_repo_url]"
    echo ""
    echo "Examples:"
    echo "  $0 my_project"
    echo "  $0 my_project https://github.com/username/my_project.git"
    exit 1
fi

PROJECT_NAME="$1"
GITHUB_URL="${2:-}"  # Optional GitHub URL

# Validate project name (no spaces, special chars)
if [[ ! "$PROJECT_NAME" =~ ^[a-zA-Z0-9_-]+$ ]]; then
    echo -e "${RED}Error: Project name can only contain letters, numbers, underscores, and hyphens${NC}"
    exit 1
fi

# Validate GitHub URL if provided
if [ -n "$GITHUB_URL" ] && [[ ! "$GITHUB_URL" =~ ^https://github.com/ ]]; then
    echo -e "${RED}Error: GitHub URL must start with https://github.com/${NC}"
    exit 1
fi

# Project directory is next to the DevOps station folder
OUTPUT_DIR="$(dirname "$PROJECT_ROOT")"
PROJECT_DIR="$OUTPUT_DIR/$PROJECT_NAME"

# Check if project already exists
if [ -d "$PROJECT_DIR" ]; then
    echo -e "${RED}Error: Project '$PROJECT_NAME' already exists at $PROJECT_DIR${NC}"
    exit 1
fi

# Check if template exists
if [ -d "$TEMPLATE_DIR" ]; then
    echo -e "${GREEN}Template found${NC}"
else
    echo -e "${RED}Error: Template directory not found at $TEMPLATE_DIR${NC}"
    exit 1
fi

echo -e "${BLUE}Creating new embedded C project: $PROJECT_NAME${NC}"
echo "=========================================="
echo ""
echo "Project will be created at: $PROJECT_DIR"
if [ -n "$GITHUB_URL" ]; then
    echo "GitHub repository: $GITHUB_URL"
fi
echo ""

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Copy template to new project directory
echo -e "${BLUE}Copying template...${NC}"
cp -r "$TEMPLATE_DIR" "$PROJECT_DIR"

# Remove any git files that might have been copied
find "$PROJECT_DIR" -name ".git" -type d -exec rm -rf {} + 2>/dev/null || true
find "$PROJECT_DIR" -name ".git" -type f -delete 2>/dev/null || true

# Update project name in CMakeLists.txt
if [ -f "$PROJECT_DIR/project/CMakeLists.txt" ]; then
    echo -e "${BLUE}Updating project name in CMakeLists.txt...${NC}"
    sed -i "s/project(embedded_project C)/project($PROJECT_NAME C)/g" "$PROJECT_DIR/project/CMakeLists.txt"
fi

# Initialize Git repository
echo -e "${BLUE}Initializing Git repository...${NC}"
cd "$PROJECT_DIR"
git init
git add .
git commit -m "Initial commit: $PROJECT_NAME"

# Add GitHub remote if provided
if [ -n "$GITHUB_URL" ]; then
    echo -e "${BLUE}Adding GitHub remote...${NC}"
    git remote add origin "$GITHUB_URL"
fi

echo ""
echo -e "${GREEN}✓ Project created successfully!${NC}"
echo ""
echo "Project location: $PROJECT_DIR"
echo ""
echo "Next steps:"
echo "  1. cd $PROJECT_DIR"
if [ -n "$GITHUB_URL" ]; then
    echo "  2. Push to GitHub:"
    echo "     git push -u origin main"
    echo "  3. Start developing!"
else
    echo "  2. Add GitHub remote (optional):"
    echo "     git remote add origin <your_github_url>"
    echo "     git push -u origin main"
    echo "  3. Start developing!"
fi
echo ""
echo "To run development environment:"
echo "  ./.devops/run_dev_env.sh"
echo ""
