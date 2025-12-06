# Git and GitHub Setup Commands

Follow these commands to initialize a git repository and create a GitHub repository for this DevOps station.

## Step 1: Initialize Git Repository

```bash
cd /home/sasic/Devops/Devops_Embedded_C

# Initialize git repository
git init

# Add all files (respecting .gitignore)
git add .

# Make initial commit
git commit -m "Initial commit: DevOps Embedded C Station"
```

## Step 2: Create GitHub Repository

### Option A: Using GitHub CLI (gh) - Recommended

```bash
# Create repository on GitHub (make sure you're logged in: gh auth login)
gh repo create Devops_Embedded_C --public --source=. --remote=origin --push

# Or for private repository:
# gh repo create Devops_Embedded_C --private --source=. --remote=origin --push
```

### Option B: Manual GitHub Setup

1. Go to https://github.com/new
2. Repository name: `Devops_Embedded_C` (or your preferred name)
3. Choose Public or Private
4. **DO NOT** initialize with README, .gitignore, or license (we already have these)
5. Click "Create repository"

Then run:

```bash
# Add GitHub remote (replace USERNAME with your GitHub username)
git remote add origin https://github.com/USERNAME/Devops_Embedded_C.git

# Rename branch to main (if needed)
git branch -M main

# Push to GitHub
git push -u origin main
```

## Step 3: Verify Setup

```bash
# Check remote configuration
git remote -v

# Check status
git status

# View commit history
git log --oneline
```

## Quick One-Liner (if using GitHub CLI)

```bash
cd /home/sasic/Devops/Devops_Embedded_C && \
git init && \
git add . && \
git commit -m "Initial commit: DevOps Embedded C Station" && \
gh repo create Devops_Embedded_C --public --source=. --remote=origin --push
```

## Notes

- Make sure you have GitHub CLI installed: `sudo apt install gh` (Ubuntu/Debian)
- Or authenticate via browser: `gh auth login`
- The `.gitignore` file will automatically exclude build artifacts and individual project repos
- Each project in `projects/` should have its own separate git repository

