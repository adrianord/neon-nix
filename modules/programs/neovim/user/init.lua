local config = {
  colorscheme = "catppuccin",

  options = {
    opt = {
      relativenumber = true,
      number = true,
      spell = false,
      signcolumn = "auto",
      wrap = false,
    },
    g = {
      mapleader = " ",
      autoformat_enabled = true,
      cmp_enabled = true,
      autopairs_enabled = true,
      diagnostics_enabled = true,
      status_diagnostics_enabled = true,
      icons_enabled = true,
      ui_notifications_enabled = true,
      heirline_bufferline = false,
    },
  },

  plugins = {
    init = {
      { "catppuccin/nvim" },
      { "Shatur/neovim-session-manager" }
    },
  },

  polish = function()
    local function alpha_on_bye(cmd)
      local bufs = vim.fn.getbufinfo { buflisted = true }
      vim.cmd(cmd)
      if require("core.utils").is_available "alpha-nvim" and not bufs[2] then
        require("alpha").start(true)
      end
    end

    vim.keymap.del("n", "<leader>c")
    if require("core.utils").is_available "bufdelete.nvim" then
      vim.keymap.set("n", "<leader>c", function()
        alpha_on_bye "Bdelete!"
      end, { desc = "Close buffer" })
    else
      vim.keymap.set("n", "<leader>c", function()
        alpha_on_bye "bdelete!"
      end, { desc = "Close buffer" })
    end
  end,
}

return config
