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
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
TEMPLATE_DIR="$PROJECT_ROOT/projects/template"
PROJECTS_DIR="$PROJECT_ROOT/projects"

# Check arguments
if [ $# -lt 1 ]; then
    echo -e "${RED}Error: Project name required${NC}"
    echo "Usage: $0 <project_name> [github_repo_url]"
    echo "Example: $0 my_embedded_project https://github.com/user/my_embedded_project.git"
    exit 1
fi

PROJECT_NAME="$1"
GITHUB_URL="${2:-}"  # Optional GitHub URL
PROJECT_DIR="$PROJECTS_DIR/$PROJECT_NAME"

# Validate project name (no spaces, special chars)
if [[ ! "$PROJECT_NAME" =~ ^[a-zA-Z0-9_-]+$ ]]; then
    echo -e "${RED}Error: Project name can only contain letters, numbers, underscores, and hyphens${NC}"
    exit 1
fi

# Check if project already exists
if [ -d "$PROJECT_DIR" ]; then
    echo -e "${RED}Error: Project '$PROJECT_NAME' already exists${NC}"
    exit 1
fi

# Check if template exists
if [ ! -d "$TEMPLATE_DIR" ]; then
    echo -e "${RED}Error: Template directory not found at $TEMPLATE_DIR${NC}"
    exit 1
fi

echo -e "${BLUE}Creating new embedded C project: $PROJECT_NAME${NC}"
echo "=========================================="

# Copy template to new project directory
echo -e "${BLUE}Copying template...${NC}"
cp -r "$TEMPLATE_DIR" "$PROJECT_DIR"

# Remove template-specific files
rm -f "$PROJECT_DIR/.git" 2>/dev/null || true
rm -rf "$PROJECT_DIR/.git" 2>/dev/null || true

# Update project name in Makefile
if [ -f "$PROJECT_DIR/Makefile" ]; then
    echo -e "${BLUE}Updating project name in Makefile...${NC}"
    # Replace embedded_project with actual project name
    sed -i "s/PROJECT_NAME = embedded_project/PROJECT_NAME = $PROJECT_NAME/g" "$PROJECT_DIR/Makefile"
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
    echo -e "${YELLOW}Note: Run 'git push -u origin main' to push to GitHub${NC}"
fi

echo ""
echo -e "${GREEN}✓ Project created successfully!${NC}"
echo ""
echo "Project location: $PROJECT_DIR"
echo ""
echo "Next steps:"
echo "  1. cd projects/$PROJECT_NAME"
if [ -n "$GITHUB_URL" ]; then
    echo "  2. git push -u origin main"
else
    echo "  2. Create a GitHub repository and add it:"
    echo "     git remote add origin <your_github_url>"
    echo "     git push -u origin main"
fi
echo "  3. Start developing!"
echo ""

