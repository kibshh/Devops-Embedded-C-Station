#!/bin/bash
# Script to run the embedded C development environment container
# Uses the Dockerfile from .devops/ folder

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
DOCKERFILE="$SCRIPT_DIR/Dockerfile"

# Docker image name
IMAGE_NAME="embedded-c-devops:latest"

echo -e "${BLUE}Embedded C DevOps Environment${NC}"
echo "================================"
echo ""

# Check if Dockerfile exists
if [ ! -f "$DOCKERFILE" ]; then
    echo -e "${RED}Error: Dockerfile not found at $DOCKERFILE${NC}"
    exit 1
fi

# Build image if needed
# Use .devops/ as build context since Dockerfile only installs dependencies
if ! docker image inspect "$IMAGE_NAME" > /dev/null 2>&1; then
    echo -e "${BLUE}Building Docker image...${NC}"
    docker build -t "$IMAGE_NAME" -f "$DOCKERFILE" "$SCRIPT_DIR"
    echo -e "${GREEN}Build complete!${NC}"
    echo ""
fi

echo -e "${BLUE}Starting container...${NC}"
echo "Your workspace is mounted at /workspace"
echo "Type 'exit' to leave the container"
echo ""

# Run the container
docker run -it --rm \
    -v "$PROJECT_DIR:/workspace" \
    -w /workspace \
    "$IMAGE_NAME"
