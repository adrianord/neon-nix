-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`

local lspCodeAction = { function() vim.lsp.buf.code_action() end, desc = "LSP code action" };
local toggleExplorer = { "<cmd>Neotree toggle<cr>", desc = "Toggle Explorer" };

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    sessions = {
      autosave = {
        last = true,
        cwd = true,
      },
    },
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
        },
        ["<Leader>c"] = {
          function()
            local bufs = vim.fn.getbufinfo { buflisted = 1 }
            require("astrocore.buffer").close()
            if require("astrocore").is_available "alpha-nvim" and not bufs[2] then
              require("alpha").start(true)
              if require("astrocore").is_available "resession.nvim" then
                local current = require("resession").get_current_session_info()
                if current then
                  require("resession").delete(current.name, { dir = current.dir })
                end
              end
            end
          end
        },
      },
      i = {
      },
      t = {
        ["<C-l>"] = false,
        ["<C-j>"] = false,
        ["<C-k>"] = false,
      },
    },
    autocmds = {
      restore_session = {
        {
          event = "VimEnter",
          desc = "Restore previous directory session if neovim opened with no arguments",
          nested = true, -- trigger other autocommands as buffers open
          callback = function()
            -- Only load the session if nvim was started with no args
            if vim.fn.argc(-1) == 0 then
              -- try to load a directory session using the current working directory
              require("resession").load(
                vim.fn.getcwd(),
                { dir = "dirsession", silence_errors = true }
              )
            end
          end,
        },
      },
    },
  },
}
