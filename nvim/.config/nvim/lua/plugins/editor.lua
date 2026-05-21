return {
  -- Snacks Explorer (the <leader>e side panel in LazyVim 14+): show hidden + gitignored
  -- so .env, .env.local, .env.production etc. are visible by default.
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          explorer = {
            hidden = true,   -- show dotfiles (.env, .gitignore, etc.)
            ignored = true,  -- show files matched by .gitignore (.env usually is)
            exclude = { ".git", "node_modules", ".DS_Store" }, -- still hide the truly noisy ones
          },
        },
      },
    },
  },

  -- Oil.nvim (file-system as a buffer)
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup({
        default_file_explorer = true,
        columns = { "icon" },
        keymaps = {
          ["g?"] = "actions.show_help",
          ["<CR>"] = "actions.select",
          ["<C-s>"] = "actions.select_vsplit",
          ["<C-h>"] = "actions.select_split",
          ["<C-t>"] = "actions.select_tab",
          ["<C-p>"] = "actions.preview",
          ["<C-c>"] = "actions.close",
          ["<C-l>"] = "actions.refresh",
          ["-"] = "actions.parent",
          ["_"] = "actions.open_cwd",
          ["`"] = "actions.cd",
          ["~"] = "actions.tcd",
          ["gs"] = "actions.change_sort",
          ["gx"] = "actions.open_external",
          ["g."] = "actions.toggle_hidden",
          ["g\\"] = "actions.toggle_trash",
        },
        use_default_keymaps = false,
        view_options = {
          show_hidden = true,
          is_hidden_file = function(name)
            return vim.startswith(name, ".") and name ~= ".config" and name ~= ".gitignore"
          end,
          is_always_hidden_file = function() return false end,
        },
      })
    end,
  },

  -- Telescope: keep keymap + minor layout tweaks
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
    },
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
        mappings = {
          i = {
            ["<C-j>"] = "move_selection_next",
            ["<C-k>"] = "move_selection_previous",
          },
        },
      },
    },
  },

  -- Mason: language extras pull their own LSPs; only keep tools that no extra owns.
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",     -- Lua formatter (for editing this nvim config)
        "shellcheck", -- shell linter
        "shfmt",      -- shell formatter
      },
    },
  },

  -- Free <C-a>/<C-x> for select-all by moving dial.nvim onto +/-
  -- (Existing keymaps.lua already binds + and - to vim's built-in C-a/C-x;
  --  this override makes dial.nvim's smart increment take over those keys.)
  {
    "monaqa/dial.nvim",
    keys = {
      { "+", function() return require("dial.map").inc_normal() end, expr = true, desc = "Increment" },
      { "-", function() return require("dial.map").dec_normal() end, expr = true, desc = "Decrement" },
      { "+", function() return require("dial.map").inc_visual() end, mode = "v", expr = true, desc = "Increment" },
      { "-", function() return require("dial.map").dec_visual() end, mode = "v", expr = true, desc = "Decrement" },
      -- Disable defaults so <C-a> stays free for select-all
      { "<C-a>", false },
      { "<C-x>", false },
    },
  },
}
