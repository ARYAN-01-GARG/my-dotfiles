#!/usr/bin/env bash

# setup.sh: ARYAN'S DOTFILES AUTOMATIC RESTORE & CENTRAL STOW INSTALLER
# One-command installer to cleanly back up, symlink, and bootstrap your entire laptop setup!

C_CYAN="\e[36m"
C_GREEN="\e[32m"
C_YELLOW="\e[33m"
C_RED="\e[31m"
C_BOLD="\e[1m"
C_RESET="\e[0m"

echo -e "${C_CYAN}${C_BOLD}🚀 Starting Aryan's Dotfiles Setup & Stow Symlinking...${C_RESET}\n"

# Parse CLI arguments
DRY_RUN=false
for arg in "$@"; do
    case $arg in
        -d|--dry-run)
            DRY_RUN=true
            shift
            ;;
    esac
done

if [ "$DRY_RUN" = true ]; then
    echo -e "${C_YELLOW}${C_BOLD}🛡️  DRY-RUN MODE ACTIVE: No files will be modified or stowed.${C_RESET}\n"
fi

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ──────────────────────────────────────────────────────────────
# 1. Platform-Agnostic Stow Verification & Installation
# ──────────────────────────────────────────────────────────────
if ! command -v stow >/dev/null 2>&1; then
    if [ "$DRY_RUN" = true ]; then
        echo -e "${C_YELLOW}⚠️  stow not found. [Dry-run] Would detect package manager and install stow.${C_RESET}"
    else
        echo -e "${C_YELLOW}⚠️  stow not found. Detecting package manager to install...${C_RESET}"
        if command -v pacman >/dev/null 2>&1; then
            echo -e "${C_GREEN}  -> Installing stow via pacman...${C_RESET}"
            sudo pacman -S --noconfirm stow
        elif command -v apt-get >/dev/null 2>&1; then
            echo -e "${C_GREEN}  -> Installing stow via apt...${C_RESET}"
            sudo apt-get update && sudo apt-get install -y stow
        elif command -v dnf >/dev/null 2>&1; then
            echo -e "${C_GREEN}  -> Installing stow via dnf...${C_RESET}"
            sudo dnf install -y stow
        elif command -v nix-env >/dev/null 2>&1; then
            echo -e "${C_GREEN}  -> Installing stow via nix...${C_RESET}"
            nix-env -iA nixpkgs.stow
        else
            echo -e "${C_RED}❌ Error: stow is not installed, and no supported package manager was found.${C_RESET}"
            echo -e "Please install GNU Stow manually and rerun this script."
            exit 1
        fi
    fi
fi

# ──────────────────────────────────────────────────────────────
# 2. Pre-flight System Dependency Auditing
# ──────────────────────────────────────────────────────────────
echo -e "${C_CYAN}🔍 Running pre-flight system dependency checks...${C_RESET}"
DEPENDENCIES=(
    # Core shell stack
    "zsh" "tmux" "fzf" "fd" "bat" "zoxide" "yazi" "lazygit" "eza" "rg"
    "atuin" "tealdeer" "starship"
    # System & desktop
    "fastfetch" "hyprland" "hypridle" "hyprlock" "hyprsunset"
    "waybar" "rofi" "swaync" "wlogout" "keyd" "quickshell" "wallust"
    # Wallpaper + screenshot + clipboard
    "awww-daemon" "grim" "slurp" "swappy" "cliphist"
    # Audio / power
    "mpd" "rmpc" "pamixer" "playerctl" "brightnessctl" "pavucontrol"
    # Misc utilities relied on by scripts
    "jq" "bc"
)
MISSING_DEPS=()
for dep in "${DEPENDENCIES[@]}"; do
    if ! command -v "$dep" >/dev/null 2>&1; then
        # Match debian-styled fd-find
        if [ "$dep" = "fd" ] && command -v fdfind >/dev/null 2>&1; then
            continue
        fi
        # eza replaced exa; either satisfies the requirement
        if [ "$dep" = "eza" ] && command -v exa >/dev/null 2>&1; then
            continue
        fi
        # ripgrep installs as `rg`
        if [ "$dep" = "rg" ] && command -v rg >/dev/null 2>&1; then
            continue
        fi
        # tealdeer installs as `tldr`
        if [ "$dep" = "tealdeer" ] && command -v tldr >/dev/null 2>&1; then
            continue
        fi
        # awww-daemon ships in the `awww` package
        if [ "$dep" = "awww-daemon" ] && command -v awww-daemon >/dev/null 2>&1; then
            continue
        fi
        # quickshell binary is `qs`
        if [ "$dep" = "quickshell" ] && command -v qs >/dev/null 2>&1; then
            continue
        fi
        MISSING_DEPS+=("$dep")
    fi
done

if [ ${#MISSING_DEPS[@]} -gt 0 ]; then
    echo -e "${C_YELLOW}⚠️  Note: The following recommended tools are not installed on your system:${C_RESET}"
    for dep in "${MISSING_DEPS[@]}"; do
        echo -e "   - ${C_RED}$dep${C_RESET}"
    done
    echo -e "${C_YELLOW}Some hotkeys, aliases, or configurations might be inactive until installed.${C_RESET}\n"
else
    echo -e "${C_GREEN}✅ All premium system dependencies found!${C_RESET}\n"
fi

# ──────────────────────────────────────────────────────────────
# 3. Dynamic Template Path Resolution
# ──────────────────────────────────────────────────────────────
SPICETIFY_INI="$BASE_DIR/spicetify/.config/spicetify/config-xpui.ini"
if [ -f "$SPICETIFY_INI" ]; then
    # Detect any /home/<user>/ pattern in prefs_path and remap to current $HOME.
    # Handles both the original YOUR_USERNAME placeholder and any committed real path.
    CUR_PREFS=$(grep -oE '/home/[^/[:space:]]+' "$SPICETIFY_INI" | head -1)
    if [ -n "$CUR_PREFS" ] && [ "$CUR_PREFS" != "$HOME" ]; then
        if [ "$DRY_RUN" = true ]; then
            echo -e "${C_GREEN}💾 [Dry-run] Would update Spicetify prefs_path: $CUR_PREFS -> $HOME${C_RESET}"
        else
            echo -e "${C_GREEN}💾 Updating Spicetify prefs_path: $CUR_PREFS -> $HOME${C_RESET}"
            sed -i "s|$CUR_PREFS|$HOME|g" "$SPICETIFY_INI"
        fi
    fi
fi

# ──────────────────────────────────────────────────────────────
# 4. Safe Configuration Backups
# ──────────────────────────────────────────────────────────────
BACKUP_DIR="$HOME/dotfiles_backup/backup_$(date +%Y%m%d_%H%M%S)"
CONFIG_FILES=(
    ".zshrc"
    ".config/nvim"
    ".config/tmux"
    ".config/hypr"
    ".config/kitty"
    ".config/ghostty"
    ".config/fastfetch"
    ".config/rofi"
    ".config/waybar"
    ".config/swaync"
    ".config/wlogout"
    ".config/mpd"
    ".config/rmpc"
    ".local/bin/tmux-sessionizer"
    ".local/bin/sys-fetch"
    ".local/bin/nfo"
)

if [ "$DRY_RUN" = false ]; then
    mkdir -p "$BACKUP_DIR"
    echo -e "${C_CYAN}📦 Backup folder set up: $BACKUP_DIR${C_RESET}"
fi

for file in "${CONFIG_FILES[@]}"; do
    TARGET_PATH="$HOME/$file"
    if [ -e "$TARGET_PATH" ] || [ -L "$TARGET_PATH" ]; then
        if [ -L "$TARGET_PATH" ]; then
            if [ "$DRY_RUN" = true ]; then
                echo -e "${C_YELLOW}🧹 [Dry-run] Would remove existing symlink: ~/$file${C_RESET}"
            else
                echo -e "${C_YELLOW}🧹 Removing existing symlink: ~/$file${C_RESET}"
                rm "$TARGET_PATH"
            fi
        else
            if [ "$DRY_RUN" = true ]; then
                echo -e "${C_GREEN}💾 [Dry-run] Would backup: ~/$file -> $BACKUP_DIR/$file${C_RESET}"
            else
                echo -e "${C_GREEN}💾 Backing up: ~/$file -> $BACKUP_DIR/$file${C_RESET}"
                mkdir -p "$(dirname "$BACKUP_DIR/$file")"
                mv "$TARGET_PATH" "$BACKUP_DIR/$file"
            fi
        fi
    fi
done

# ──────────────────────────────────────────────────────────────
# 5. Pre-create Crucial Directories
# ──────────────────────────────────────────────────────────────
if [ "$DRY_RUN" = false ]; then
    mkdir -p "$HOME/.config"
    mkdir -p "$HOME/.local/bin"
    mkdir -p "$HOME/.config/mpd/playlists"
    mkdir -p "$HOME/.config/mpd/music"
    mkdir -p "$HOME/Music"
fi

# ──────────────────────────────────────────────────────────────
# 6. Execute GNU Stow linking
# ──────────────────────────────────────────────────────────────
PACKAGES=(
    "zsh" "tmux" "nvim" "hypr" "kitty" "ghostty" "fastfetch" "rofi" "waybar" "swaync" "wlogout" "mpd" "rmpc" "scripts" "spicetify" "starship"
)

echo -e "\n${C_CYAN}🔗 Symlinking dotfiles using GNU Stow...${C_RESET}"
STOW_FAILED=false

for pkg in "${PACKAGES[@]}"; do
    if [ "$DRY_RUN" = true ]; then
        echo -e "${C_GREEN}  -> [Dry-run] Simulating stowing package: $pkg${C_RESET}"
        stow -nv -t "$HOME" "$pkg"
    else
        echo -e "${C_GREEN}  -> Stowing package: $pkg${C_RESET}"
        if ! stow -t "$HOME" "$pkg"; then
            echo -e "${C_RED}❌ Error stowing package: $pkg${C_RESET}"
            STOW_FAILED=true
        fi
    fi
done

if [ "$STOW_FAILED" = true ]; then
    echo -e "\n${C_RED}${C_BOLD}⚠️  Some stowing operations encountered warnings or errors.${C_RESET}"
    echo -e "${C_YELLOW}Please resolve any conflicting files listed above and re-run setup.sh.${C_RESET}"
fi

# ──────────────────────────────────────────────────────────────
# 7. Oh-My-Zsh & Zsh Plugins Bootstrapping
# ──────────────────────────────────────────────────────────────
echo -e "\n${C_CYAN}🔌 Bootstrapping Zsh Plugins...${C_RESET}"
OMZ_DIR="$HOME/.oh-my-zsh"
OMZ_CUSTOM="$OMZ_DIR/custom"

if [ ! -d "$OMZ_DIR" ]; then
    if [ "$DRY_RUN" = true ]; then
        echo -e "  -> [Dry-run] Would install Oh-My-Zsh automatically..."
    else
        echo -e "  -> Oh-My-Zsh not found. Installing unattended..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    fi
fi

if [ "$DRY_RUN" = true ]; then
    echo -e "  -> [Dry-run] Would clone Zsh plugins if missing (autosuggestions, syntax-highlighting, completions)..."
else
    if [ -d "$OMZ_CUSTOM" ]; then
        if [ ! -d "$OMZ_CUSTOM/plugins/zsh-autosuggestions" ]; then
            echo -e "  -> Installing zsh-autosuggestions..."
            git clone https://github.com/zsh-users/zsh-autosuggestions "$OMZ_CUSTOM/plugins/zsh-autosuggestions"
        fi
        if [ ! -d "$OMZ_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
            echo -e "  -> Installing zsh-syntax-highlighting..."
            git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$OMZ_CUSTOM/plugins/zsh-syntax-highlighting"
        fi
        if [ ! -d "$OMZ_CUSTOM/plugins/zsh-completions" ]; then
            echo -e "  -> Installing zsh-completions..."
            git clone https://github.com/zsh-users/zsh-completions "$OMZ_CUSTOM/plugins/zsh-completions"
        fi
    fi
fi

# ──────────────────────────────────────────────────────────────
# 8. Bootstrapping Tmux Plugin Manager (TPM)
# ──────────────────────────────────────────────────────────────
echo -e "\n${C_CYAN}🔌 Bootstrapping Tmux Plugin Manager (TPM)...${C_RESET}"
TPM_DIR="$HOME/.config/tmux/.tmux/plugins/tpm"

if [ ! -d "$TPM_DIR" ]; then
    if [ "$DRY_RUN" = true ]; then
        echo -e "  -> [Dry-run] Would clone Tmux Plugin Manager..."
    else
        echo -e "  -> Installing TPM..."
        mkdir -p "$(dirname "$TPM_DIR")"
        git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
    fi
fi

# ──────────────────────────────────────────────────────────────
# 9. Installation Report
# ──────────────────────────────────────────────────────────────
if [ "$DRY_RUN" = true ]; then
    echo -e "\n${C_GREEN}${C_BOLD}🎉 Dry-run audit complete! Run the script without flags to deploy!${C_RESET}"
else
    echo -e "\n${C_GREEN}${C_BOLD}🎉 Setup complete! Re-run 'source ~/.zshrc' to apply changes.${C_RESET}"
    echo -e "${C_CYAN}${C_BOLD}🛸 Run 'nfo' to see your beautiful cheatsheet manual!${C_RESET}"
fi
