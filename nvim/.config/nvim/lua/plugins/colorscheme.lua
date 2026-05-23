return {
  -- Configure LazyVim to load catppuccin by default
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },

  -- Catppuccin Mocha (matches terminal/tmux/waybar)
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha",
      transparent_background = true,
      term_colors = true,
      integrations = {
        alpha = true,
        cmp = true,
        dashboard = true,
        flash = true,
        gitsigns = true,
        harpoon = true,
        headlines = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        leap = true,
        lsp_trouble = true,
        mason = true,
        markdown = true,
        mini = true,
        neogit = true,
        neotree = true,
        noice = true,
        notify = true,
        nvimtree = true,
        semantic_tokens = true,
        symbols_outline = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        ts_context_commentstring = true,
        which_key = true,
      },
    },
  },
}
