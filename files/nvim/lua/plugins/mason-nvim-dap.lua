return {
  "jay-babu/mason-nvim-dap.nvim",
  opts = {
    handlers = {
      python = function()
        local dap = require("dap")
        dap.adapters.python = {
          type = "executable",
          command = os.getenv("VIRTUAL_ENV") .. "/bin/python",
          args = {
            "-m",
            "debugpy.adapter",
          },
        }

        dap.configurations.python = {
          {
            type = "python",
            request = "launch",
            name = "Launch file",
            cwd = function()
              return util.root_pattern("pyproject.toml")(vim.fn.getcwd())
            end,
            program = "${file}", -- This configuration will launch the current file if used.
            pythonPath = function()
              local cwd = vim.fn.getcwd()
              if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
                return cwd .. "/venv/bin/python"
              elseif vim.fn.executable(cwd "/.venv/bin/python" == 1) then
                return cwd .. "/.venv/bin/python"
              end
            end,
          },
        }
      end,
    },
  },
}
