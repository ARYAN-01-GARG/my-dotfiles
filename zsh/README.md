# 🛸 Zsh Supercharged Configuration Documentation

This package contains your modern Zsh configuration. It is built on top of [Oh-My-Zsh](https://github.com/ohmyzsh/ohmyzsh) and is optimized for extreme interactive speed, autocompleting, and system control.

---

## 🔌 Enabled Plugins & Creator Links

Here is the full list of enabled Zsh plugins, what they do, and direct links to their official creator repositories on GitHub:

### 1. [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
* **What it does**: Suggests commands as you type based on your shell history, using a subtle gray overlay. Press `Ctrl + F` or `→` (Right Arrow) to accept the suggestion.
* **Official Creator Repo**: [zsh-users/zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)

### 2. [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
* **What it does**: Provides real-time syntax highlighting for shell commands. Green represents valid commands/aliases; red represents invalid or mistyped commands.
* **Official Creator Repo**: [zsh-users/zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)

### 3. [zsh-completions](https://github.com/zsh-users/zsh-completions)
* **What it does**: Adds thousands of extra tab-completion definitions for common commands (like `pacman`, `yay`, `git`, `docker`, `npm`, etc.) that are missing from default Zsh.
* **Official Creator Repo**: [zsh-users/zsh-completions](https://github.com/zsh-users/zsh-completions)

### 4. [sudo plugin (Oh-My-Zsh)](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/sudo)
* **What it does**: Double-tap `Escape` key at any point while typing a command, and it will instantly prepend `sudo ` to the front of your current terminal line!
* **Official Creator Documentation**: [Oh-My-Zsh Sudo Plugin](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/sudo)

### 5. [web-search plugin (Oh-My-Zsh)](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/web-search)
* **What it does**: Initiate web searches directly from your command line!
  * `google hello world` : Opens your default browser and searches Google for "hello world".
  * `github neovim` : Searches GitHub for "neovim".
* **Official Creator Documentation**: [Oh-My-Zsh Web-Search Plugin](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/web-search)

### 6. [git plugin (Oh-My-Zsh)](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git)
* **What it does**: Leverages a massive library of high-productivity git aliases. Some extremely popular built-in aliases:
  * `gst` -> `git status`
  * `gd`  -> `git diff`
  * `glg` -> `git log --stat`
  * `gcam` -> `git commit -a -m`
* **Official Creator Documentation**: [Oh-My-Zsh Git Plugin](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git)

### 7. [archlinux plugin (Oh-My-Zsh)](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/archlinux)
* **What it does**: Fast shortcuts for Arch Linux package management:
  * `pacupg` -> `sudo pacman -Syu` (Updates system)
  * `pacin`  -> `sudo pacman -S` (Installs packages)
* **Official Creator Documentation**: [Oh-My-Zsh ArchLinux Plugin](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/archlinux)

---

## ⚡ Supercharged Custom Aliases

Your revamped configuration removes duplicate/redundant aliases and establishes super clean, modern shortcuts:

### Modern Git Switch Commands
* `gsw` : `git switch` (Switch branches cleanly)
* `gsc` : `git switch -c` (Create and switch to a new branch)

### Interactive Fuzzy Navigation (fzf + bat)
* `ff`    : Fuzzy search files and open the selected one in Neovim (with syntax-highlighted preview window).
* `nf`    : Fuzzy search directories under home and open them in Neovim.
* `cdh`   : Fuzzy search home directories and `cd` directly into them.
* `cdf`   : Fuzzy search current-subdirectories and `cd` directly into them.

### Instant Dotfile Configuration Editing
* `confz` : Instantly edit your `.zshrc` in Neovim.
* `conft` : Instantly edit your `tmux.conf` in Neovim.
* `confv` : Instantly edit your Neovim configurations.
* `confh` : Instantly edit your Hyprland configuration.
