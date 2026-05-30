return {
  -- Dashboard configuration (Modern retro dashboard-nvim)
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function()
      local logo = [[
 █████  ███    ██ ████████ ██  ██████  ██████   █████  ██    ██ ████████ ██    ██ 
██   ██ ████   ██    ██    ██ ██       ██   ██ ██   ██  ██  ██     ██    ██    ██ 
███████ ██ ██  ██    ██    ██ ██   ███ ██████  ███████   ████      ██    ██    ██ 
██   ██ ██  ██ ██    ██    ██ ██    ██ ██   ██ ██   ██    ██       ██     ██  ██  
██   ██ ██   ████    ██    ██  ██████  ██   ██ ██   ██    ██       ██      ████   
      ]]

      local opts = {
        theme = "doom",
        hide = {
          statusline = false,
          tabline = false,
          winbar = false,
        },
        config = {
          header = vim.split(logo, "\n"),
          center = {
            { action = 'Telescope find_files',                               desc = ' Find File',       icon = ' ', key = 'f' },
            { action = 'ene | startinsert',                                  desc = ' New File',        icon = ' ', key = 'n' },
            { action = 'Telescope oldfiles',                                 desc = ' Recent Files',    icon = ' ', key = 'r' },
            { action = 'Telescope live_grep',                                desc = ' Find Text',       icon = ' ', key = 'g' },
            { action = 'Lazy',                                               desc = ' Lazy Plugins',    icon = '󰒲 ', key = 'l' },
            { action = 'qa',                                                 desc = ' Quit',            icon = ' ', key = 'q' },
          },
          footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
          end,
        },
      }

      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
        button.key_format = "  %s"
      end

      -- open dashboard after all buffers are closed
      if vim.o.filetype == "lazy" then
        vim.cmd("close")
      end

      return opts
    end,
  },

  -- Custom Lualine status bar (minimalist and matching mocha)
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.options = {
        theme = "auto",
        globalstatus = true,
        disabled_filetypes = { statusline = { "dashboard", "alpha" } },
      }
      opts.sections = {
        lualine_a = { { "mode", separator = { left = "", right = "" }, right_padding = 2 } },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { { "location", separator = { left = "", right = "" }, left_padding = 2 } },
      }
    end,
  },

  -- Custom Bufferline for aesthetic tabs
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
      { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete Other Buffers" },
      { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
      { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
      { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
    },
    opts = {
      options = {
        close_command = function(n) vim.cmd("bdelete! " .. n) end,
        right_mouse_command = function(n) vim.cmd("bdelete! " .. n) end,
        diagnostics = "nvim_lsp",
        always_show_bufferline = true,
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            text_align = "left",
            separator = true,
          },
        },
      },
    },
  },
}
