return {
  {
    "nvim-neotest/neotest",
    ft = { "javascript", "typescript" },
    dependencies = {
      "adrianord/neotest-vitest",
      {
        "haydenmeade/neotest-jest",
        "folke/neodev.nvim",
        opts = function(_, opts)
          opts.library = opts.library or {}
          if opts.library.plugins ~= true then
            opts.library.plugins = require("astronvim.utils").list_insert_unique(opts.library.plugins, "neotest")
          end
          opts.library.types = true
        end,
      },
    },
    opts = function()
      return {
        -- your neotest config here
        adapters = {
          require("neotest-vitest")({
            vitestCommand = "npm test --",
            cwd = function(_)
              return vim.fn.getcwd()
            end
          }),
          require("neotest-jest")({
            jestCommand = "npm test --",
            cwd = function(_)
              return vim.fn.getcwd()
            end
          }),
        },
      }
    end,
  },
  {
    "catppuccin/nvim",
    optional = true,
    opts = { integrations = { neotest = true } },
  },
}
