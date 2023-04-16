return {
  "Shatur/neovim-session-manager",
  opts = (function()
    if vim.g.vscode then
      return {
        autoload_mode = require('session_manager.config').AutoloadMode.Disabled,
        autosave_last_session = false,
      }
    else
      return {
        autoload_mode = require('session_manager.config').AutoloadMode.CurrentDir,
        autosave_last_session = true,
      }
    end
  end)(),
}
