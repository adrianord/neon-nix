local toggleTermCmd = "<cmd>ToggleTerm direction=horizontal<cr>";
local toggleTermDesc = "ToggleTerm horizontal split";
return {
  "akinsho/toggleterm.nvim",
  opts = {
    size = function(term)
      if term.direction == "horizontal" then
        return 25
      end
      return 10
    end,
  },
  keys = {
    { "<leader>th", mode = "n", toggleTermCmd, desc = toggleTermDesc },
    { "<M-C-1>",    mode = "n", toggleTermCmd, desc = toggleTermDesc },
    { "<D-C-1>",    mode = "n", toggleTermCmd, desc = toggleTermDesc },
    { "<M-C-1>",    mode = "i", toggleTermCmd, desc = toggleTermDesc },
    { "<D-C-1>",    mode = "i", toggleTermCmd, desc = toggleTermDesc },
    { "<M-C-1>",    mode = "t", toggleTermCmd, desc = toggleTermDesc },
    { "<D-C-1>",    mode = "t", toggleTermCmd, desc = toggleTermDesc },
    { "<S-ESC>",    mode = "t", toggleTermCmd, desc = toggleTermDesc },
  },
}
