#!/usr/bin/env bash
# Launches a TUI monitoring tool in the user's chosen terminal.
# Used by waybar module on-click handlers.

config_file="$HOME/.config/hypr/UserConfigs/01-UserDefaults.conf"

if [[ ! -f "$config_file" ]]; then
    notify-send -u critical "Waybar" "Config not found: $config_file"
    exit 1
fi

# Source 01-UserDefaults.conf (strip Hyprland's `$` prefixes and ` = ` spacing)
config_content=$(sed 's/\$//g; s/ = /=/' "$config_file")
eval "$config_content"

if [[ -z "$term" ]]; then
    notify-send -u critical "Waybar" "\$term not set in 01-UserDefaults.conf"
    exit 1
fi

# Run a command inside the user's terminal. Each terminal takes the
# command differently, so dispatch on the binary name.
run_in_term() {
    local title="$1"; shift
    local cmd="$*"
    case "$term" in
        ghostty)
            setsid "$term" --title="$title" -e sh -c "$cmd" >/dev/null 2>&1 &
            ;;
        kitty)
            setsid "$term" --title "$title" sh -c "$cmd" >/dev/null 2>&1 &
            ;;
        alacritty)
            setsid "$term" --title "$title" -e sh -c "$cmd" >/dev/null 2>&1 &
            ;;
        wezterm)
            setsid "$term" start --always-new-process -- sh -c "$cmd" >/dev/null 2>&1 &
            ;;
        foot|footclient)
            setsid "$term" --title="$title" sh -c "$cmd" >/dev/null 2>&1 &
            ;;
        *)
            setsid "$term" -e sh -c "$cmd" >/dev/null 2>&1 &
            ;;
    esac
}

launch_files() {
    if [[ -z "$files" ]]; then
        notify-send -u low -i "$HOME/.config/swaync/images/error.png" \
            "Waybar: files" "Set \$files in 01-UserDefaults.conf or install a file manager."
        return 1
    fi
    setsid "$files" >/dev/null 2>&1 &
}

case "$1" in
    --btop)      run_in_term "btop"      "btop" ;;
    --htop)      run_in_term "htop"      "htop" ;;
    --nvtop)     run_in_term "nvtop"     "nvtop" ;;
    --bottom)    run_in_term "bottom"    "btm" ;;
    --nmtui)     run_in_term "nmtui"     "nmtui" ;;
    --bluetuith) run_in_term "bluetuith" "bluetuith" ;;
    --ncdu)
        if command -v ncdu >/dev/null 2>&1; then
            run_in_term "ncdu" "ncdu /"
        else
            notify-send -u normal "Waybar: disk" "Install ncdu: sudo pacman -S ncdu"
        fi
        ;;
    --term)      setsid "$term" >/dev/null 2>&1 & ;;
    --files)     launch_files ;;
    *)
        cat <<EOF
Usage: $0 [option]
  --btop        Open btop in a new terminal
  --htop        Open htop in a new terminal
  --nvtop       Open nvtop (GPU monitor) in a new terminal
  --bottom      Open bottom (btm) in a new terminal
  --nmtui       Open nmtui in a new terminal
  --bluetuith   Open bluetuith in a new terminal
  --term        Open a fresh terminal window
  --files       Open the configured file manager
EOF
        ;;
esac
