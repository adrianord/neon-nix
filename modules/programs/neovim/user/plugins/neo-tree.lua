return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    window = {
      position = "right",
      width = 50,
    },
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
        hide_by_name = {
          ".git"
        },
      },
    },
    mapping_options = {
      noremap = false,
    },
    mappings = {
      ["<M-1>"] = "close_window",
      ["<D-1>"] = "close_window",
    },
    event_handlers = {
      {
        event = "file_opened",
        handler = function(_)
          --auto close
          require("neo-tree").close_all()
        end
      },
    },
  },
}
