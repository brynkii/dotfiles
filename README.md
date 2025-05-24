# My Personal Dotfiles

This repository contains my personal collection of dotfiles for a customized Linux environment. These configurations are tailored to my workflow and preferences, focusing on efficiency and a keyboard-driven experience. (Note: These are primarily *Linux* dotfiles, as many of the tools and configurations are Linux-specific.)

## Core System & Shell Configuration

This section covers the fundamental shell and system-level configurations. All paths are relative to the repository root (e.g., `.zshrc` would typically be symlinked to `~/.zshrc`).

*   **Shells:**
    *   `.zshrc`: Configuration for Zsh, my primary shell.
    *   `.bashrc`: Configuration for Bash.
*   **Prompt:**
    *   `.config/starship.toml`: Configuration for Starship, a cross-shell prompt.
*   **Input/Terminal:**
    *   `.inputrc`: Readline configuration for customizing keybindings in shells and other CLI tools.
    *   `.dircolors`: Configuration for `LS_COLORS`, defining colors for `ls` output.

## Graphical Environment

Configurations for the graphical user interface components.

*   **Window Manager:**
    *   `.config/awesome/`: Configuration for AwesomeWM.
        *   `rc.lua`: Main configuration file.
        *   `theme.lua`: Theme settings.
*   **Compositor:**
    *   `.config/picom/picom.conf`: Configuration for Picom, a lightweight compositor.
*   **Hotkey Daemon:**
    *   `.config/sxhkd/sxhkdrc`: Configuration for SXHKD, an X hotkey daemon.
*   **Notification System:**
    *   `.config/dunst/dunstrc`: Configuration for Dunst, a customizable notification daemon.
*   **Application Launcher:**
    *   `.config/rofi/`: Configuration for Rofi, a versatile application launcher and window switcher.

## Terminal Emulators

Configuration for various terminal emulators.

*   `.config/kitty/kitty.conf`: Configuration for Kitty, a fast, feature-rich GPU-based terminal emulator.
*   `.config/ghostty/config`: Configuration for Ghostty, a modern GPU-accelerated terminal emulator.

## Text Editors & IDEs

Configurations for my preferred text editors and Integrated Development Environments.

*   **Neovim:**
    *   The comprehensive Lua-based Neovim configuration is located within this repository at `.config/nvim/`.
        *   `init.lua`: Main entry point for the Neovim configuration.
        *   Subdirectories for plugins, language server protocol (LSP) settings, and other customizations.
*   **Vim (Legacy):**
    *   `.vim/`: Directory for Vim plugins and settings.
    *   `.vimrc`: Main configuration file for Vim.

## File Management & Utilities

Tools for managing files and other common tasks.

*   **File Manager:**
    *   `.config/lf/`: Configuration for lf (list files), a terminal file manager.
*   **Terminal Multiplexer:**
    *   `.tmux.conf`: Configuration for Tmux, a terminal multiplexer.
*   **Task Management:**
    *   `.taskrc`: Configuration for Taskwarrior, a command-line task manager.
*   **Git Configuration:**
    *   `.gitconfig`: Global Git configuration settings.

## Applications & Media

Configurations for various applications and media consumption.

*   **Music:**
    *   `.config/mpd/`: Configuration for Music Player Daemon (MPD).
    *   `.config/ncmpcpp/`: Configuration for NCMPCPP, an MPD client.
*   **Video:**
    *   `.config/mpv/mpv.conf`: Configuration for mpv, a versatile media player.
*   **News & RSS:**
    *   `.config/newsboat/`: Configuration for Newsboat, an RSS/Atom feed reader.
        *   `config`: Main configuration file.
        *   `urls`: File containing the list of subscribed feeds.
*   **Web (Text):**
    *   `.config/lynx/`: Configuration for Lynx, a text-based web browser.
*   **Documents:**
    *   `.config/zathura/zathurarc`: Configuration for Zathura, a highly customizable document viewer.
*   **YouTube (CLI):**
    *   `.config/ytfzf/`: Configuration for ytfzf, a script to search and play YouTube videos from the terminal.

## Custom Scripts (`.local/bin/`)

This directory (intended to be symlinked to `~/.local/bin/`) contains numerous custom helper scripts to automate tasks and enhance my command-line experience. Examples include:

*   `fkill`: Interactively kill processes.
*   `screenshot`: Capture screenshots (full screen, window, or selection).
*   `wifi-menu`: A dmenu/rofi based script for managing Wi-Fi connections.
*   `vol`: Control system volume.
*   `rofi-books`: A Rofi script for managing and opening e-books.

Associated data for some of these scripts (e.g., an emoji list for an emoji picker script) might be stored in a corresponding `.local/share/` directory (intended to be symlinked to `~/.local/share/`).

## Installation Scripts (`.local/install/`)

This directory (intended to be symlinked to `~/.local/install/`) holds scripts designed to automate the installation of various tools, applications, and dependencies used in this configuration. Examples include:

*   `install-chrome`: Script to download and install Google Chrome.
*   `install-docker`: Script to set up Docker.
*   `install-go`: Script to install the Go programming language.

### Setup / Installation
[User: You may want to add instructions here on how to clone this repository and symlink the configuration files, or if you use a dotfile manager like GNU Stow or a custom bootstrap script.]

### Prerequisites
[User: List any essential software packages or fonts that need to be installed for these configurations to work correctly (e.g., AwesomeWM, Picom, Neovim, Kitty, required fonts for icons/glyphs).]

### License
[User: Choose a license if you wish (e.g., MIT, GPL). If you don't specify a license, standard copyright laws apply.]
