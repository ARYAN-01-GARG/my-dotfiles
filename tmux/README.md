# 🪐 Tmux Supercharged Configuration Documentation

This package contains your modern Tmux configuration, featuring clean layout variables, status bars, and floating popup utility tools.

---

## ⚡ Quick-Reference Utility Keybinds

We have removed confirmation prompts and added floating terminals and tools so you can move at maximum velocity:

| Keybinding | Action | Description |
| :--- | :--- | :--- |
| `prefix + d` | **Quick Config Menu** | Opens a floating popup interactive menu to select and edit config files (`.zshrc`, `tmux.conf`, `nvim`, `hyprland`, `keyd`). |
| `prefix + Ctrl-y` | **Floating Yazi** | Pops open a beautiful, full-sized visual file manager in a floating panel. |
| `prefix + Ctrl-g` | **Floating Lazygit** | Pops open a gorgeous floating Git control panel. |
| `prefix + Ctrl-t` | **Floating Quick Shell** | Pops open a floating temporary Zsh shell for secondary tasks. |
| `prefix + f` | **Tmux Sessionizer** | Runs your custom interactive script to fuzzy-connect to workspaces. |
| `prefix + o` | **Sessionx Selector** | Runs your interactive session manager. |
| `bind x` | **Kill Pane** | Instantly terminates the current pane without showing the annoying confirmation prompt. |
| `prefix + r` | **Reload Config** | Instantly re-reads and applies `tmux.conf` changes. |
| `prefix + \` | **Split Horizontal** | Splits current window vertically (side-by-side). |
| `prefix + -` | **Split Vertical** | Splits current window horizontally (stacked). |

---

## 🎨 Aesthetic Theme Styling

* **Catppuccin (Mocha)**: Custom active colors, using distinct red active indicators when `prefix` is tapped, and sleek green accents for active sessions.
* **Online Status Indicator**: Integrates with your network interface, showing a beautiful purple `󰖩 on` or bold red `󰖪 off` directly on the right status bar.
* **Persistent Sessions**: Powered by `tmux-resurrect` and `tmux-continuum`, your sessions are automatically saved every 15 minutes and restored on system boots!
