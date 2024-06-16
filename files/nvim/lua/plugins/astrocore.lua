-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`


local lspCodeAction = { function() vim.lsp.buf.code_action() end, desc = "LSP code action" };
local toggleExplorer = { "<cmd>Neotree toggle<cr>", desc = "Toggle Explorer" };

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 },
      autopairs = true,
      cmp = true,
      diagnostics_mode = 3,
      highlighturl = true,
      notifications = true,
    },
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    options = {
      opt = {
        relativenumber = true,
        number = true,
        spell = false,
        signcolumn = "yes",
        wrap = false,
        autoindent = true,
      },
      g = {
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
        ["<M-1>"] = toggleExplorer,
        ["<D-1>"] = toggleExplorer,
        ["<M-CR>"] = lspCodeAction,
        ["<D-CR>"] = lspCodeAction,
        ["<Leader>q"] = { "<cmd>qa<cr>", desc = "Quit" },
        ["L"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["H"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },
        ["<Leader>lp"] = {
            "<cmd>LspRestart<cr>",
            desc = "Restart LSP",
        }
      },
      i = {
      },
      t = {
        ["<C-l>"] = false,
        ["<C-j>"] = false,
        ["<C-k>"] = false,
      },

    },
  },
}
