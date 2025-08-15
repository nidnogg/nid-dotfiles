# CLAUDE.md

Guidance for Claude Code when working with my dotfiles repo.

## Repository Overview

Personal dotfiles for setting up dev envs across platforms (Debian, Ubuntu, macOS, Windows PowerShell). Contains shell configs, terminal themes, and setup scripts.

## Repository Structure

- **Platform-specific bash configs:**
  - `bashrc_debian.sh` - Debian bash config with conda/nvm/rbenv setup
  - `bashrc_ubuntu2004.sh` - Ubuntu 20.04 bash config with work aliases
  
- **Cross-platform configs:**
  - `starship.toml` - Starship prompt config (disables nodejs/gcloud modules)
  - `mac/.config/starship.toml` - macOS starship config
  - `profile.ps1` - Windows PowerShell profile

- **System utilities:**
  - `fedora_cedilla_fixer.sh` - Fix C-cedilla input on Fedora
  - `mac/.config/claude-npx.sh` - NPX wrapper for macOS with specific Node version

- **Terminal themes:**
  - `mac/iterm/` - iTerm2 color schemes and configs
  - `mac/terminal_app/` - macOS Terminal.app themes

## Key Config Details

### Environment Variables
Both bashrc files define shortcut vars for common dirs:
- `$C`, `$D`, `$G` - Windows drive mount points (WSL context)
- `$DBOX` - Dropbox dir
- Platform-specific work dirs

### Dev Tool Setup
- **Node.js**: Managed via NVM in both Debian and Ubuntu configs
- **Python**: Conda envs configured (tcc2 env auto-activated on Debian)
- **Ruby**: rbenv setup in Ubuntu config
- **Rust**: Cargo bin dir added to PATH

### Aliases and Functions
- `lsd` alias for enhanced `ls` command
- `psudo()` function for running sudo with current PATH (Debian)
- SSH aliases for AWS EC2 instances (Ubuntu - work env)

## Platform Usage

### Debian/WSL Setup
Debian config designed for WSL envs with conda, includes zeitfetch for system info display, and auto-activates 'tcc2' conda env.

### Ubuntu Setup  
Ubuntu config includes work-specific SSH aliases and screenfetch for system display.

### macOS Setup
macOS config includes custom NPX wrapper that uses specific Node.js version (v22.14.0) and simplified starship config.

## Starship Config
Starship prompt configured to disable nodejs and gcloud modules for cleaner output. Includes setup instructions for WSL symlink creation.