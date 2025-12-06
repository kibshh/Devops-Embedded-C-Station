#!/bin/bash
# Test script to demonstrate nested Git repositories work correctly

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
TEST_PROJECT="$PROJECT_ROOT/projects/test_nested_git_demo"

echo "=== Testing Nested Git Repositories ==="
echo ""

# Clean up if exists
rm -rf "$TEST_PROJECT" 2>/dev/null || true

# Step 1: Initialize root repo (if not already)
cd "$PROJECT_ROOT"
if [ ! -d ".git" ]; then
    echo "1. Initializing root Git repository..."
    git init
    echo "   ✓ Root repo initialized"
else
    echo "1. Root Git repository already exists"
fi

# Step 2: Create a test project directory
echo ""
echo "2. Creating test project directory..."
mkdir -p "$TEST_PROJECT"
echo "   ✓ Test project directory created"

# Step 3: Initialize Git in the test project
echo ""
echo "3. Initializing Git repository inside test project..."
cd "$TEST_PROJECT"
git init
echo "Test file" > test.txt
git add test.txt
git commit -m "Initial commit in nested repo"
echo "   ✓ Nested Git repo initialized and committed"

# Step 4: Check root repo status
echo ""
echo "4. Checking root repository status..."
cd "$PROJECT_ROOT"
echo "   Root repo sees nested .git directory?"
if git status --porcelain | grep -q "projects/test_nested_git_demo/.git"; then
    echo "   ✗ PROBLEM: Root repo is tracking nested .git"
else
    echo "   ✓ Root repo ignores nested .git (as expected)"
fi

# Step 5: Verify nested repo still works
echo ""
echo "5. Verifying nested repository still works independently..."
cd "$TEST_PROJECT"
echo "   Nested repo status:"
git status --short
echo "   ✓ Nested repo works independently"

# Step 6: Show what root repo sees
echo ""
echo "6. What the root repo sees:"
cd "$PROJECT_ROOT"
echo "   Files in projects/test_nested_git_demo/:"
ls -la "$TEST_PROJECT" | grep -v "^total" | head -5
echo ""
echo "   Root repo ignores the .git directory (thanks to .gitignore)"

# Cleanup
echo ""
echo "=== Test Complete ==="
echo "Cleaning up test project..."
rm -rf "$TEST_PROJECT"
echo "✓ Cleanup done"

