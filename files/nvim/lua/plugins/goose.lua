return {
  "azorng/goose.nvim",
  config = function()
    require("goose").setup {
      keymap = {
        global = {
          toggle = "<leader>sg",
          open_input = "<leader>si",
          open_input_new_session = "<leader>sI",
          open_output = "<leader>so",
          toggle_focus = "<leader>st",
          close = "<leader>sq",
          toggle_fullscreen = "<leader>sf",
          select_session = "<leader>ss",
          goose_mode_chat = "<leader>smc",
          goose_mode_auto = "<leader>sma",
          configure_provider = "<leader>sp",
          diff_open = "<leader>sd",
          diff_next = "<leader>s]",
          diff_prev = "<leader>s[",
          diff_close = "<leader>sc",
          diff_revert_all = "<leader>sra",
          diff_revert_this = "<leader>srt",
        },
      },
    }
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        anti_conceal = { enabled = false },
      },
    },
  },
}
