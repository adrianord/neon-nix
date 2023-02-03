local toggleTerm = { "<cmd>ToggleTerm direction=horizontal<cr>", desc = "ToggleTerm horizontal split" };
local lspCodeAction = { function() vim.lsp.buf.code_action() end, desc = "LSP code action" };
return {
  colorscheme = "catppuccin",

  options = {
    opt = {
      relativenumber = true,
      number = true,
      spell = false,
      signcolumn = "auto",
      wrap = false,
      autoindent = true,
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

  mappings = {
    n = {
      ["<leader>th"] = toggleTerm,
      ["<M-C-1>"] = toggleTerm,
      ["<D-C-1>"] = toggleTerm,
      ["<M-CR>"] = lspCodeAction,
      ["<D-CR>"] = lspCodeAction,
    },
    i = {
      ["<M-C-1>"] = toggleTerm,
      ["<D-C-1>"] = toggleTerm,
    },
    t = {
      ["<M-C-1>"] = toggleTerm,
      ["<D-C-1>"] = toggleTerm,
    },
  },

  plugins = {
    init = {
      { "catppuccin/nvim" },
      { "gpanders/editorconfig.nvim" },
      ["Shatur/neovim-session-manager"] = { event = "VimEnter" }
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
