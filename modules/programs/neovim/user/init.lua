local lspCodeAction = { function() vim.lsp.buf.code_action() end, desc = "LSP code action" };
local toggleExplorer = { "<cmd>Neotree toggle<cr>", desc = "Toggle Explorer" };

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
            ["<M-1>"] = toggleExplorer,
            ["<D-1>"] = toggleExplorer,
            ["<M-CR>"] = lspCodeAction,
            ["<D-CR>"] = lspCodeAction,
            ["<leader>q"] = { "<cmd>qa<cr>", desc = "Quit" },
            ["L"] = {
                function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
                desc = "Next buffer"
            },
            ["H"] = {
                function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
                desc = "Previous buffer",
            },
            ["<leader>lp"] = {
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
    polish = function()
        -- Modify close buffer to open Alpha if no other buffers are open
        vim.keymap.del("n", "<leader>c")
        vim.keymap.set("n", "<leader>c", function()
            local bufs = vim.fn.getbufinfo { buflisted = true }
            require("astronvim.utils.buffer").close()
            if require("astronvim.utils").is_available "alpha-nvim" and not bufs[2] then
                require("alpha").start(true)
            end
        end, { desc = "Close buffer" })
    end,
    lsp = {
        formatting = {
            format_on_save = {
                enable = true,
                ignore_filetypes = {
                    "yaml"
                },
            },

        },
    },
}
