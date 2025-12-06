#!/bin/bash
# Helper script to run the embedded C development environment container
# This makes it easy to start the container with proper volume mounting

set -e  # Exit on error

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Docker image name
IMAGE_NAME="embedded-c-devops:latest"

echo -e "${BLUE}Embedded C DevOps Environment${NC}"
echo "================================"

# Check if Docker image exists
if ! docker image inspect "$IMAGE_NAME" > /dev/null 2>&1; then
    echo -e "${BLUE}Image not found. Building it now...${NC}"
    docker build -t "$IMAGE_NAME" -f "$PROJECT_ROOT/docker/Dockerfile" "$PROJECT_ROOT"
    echo -e "${GREEN}Build complete!${NC}"
fi

echo -e "${BLUE}Starting container...${NC}"
echo "Your workspace is mounted at /workspace"
echo "Type 'exit' to leave the container"
echo ""

# Run the container with:
# -it: Interactive terminal
# --rm: Remove container when it exits
# -v: Mount current directory to /workspace in container
# --name: Give it a name (optional, helps with cleanup)
docker run -it --rm \
    -v "$PROJECT_ROOT:/workspace" \
    -w /workspace \
    "$IMAGE_NAME"

