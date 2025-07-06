# Claude Code Fix Tool

A comprehensive solution to fix Claude Code installation issues on macOS, specifically targeting React error #327 and related Node.js/npm conflicts.

## 🚀 Quick Start

Run the master script to automatically diagnose and fix your Claude Code installation:

```bash
./fix_claude_master.sh
```

## 📖 Overview

This tool addresses common Claude Code installation issues including:

- **React Error #327**: Minified React error during migration
- **Node.js Version Conflicts**: Non-LTS versions causing compatibility issues
- **npm Permission Issues**: Global installation permission conflicts
- **Multiple Installation Conflicts**: Homebrew, nvm, system Node conflicts
- **Corrupted Cache**: npm cache corruption causing installation failures

## 🛠 What's Included

### Core Scripts

- **`fix_claude_master.sh`** - Main orchestration script that runs everything
- **`scripts/diagnose.sh`** - Comprehensive system diagnostics
- **`scripts/fix_claude.sh`** - Complete fix implementation
- **`scripts/claude_docker.sh`** - Docker-based alternative solution
- **`scripts/rollback.sh`** - Safety rollback for changes
- **`scripts/cleanup.sh`** - Clean up working directories

### Features

- 🔍 **Comprehensive Diagnostics**: Checks Node.js, npm, nvm, Homebrew, permissions
- 🔧 **Automated Fixes**: Handles permission issues, version conflicts, cache problems
- 🐳 **Docker Alternative**: Containerized solution if native fix fails
- 📦 **Safe Backups**: Backs up configurations before making changes
- 🔄 **Rollback Support**: Can undo changes if needed
- 🧹 **Clean Workspace**: Self-contained working directory

## 🎯 Problem Solved

### Original Error
```
claude /migrate-installer
✢  Removing global npm installation

file:///Users/spaceplushy/node_modules/@anthropic-ai/claude-code/cli.js:65
Error: Minified React error #327; visit https://reactjs.org/docs/error-decoder.html?invariant=327
    at PW (file:///Users/spaceplushy/node_modules/@anthropic-ai/claude-code/cli.js:67:34915)
Node.js v22.16.0
```

### Root Causes Identified
- Node.js v22.16.0 (non-LTS) compatibility issues
- Partial installation state from failed migration
- npm permission conflicts
- Corrupted npm cache
- Multiple Node.js version managers interfering

## 📋 System Requirements

- **OS**: macOS
- **Shell**: zsh (or bash)
- **Permissions**: User account access (no sudo required for most operations)

## 🔧 How It Works

### Diagnostic Phase
1. Scans for all Node.js installations (system, Homebrew, nvm, fnm)
2. Checks npm configurations and permissions
3. Locates all Claude Code installations
4. Identifies version conflicts and permission issues
5. Generates detailed diagnostic report

### Fix Phase
1. **Backup**: Saves existing Claude configurations
2. **Cleanup**: Removes corrupted installations and cleans cache
3. **Permissions**: Sets up proper npm global directory
4. **Node.js**: Installs/switches to LTS version via nvm
5. **Reinstall**: Fresh Claude Code installation
6. **Verify**: Tests installation and functionality

## 📁 Directory Structure

When running, creates a self-contained workspace:

```
claude-fix/
├── scripts/          # All fix scripts
├── logs/            # Execution logs
├── backups/         # Configuration backups
└── reports/         # Diagnostic reports
```

## 🚨 Safety Features

- **Non-destructive**: Backs up all configurations before changes
- **Confirmation prompts**: Asks before destructive operations
- **Detailed logging**: Records all actions for troubleshooting
- **Rollback capability**: Can undo changes if needed
- **Self-contained**: All operations within working directory

## 📊 Success Criteria

The fix is successful when:
- ✅ `claude --version` returns version without errors
- ✅ `which claude` shows a single, accessible path
- ✅ No React errors occur during operation
- ✅ Claude commands work normally

## 🐳 Docker Alternative

If the native fix fails, use the Docker solution:

```bash
cd scripts
./claude_docker.sh build
./claude_docker.sh shell
```

## 🔄 Rollback

If you need to undo changes:

```bash
cd scripts
./rollback.sh
```

## 🧹 Cleanup

Remove the working directory when done:

```bash
cd scripts
./cleanup.sh
```

## 📝 Logs and Reports

All operations are logged to:
- `logs/fix_claude.log` - Fix script execution log
- `logs/diagnostic_errors.log` - Diagnostic error details
- `reports/diagnostic_report.txt` - Complete system analysis

## 🤝 Contributing

This tool was created to solve a specific Claude Code installation issue but can be extended for other Node.js/npm related problems.

## 📜 License

MIT License - feel free to use and modify as needed.

## 🆘 Troubleshooting

### If the fix script fails:
1. Check the logs in `logs/fix_claude.log`
2. Review the diagnostic report in `reports/diagnostic_report.txt`
3. Try the Docker solution as an alternative
4. Use the rollback script to undo changes

### Common issues:
- **Permission denied**: Ensure you have write access to your home directory
- **nvm not found**: The script will install nvm automatically
- **Docker not available**: Install Docker Desktop for the containerized solution
- **"Config install method: unknown" warning**: This is a cosmetic warning that occurs when Claude is running locally but the config database hasn't been updated. It doesn't affect functionality. To resolve: run `claude migrate-installer` or ignore the warning.

---

**Status**: ✅ Successfully tested and verified on macOS with Node.js v22.16.0
