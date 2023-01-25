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
        { "catppuccin/nvim" }
    },
  },

  polish = function()
  end,
}

return config