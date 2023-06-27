return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function()
      local null_ls = require("null-ls")
      return {
        on_attach = require("astronvim.utils.lsp").on_attach,
        sources = {
          null_ls.builtins.diagnostics.yamllint
        }
      }
    end
  }
}
