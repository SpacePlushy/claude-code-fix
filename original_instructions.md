# Original Problem Instructions

This document contains the original instructions that led to the creation of this Claude Code fix tool.

## The Original Error

I was experiencing a React error #327 when trying to migrate Claude Code from global to local installation on macOS:

```
claude /migrate-installer
[After selecting "Yes, proceed" to trust the folder]

✢  Removing global npm installation

file:///Users/spaceplushy/node_modules/@anthropic-ai/claude-code/cli.js:65
Error: Minified React error #327; visit https://reactjs.org/docs/error-decoder.html?invariant=327
    at PW (file:///Users/spaceplushy/node_modules/@anthropic-ai/claude-code/cli.js:67:34915)
    [stack trace truncated]
Node.js v22.16.0
```

## System Information at Time of Error

- **OS**: macOS (Mac mini)
- **Node.js version**: v22.16.0 (not LTS - this was identified as part of the issue)
- **User**: spaceplushy
- **Shell**: zsh
- **Current directory**: /Users/spaceplushy

## What Was Requested

I needed a complete solution that would:

1. **Create comprehensive diagnostic and fix scripts** that I could run directly
2. **Work entirely within a controlled directory** (`/Users/spaceplushy/Desktop/claude-fix/`)
3. **Provide complete, working bash scripts** with all necessary code, error handling, and logic
4. **Handle all edge cases** and provide clear feedback
5. **Be production-ready** with proper error handling, not just examples

## Specific Issues to Address

### 1. Node Version Issue
- I was on v22.16.0 (non-LTS)
- The script needed to detect if nvm was installed, install it if not
- Install Node.js v20 LTS or v22 LTS and set as default

### 2. Permission Conflicts
- npm prefix ownership issues
- Global node_modules permissions
- User vs system installations

### 3. Multiple Installation Conflicts
- Homebrew Node installations
- System Node installations  
- nvm/fnm installations
- Any Claude Code in ~/.claude, node_modules, or global

### 4. React Error #327
This indicated component lifecycle issues, likely from:
- Partial installation state
- Corrupted cache
- Version mismatches

## Required Scripts

### 0. Setup Script (`setup_fix_environment.sh`)
Creates the directory structure and sets up the working environment.

### 1. Diagnostic Script (`diagnose.sh`)
Comprehensive system analysis including:
- All Node/npm installations (system, nvm, homebrew, fnm)
- Global npm packages (especially @anthropic-ai/claude-code)
- npm directory permissions
- All Claude Code installations system-wide
- Conflicting environment variables
- Multiple package managers
- npm cache location and state
- .npmrc files that might cause issues

### 2. Fix Script (`fix_claude.sh`)
Complete fix implementation:
- Works entirely within the working directory
- Backs up existing Claude configurations
- Logs all actions
- Completely removes all Claude Code installations
- Cleans npm cache
- Fixes npm permission issues
- Installs correct Node.js LTS version
- Reinstalls Claude Code properly
- Tests the installation

### 3. Docker Solution (`claude_docker.sh`)
Alternative containerized solution with:
- Dockerfile for Claude Code
- Container build process
- Volume mounts for work directory
- Easy-use alias

### 4. Rollback Script (`rollback.sh`)
Safety net in case something goes wrong.

## Success Criteria

The solution was successful when:
- ✅ `claude --version` returns version without errors
- ✅ `which claude` shows a single, accessible path
- ✅ No React errors occur
- ✅ Migration tool works OR Claude works without migration

## The Solution That Worked

The master script created a comprehensive solution that:

1. **Diagnosed the system** and identified all conflicts
2. **Backed up existing configurations** safely
3. **Cleaned corrupted installations** completely
4. **Fixed npm permissions** with proper global directory setup
5. **Maintained Node.js version** (since current version worked after cleanup)
6. **Reinstalled Claude Code** with fresh, clean installation
7. **Verified functionality** with comprehensive testing
8. **Cleaned up automatically** when done

## Final Result

✅ **Success!** Claude Code now works properly:
- Version: 1.0.43 (Claude Code)
- No React errors
- All functionality verified
- Clean installation state

This tool can now help others experiencing similar Claude Code installation issues.
