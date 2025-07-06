# Create a complete solution to fix my Claude Code installation error

**IMPORTANT**: Please provide complete, working bash scripts that I can copy, save, and run immediately. Do not provide examples or guidance - create the actual scripts with all necessary code, error handling, and logic.

**CRITICAL**: The master script must:
1. First create the directory `/Users/spaceplushy/Desktop/claude-fix/`
2. Perform ALL operations within that directory
3. Generate all other scripts inside that directory
4. Keep all logs, backups, and outputs organized in subdirectories
5. Never write files outside of this working directory

## Context
I'm experiencing a React error #327 when trying to migrate Claude Code from global to local installation on macOS. I need you to create complete diagnostic and fix scripts that I can run directly.

## System Information
- **OS**: macOS (Mac mini)
- **Node.js version**: v22.16.0 (not LTS - this might be the issue)
- **User**: spaceplushy
- **Shell**: zsh
- **Current directory**: /Users/spaceplushy
- **Working directory**: Create all scripts to work in `/Users/spaceplushy/Desktop/claude-fix/`

## Error Details
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

## I need you to create:

### 0. First, a setup script (`setup_fix_environment.sh`) that:
- Creates the directory `/Users/spaceplushy/Desktop/claude-fix/`
- Changes to that directory
- Creates subdirectories for logs, backups, and scripts
- Sets up the working environment
- Downloads or creates all other scripts in this directory

### 1. A comprehensive diagnostic script (`diagnose.sh`) that:
- Checks all Node/npm installations (system, nvm, homebrew, fnm)
- Lists all global npm packages (especially @anthropic-ai/claude-code)
- Verifies npm directory permissions
- Finds all Claude Code installations system-wide
- Checks for conflicting environment variables
- Detects if I have multiple package managers installed
- Checks npm cache location and state
- Looks for .npmrc files that might cause issues
- Saves all output to `diagnostic_report.txt`

### 2. A complete fix script (`fix_claude.sh`) that:
- **Works entirely within** `/Users/spaceplushy/Desktop/claude-fix/`
- Backs up any existing Claude configurations to `./backups/`
- Logs all actions to `./logs/fix_claude.log`
- Completely removes all Claude Code installations (global and local)
- Cleans npm cache
- Checks and fixes npm permission issues
- Installs the correct Node.js LTS version (v20 or v22 LTS)
- Reinstalls Claude Code properly
- Tests the installation
- Provides clear success/failure messages

### 3. An alternative Docker solution (`claude_docker.sh`) that:
- Creates a Dockerfile for Claude Code
- Builds the container
- Sets up volume mounts for my work directory
- Creates an alias for easy use

### 4. A rollback script (`rollback.sh`) in case something goes wrong

## Specific Issues to Address:

1. **Node Version Issue**: I'm on v22.16.0 (non-LTS). The script should:
   - Detect if nvm is installed, if not, install it
   - Install Node.js v20 LTS or v22 LTS
   - Set it as default

2. **Permission Conflicts**: The script should handle:
   - npm prefix ownership issues
   - Global node_modules permissions
   - User vs system installations

3. **Multiple Installation Conflicts**: Check and clean:
   - Homebrew Node installations
   - System Node installations  
   - nvm/fnm installations
   - Any Claude Code in ~/.claude, node_modules, or global

4. **React Error #327**: This indicates component lifecycle issues, likely from:
   - Partial installation state
   - Corrupted cache
   - Version mismatches

## Script Requirements:

- All scripts should be executable (`chmod +x`)
- Include safety checks (confirm before destructive actions)
- Show progress with colored output
- Log everything to files within `./logs/`
- Handle errors gracefully
- Work on macOS with zsh
- Include comments explaining each step
- **All paths must be relative to** `/Users/spaceplushy/Desktop/claude-fix/`
- **Master script can be run from anywhere** but creates and works in the Desktop folder

## Expected Output Format:

Please provide:
1. Complete bash scripts I can copy and save
2. Instructions on which order to run them
3. What to look for in the diagnostic output
4. Troubleshooting steps if the fix script fails

## Additional Considerations:

- The error shows it's already looking in local node_modules, not global
- The migration tool itself might be broken
- I might need to bypass migration entirely
- Consider that I might have Rosetta/ARM compatibility issues on Mac mini
- The React error occurs during the uninstall phase, suggesting cleanup issues
- Current Node v22.16.0 is not LTS - need v20.x or v22.11+ LTS

## Complete Script Specifications:

### `diagnose.sh` should include:
```bash
# Check sections for:
- which -a node/npm/claude
- node version vs LTS versions
- npm config get prefix/cache
- find all @anthropic-ai installations
- ls -la permissions on npm directories  
- brew list | grep node
- nvm list (if exists)
- env | grep -E "(NODE|NPM)"
- Process any existing error logs
```

### `fix_claude.sh` should include:
```bash
# Steps:
1. Backup ~/.claude if exists
2. Kill any running Claude processes
3. Uninstall all Claude installations
4. Clean npm cache --force
5. Fix npm permissions (create ~/.npm-global if needed)
6. Install/switch to LTS Node
7. Fresh Claude install
8. Verify installation
9. Run test command
```

### Include these helper functions in scripts:
- Color output (red for errors, green for success, yellow for warnings)
- Confirmation prompts for destructive actions
- Progress indicators
- Error handling with descriptive messages
- Automatic log file creation with timestamps

Please create all scripts as complete, ready-to-run solutions that handle all edge cases and provide clear feedback. Each script should be production-ready with proper error handling, not just examples.

## Decision Logic to Include:

The fix script should automatically choose the best solution based on diagnostic results:

1. **If permission issues found** → Set up user-local npm prefix
2. **If multiple Node versions found** → Use nvm and set LTS as default  
3. **If Homebrew Node found** → Remove it and use nvm instead
4. **If corrupt installation found** → Complete cleanup and reinstall
5. **If all standard fixes fail** → Offer Docker solution

## Success Criteria:

The solution is successful when:
- `claude --version` returns version without errors
- `which claude` shows a single, accessible path
- No React errors occur
- Migration tool works OR Claude works without migration

## Testing Commands to Include:

After fix, automatically run:
```bash
claude --version
claude --help  
echo "test" | claude
```

Please make these scripts comprehensive enough that I can run them without any additional setup or knowledge.

## Final Deliverable:

Create a master script (`fix_claude_master.sh`) that:
1. Creates `/Users/spaceplushy/Desktop/claude-fix/` directory structure
2. Sets up the working environment with proper folder organization:
   ```
   /Users/spaceplushy/Desktop/claude-fix/
   ├── scripts/      # All fix scripts
   ├── logs/         # All log files
   ├── backups/      # Backup of existing configs
   └── reports/      # Diagnostic reports
   ```
3. Creates all other scripts within the `scripts/` subdirectory
4. Runs the diagnostic script from within the working directory
5. Analyzes the results
6. Automatically chooses and runs the appropriate fix
7. Verifies the fix worked
8. Provides next steps if it didn't
9. Offers to clean up the working directory when done

This master script should be the only thing I need to run to solve my problem completely. It should start with:

```bash
#!/bin/bash
# Create and setup working directory
WORK_DIR="/Users/spaceplushy/Desktop/claude-fix"
mkdir -p "$WORK_DIR"/{scripts,logs,backups,reports}
cd "$WORK_DIR"
echo "Created working directory: $WORK_DIR"
```

## Important Requirements:

- **All scripts must work within** `/Users/spaceplushy/Desktop/claude-fix/`
- **All file paths should be relative** to this working directory
- **All logs, reports, and backups** stay within this folder structure
- **The folder should be self-contained** for easy cleanup afterward
- **Include a cleanup option** to remove the entire folder when fixed