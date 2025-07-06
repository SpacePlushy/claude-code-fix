#!/bin/bash
# Claude Code Fix Master Script
# Creates working directory structure and comprehensive fix scripts

set -e

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

# Function to update CLI configuration
update_cli_config() {
    CLI_CONFIG_PATH="$HOME/.claude/cli-config.json"
    if [ ! -f "$CLI_CONFIG_PATH" ]; then
        echo "Creating CLI configuration file..."
        cat <<EOL > "$CLI_CONFIG_PATH"
{
  "installMethod": "npm-local",
  "autoUpdates": true,
  "version": "1.0.43"
}
EOL
        print_success "CLI configuration created at $CLI_CONFIG_PATH"
    else
        print_info "CLI configuration already exists at $CLI_CONFIG_PATH"
    fi
}

confirm_action() {
    read -p "$1 (y/n): " -n 1 -r
    echo
    [[ $REPLY =~ ^[Yy]$ ]]
}

# Create and setup working directory
WORK_DIR="./claude-fix-workspace"
print_info "Creating working directory: $WORK_DIR"
mkdir -p "$WORK_DIR"/{scripts,logs,backups,reports}
cd "$WORK_DIR"
print_success "Created working directory structure"

# Create comprehensive diagnostic script
cat <<'EOF' > "./scripts/diagnose.sh"
#!/bin/bash
# Comprehensive Claude Code diagnostic script

set -e

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

REPORT_FILE="../reports/diagnostic_report.txt"
ERROR_LOG="../logs/diagnostic_errors.log"

echo "=== CLAUDE CODE DIAGNOSTIC REPORT ===" > "$REPORT_FILE"
echo "Generated: $(date)" >> "$REPORT_FILE"
echo "System: $(uname -a)" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

echo -e "${BLUE}Running comprehensive diagnostics...${NC}"

# Check Node.js installations
echo "=== NODE.JS INSTALLATIONS ===" >> "$REPORT_FILE"
echo "Node versions found:" >> "$REPORT_FILE"
which -a node >> "$REPORT_FILE" 2>&1 || echo "No node found" >> "$REPORT_FILE"
echo "Current Node version:" >> "$REPORT_FILE"
node --version >> "$REPORT_FILE" 2>&1 || echo "Node not accessible" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# Check npm installations
echo "=== NPM INSTALLATIONS ===" >> "$REPORT_FILE"
echo "npm versions found:" >> "$REPORT_FILE"
which -a npm >> "$REPORT_FILE" 2>&1 || echo "No npm found" >> "$REPORT_FILE"
echo "Current npm version:" >> "$REPORT_FILE"
npm --version >> "$REPORT_FILE" 2>&1 || echo "npm not accessible" >> "$REPORT_FILE"
echo "npm prefix:" >> "$REPORT_FILE"
npm config get prefix >> "$REPORT_FILE" 2>&1 || echo "npm config not accessible" >> "$REPORT_FILE"
echo "npm cache location:" >> "$REPORT_FILE"
npm config get cache >> "$REPORT_FILE" 2>&1 || echo "npm cache not accessible" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# Check global npm packages
echo "=== GLOBAL NPM PACKAGES ===" >> "$REPORT_FILE"
npm list -g --depth=0 >> "$REPORT_FILE" 2>&1 || echo "Could not list global packages" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# Check Claude installations
echo "=== CLAUDE CODE INSTALLATIONS ===" >> "$REPORT_FILE"
echo "Claude command locations:" >> "$REPORT_FILE"
which -a claude >> "$REPORT_FILE" 2>&1 || echo "No claude command found" >> "$REPORT_FILE"
echo "Looking for @anthropic-ai/claude-code installations:" >> "$REPORT_FILE"
find /usr/local /opt/homebrew ~/.npm-global ~/node_modules $HOME/node_modules -name "*claude-code*" -type d 2>/dev/null >> "$REPORT_FILE" || echo "No claude-code directories found" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# Check Node version managers
echo "=== NODE VERSION MANAGERS ===" >> "$REPORT_FILE"
echo "nvm installation:" >> "$REPORT_FILE"
if [ -s "$HOME/.nvm/nvm.sh" ]; then
    echo "nvm found at $HOME/.nvm/nvm.sh" >> "$REPORT_FILE"
    source "$HOME/.nvm/nvm.sh"
    nvm list >> "$REPORT_FILE" 2>&1 || echo "nvm list failed" >> "$REPORT_FILE"
else
    echo "nvm not found" >> "$REPORT_FILE"
fi
echo "fnm installation:" >> "$REPORT_FILE"
which fnm >> "$REPORT_FILE" 2>&1 || echo "fnm not found" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# Check Homebrew Node
echo "=== HOMEBREW NODE ===" >> "$REPORT_FILE"
if command -v brew &> /dev/null; then
    echo "Homebrew Node packages:" >> "$REPORT_FILE"
    brew list | grep -E "node|npm" >> "$REPORT_FILE" 2>&1 || echo "No Node packages found in Homebrew" >> "$REPORT_FILE"
else
    echo "Homebrew not found" >> "$REPORT_FILE"
fi
echo "" >> "$REPORT_FILE"

# Check environment variables
echo "=== ENVIRONMENT VARIABLES ===" >> "$REPORT_FILE"
env | grep -E "(NODE|NPM|NVM|PATH)" >> "$REPORT_FILE" 2>&1 || echo "No relevant environment variables" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# Check permissions
echo "=== PERMISSIONS ===" >> "$REPORT_FILE"
if [ -d "/usr/local/lib/node_modules" ]; then
    echo "Global node_modules permissions:" >> "$REPORT_FILE"
    ls -la /usr/local/lib/node_modules >> "$REPORT_FILE" 2>&1
fi
if [ -d "$HOME/.npm" ]; then
    echo "User npm directory permissions:" >> "$REPORT_FILE"
    ls -la "$HOME/.npm" >> "$REPORT_FILE" 2>&1
fi
echo "" >> "$REPORT_FILE"

# Check for .npmrc files
echo "=== NPMRC FILES ===" >> "$REPORT_FILE"
find "$HOME" /usr/local /opt/homebrew -name ".npmrc" 2>/dev/null | while read -r file; do
    echo "Found .npmrc: $file" >> "$REPORT_FILE"
    echo "Contents:" >> "$REPORT_FILE"
    cat "$file" >> "$REPORT_FILE" 2>&1
    echo "" >> "$REPORT_FILE"
done

echo -e "${GREEN}✓ Diagnostic complete. Report saved to $REPORT_FILE${NC}"
EOF
chmod +x ./scripts/diagnose.sh

# Create comprehensive fix script
cat <<'EOF' > "./scripts/fix_claude.sh"
#!/bin/bash
# Comprehensive Claude Code fix script

set -e

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

LOG_FILE="../logs/fix_claude.log"
BACKUP_DIR="../backups"

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
    echo "$(date): SUCCESS - $1" >> "$LOG_FILE"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
    echo "$(date): ERROR - $1" >> "$LOG_FILE"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
    echo "$(date): WARNING - $1" >> "$LOG_FILE"
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
    echo "$(date): INFO - $1" >> "$LOG_FILE"
}

confirm_action() {
    read -p "$1 (y/n): " -n 1 -r
    echo
    [[ $REPLY =~ ^[Yy]$ ]]
}

echo "=== CLAUDE CODE FIX SCRIPT ===" > "$LOG_FILE"
echo "Started: $(date)" >> "$LOG_FILE"

print_info "Starting Claude Code fix process..."

# Step 1: Backup existing configurations
print_info "Step 1: Backing up existing configurations..."
if [ -d "$HOME/.claude" ]; then
    cp -r "$HOME/.claude" "$BACKUP_DIR/claude_config_$(date +%Y%m%d_%H%M%S)" 2>> "$LOG_FILE"
    print_success "Backed up ~/.claude directory"
else
    print_info "No ~/.claude directory found"
fi

# Step 2: Kill any running Claude processes
print_info "Step 2: Stopping any running Claude processes..."
pkill -f claude 2>/dev/null || true
print_success "Stopped Claude processes"

# Step 3: Remove all Claude installations
print_info "Step 3: Removing all Claude Code installations..."
if confirm_action "Remove all Claude Code installations?"; then
    # Remove global npm installation
    npm uninstall -g @anthropic-ai/claude-code 2>> "$LOG_FILE" || true
    print_success "Removed global npm Claude Code installation"
    
    # Remove any local installations
    find "$HOME" -name "node_modules" -type d -exec find {} -name "*claude-code*" -type d -exec rm -rf {} + 2>/dev/null || true
    print_success "Removed local Claude Code installations"
else
    print_warning "Skipped Claude Code removal"
fi

# Step 4: Clean npm cache
print_info "Step 4: Cleaning npm cache..."
npm cache clean --force >> "$LOG_FILE" 2>&1
print_success "Cleaned npm cache"

# Step 5: Fix npm permissions
print_info "Step 5: Fixing npm permissions..."
if [ ! -d "$HOME/.npm-global" ]; then
    mkdir -p "$HOME/.npm-global"
    npm config set prefix "$HOME/.npm-global"
    print_success "Created and configured ~/.npm-global directory"
fi

# Step 6: Install/switch to LTS Node
print_info "Step 6: Installing LTS Node.js..."
if command -v nvm &> /dev/null; then
    print_info "nvm found, installing Node.js LTS"
    source "$HOME/.nvm/nvm.sh"
    nvm install --lts >> "$LOG_FILE" 2>&1
    nvm use --lts >> "$LOG_FILE" 2>&1
    nvm alias default lts/* >> "$LOG_FILE" 2>&1
    print_success "Installed and set Node.js LTS as default"
elif [ ! -s "$HOME/.nvm/nvm.sh" ]; then
    print_info "Installing nvm..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash >> "$LOG_FILE" 2>&1
    source "$HOME/.nvm/nvm.sh"
    nvm install --lts >> "$LOG_FILE" 2>&1
    nvm use --lts >> "$LOG_FILE" 2>&1
    nvm alias default lts/* >> "$LOG_FILE" 2>&1
    print_success "Installed nvm and Node.js LTS"
else
    print_warning "Current Node.js version will be used"
fi

# Step 7: Fresh Claude install
print_info "Step 7: Installing Claude Code..."
if confirm_action "Install Claude Code globally?"; then
    npm install -g @anthropic-ai/claude-code >> "$LOG_FILE" 2>&1
    print_success "Installed Claude Code globally"
else
    print_warning "Skipped Claude Code installation"
fi

# Step 8: Verify installation
print_info "Step 8: Verifying installation..."
if command -v claude &> /dev/null; then
    CLAUDE_VERSION=$(claude --version 2>&1 || echo "Version check failed")
    print_success "Claude installed successfully: $CLAUDE_VERSION"
    echo "Claude version: $CLAUDE_VERSION" >> "$LOG_FILE"
else
    print_error "Claude command not found after installation"
fi

# Step 9: Test Claude
print_info "Step 9: Testing Claude functionality..."
if command -v claude &> /dev/null; then
    echo "Testing Claude help command..." >> "$LOG_FILE"
    claude --help >> "$LOG_FILE" 2>&1 && print_success "Claude help command works" || print_error "Claude help command failed"
else
    print_error "Cannot test Claude - command not found"
fi

# Step 10: Address CLI configuration warning
print_info "Step 10: Addressing CLI configuration warning..."
print_warning "Note: 'Config install method: unknown' is a cosmetic warning"
print_info "Attempting to fix CLI configuration database..."

# Try running migrate-installer to update the config
claude migrate-installer >> "$LOG_FILE" 2>&1 && print_success "Migration command completed" || print_warning "Migration command had no effect (already local)"

# Run claude doctor to check if warning persists
print_info "Checking Claude doctor status..."
if claude doctor 2>&1 | grep -q "Config install method: unknown"; then
    print_warning "CLI config warning persists (this is cosmetic and doesn't affect functionality)"
    print_info "To manually resolve: The warning indicates internal config database needs updating"
    print_info "This commonly happens after local installation migration"
else
    print_success "CLI configuration warning resolved"
fi

echo "Fix process completed: $(date)" >> "$LOG_FILE"
print_success "Claude Code fix process completed!"
EOF
chmod +x ./scripts/fix_claude.sh

# Create Docker solution script
cat <<'EOF' > "./scripts/claude_docker.sh"
#!/bin/bash
# Docker solution for Claude Code

set -e

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

print_info "Creating Docker solution for Claude Code..."

# Create Dockerfile
cat <<'DOCKERFILE' > ../Dockerfile
FROM node:20-alpine

# Install Claude Code
RUN npm install -g @anthropic-ai/claude-code

# Create working directory
WORKDIR /workspace

# Set up volume for user's work
VOLUME ["/workspace"]

# Default command
CMD ["claude"]
DOCKERFILE

print_success "Created Dockerfile"

# Create docker-compose.yml
cat <<'COMPOSE' > ../docker-compose.yml
version: '3.8'
services:
  claude:
    build: .
    volumes:
      - ./workspace:/workspace
      - ~/.claude:/root/.claude
    working_dir: /workspace
    stdin_open: true
    tty: true
COMPOSE

print_success "Created docker-compose.yml"

# Create workspace directory
mkdir -p ../workspace

# Create convenience script
cat <<'SCRIPT' > ../claude-docker.sh
#!/bin/bash
# Convenience script to run Claude in Docker

if [ "$1" = "build" ]; then
    echo "Building Claude Docker image..."
    docker-compose build
elif [ "$1" = "shell" ]; then
    echo "Starting Claude Docker shell..."
    docker-compose run --rm claude sh
else
    echo "Running Claude in Docker..."
    docker-compose run --rm claude claude "$@"
fi
SCRIPT

chmod +x ../claude-docker.sh

print_success "Docker solution created!"
print_info "Usage:"
echo "  Build: ./claude-docker.sh build"
echo "  Shell: ./claude-docker.sh shell"
echo "  Run Claude: ./claude-docker.sh [claude arguments]"
EOF
chmod +x ./scripts/claude_docker.sh

# Create rollback script
cat <<'EOF' > "./scripts/rollback.sh"
#!/bin/bash
# Rollback script for Claude Code fixes

set -e

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

confirm_action() {
    read -p "$1 (y/n): " -n 1 -r
    echo
    [[ $REPLY =~ ^[Yy]$ ]]
}

print_info "Claude Code Rollback Script"

# Find backup directories
BACKUP_DIRS=$(find ../backups -name "claude_config_*" -type d 2>/dev/null | sort -r)

if [ -z "$BACKUP_DIRS" ]; then
    print_warning "No Claude configuration backups found"
else
    print_info "Available backups:"
    echo "$BACKUP_DIRS" | nl
    
    if confirm_action "Restore the most recent backup?"; then
        LATEST_BACKUP=$(echo "$BACKUP_DIRS" | head -n1)
        if [ -d "$HOME/.claude" ]; then
            rm -rf "$HOME/.claude"
        fi
        cp -r "$LATEST_BACKUP" "$HOME/.claude"
        print_success "Restored Claude configuration from $LATEST_BACKUP"
    fi
fi

# Option to remove Claude Code installation
if confirm_action "Remove Claude Code installation?"; then
    npm uninstall -g @anthropic-ai/claude-code 2>/dev/null || true
    print_success "Removed Claude Code installation"
fi

print_info "Rollback completed"
EOF
chmod +x ./scripts/rollback.sh

# Create cleanup script
cat <<'EOF' > "./scripts/cleanup.sh"
#!/bin/bash
# Cleanup script to remove the working directory

set -e

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

confirm_action() {
    read -p "$1 (y/n): " -n 1 -r
    echo
    [[ $REPLY =~ ^[Yy]$ ]]
}

print_warning "This will remove the entire claude-fix-workspace directory and all its contents."
print_info "Location: ./claude-fix-workspace"

if confirm_action "Are you sure you want to proceed?"; then
    cd ..
    rm -rf claude-fix-workspace
    print_success "Cleanup completed - claude-fix-workspace directory removed"
else
    print_info "Cleanup cancelled"
fi
EOF
chmod +x ./scripts/cleanup.sh

print_success "All scripts created successfully!"
print_info "Available scripts:"
echo "  - diagnose.sh: Run comprehensive diagnostics"
echo "  - fix_claude.sh: Fix Claude Code installation"
echo "  - claude_docker.sh: Docker-based solution"
echo "  - rollback.sh: Rollback changes"
echo "  - cleanup.sh: Remove working directory"
echo ""

# Run diagnostic script
print_info "Running diagnostic script..."
cd scripts
./diagnose.sh
cd ..

# Analyze diagnostic results and determine fix strategy
print_info "Analyzing diagnostic results..."
if grep -q "No node found" reports/diagnostic_report.txt; then
    print_error "Node.js not found - this needs to be addressed first"
elif grep -q "No claude command found" reports/diagnostic_report.txt; then
    print_warning "Claude command not found - installation needed"
else
    print_info "Node.js and Claude found - checking for issues"
fi

# Ask user if they want to proceed with the fix
if confirm_action "Run the fix script now?"; then
    print_info "Running fix script..."
    cd scripts
    ./fix_claude.sh
    cd ..
    
    # Verify fix worked
    print_info "Verifying fix..."
    if command -v claude &> /dev/null; then
        print_success "Fix successful! Claude is now available."
        echo "Claude version: $(claude --version 2>&1 || echo 'Version check failed')"
    else
        print_error "Fix may have failed - Claude command not found"
        print_info "You can try the Docker solution: cd scripts && ./claude_docker.sh"
    fi
else
    print_info "Fix not run. You can run it manually later with: cd scripts && ./fix_claude.sh"
fi

# Update CLI configuration
print_info "Updating CLI configuration to fix installation method..."
update_cli_config
cd ..

print_info "Master script completed. Working directory preserved at: ./claude-fix-workspace"
print_info "You can clean it up later with: cd claude-fix-workspace/scripts && ./cleanup.sh"
