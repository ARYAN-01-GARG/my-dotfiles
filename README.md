# 🛸 ARYAN'S ARCH-HYPRLAND CENTRAL DOTFILES

Welcome to your central, fully automated, and highly portable dotfiles repository! 

This repository utilizes **GNU Stow** to manage, link, and restore your complete desktop environment, window manager, shell, editors, and custom tools with a single script call.

---

## 📂 Repository Architecture

```text
my-dotfiles/
├── setup.sh                     # One-click system installer and backup utility
├── README.md                    # Main documentation manual
├── zsh/                         # Oh-My-Zsh configurations
│   ├── .zshrc
│   └── README.md
├── tmux/                        # Tmux config + floating popups
│   ├── .config/tmux/tmux.conf
│   └── README.md
├── nvim/                        # Premium custom LazyVim configuration
│   ├── .config/nvim/...
│   └── README.md
├── hypr/                        # Hyprland window manager configurations
│   └── .config/hypr/...
├── kitty/                       # Kitty terminal configuration
│   └── .config/kitty/...
├── fastfetch/                   # Fastfetch compact status configs
│   └── .config/fastfetch/...
├── rofi/                        # Rofi application launcher
│   └── .config/rofi/...
├── waybar/                      # Waybar desktop bar config
│   └── .config/waybar/...
├── swaync/                      # Sway Notification Center
│   └── .config/swaync/...
├── wlogout/                     # Wlogout power menu configs
│   └── .config/wlogout/...
└── scripts/                     # Custom bin scripts (stowed to ~/.local/bin)
    └── .local/bin/
        ├── tmux-sessionizer     # Fuzzy workspace terminal connector
        ├── sys-fetch            # Minimalist custom specs fetcher
        └── nfo                  # Retro aesthetic cheatsheet manual
```

---

## 🚀 Easy Restore Instructions (On Any Laptop)

Setting up a fresh machine or applying your customized configs is incredibly simple:

1. **Clone this repository**:
   ```bash
   git clone https://github.com/ARYAN-01-GARG/my-dotfiles.git ~/my-dotfiles
   ```
2. **Execute the Installer**:
   ```bash
   cd ~/my-dotfiles
   ./setup.sh
   ```

### What `setup.sh` does automatically:
1. **Safety Backup**: Backs up all existing conflicting files (like your old `.zshrc` or `.config/nvim`) to a timestamped folder in `~/dotfiles_backup/` to ensure no data is ever lost.
2. **Package Linking**: Runs `stow` to link all configurations into their appropriate spots (`~/.config/`, `~/.local/bin/`, etc.).
3. **Zsh Plugins**: Autodetects and clones missing Oh-My-Zsh plugins (`zsh-autosuggestions`, `zsh-syntax-highlighting`, `zsh-completions`).
4. **Tmux plugins**: Installs Tmux Plugin Manager (TPM).

---

## ⚡ Key Commands to Run Immediately
* `source ~/.zshrc` : Applies new Zsh settings to your shell.
* `sys-fetch` : Runs your custom specs fetcher.
* `nfo` : Pulls up your interactive cheatsheet manual to view all your custom keybindings instantly!
