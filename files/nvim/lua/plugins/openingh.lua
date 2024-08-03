---@type LazySpec
return {
  "almo7aya/openingh.nvim",
  cmd = { "OpenInGHRepo", "OpenInGHFile", "OpenInGHFileLines" },
  dependencies = {
    "AstroNvim/astrocore",
    init = function()
      vim.g.openingh_copy_to_register = true
    end,
    opts = function(_, opts)
      local prefix = "<Leader>g"
      opts.mappings.n[prefix] = { desc = "OpenInGH" }
      opts.mappings.n[prefix .. "o"] = { "<Cmd>OpenInGHFile<CR>", desc = "Open file in GitHub" }
      opts.mappings.n[prefix .. "O"] = { "<Cmd>OpenInGHFile+<CR>", desc = "Copy link to GitHub" }
      opts.mappings.n[prefix .. "f"] = { "<Cmd>OpenInGHFileLines<CR>", desc = "Open line in GitHub" }
      opts.mappings.n[prefix .. "F"] = { "<Cmd>OpenInGHFileLines!<CR>", desc = "Open perma line in GitHub" }
      opts.mappings.v[prefix .. "f"] = { ":'<,'>OpenInGHFileLines<CR>", desc = "Open line in GitHub" }
      opts.mappings.v[prefix .. "F"] = { ":'<,'>OpenInGHFileLines! +<CR>", desc = "Open perma line in GitHub" }
      opts.mappings.n[prefix .. "y"] = { "<Cmd>OpenInGHFileLines+<CR>", desc = "Copy link to GitHub line" }
      opts.mappings.n[prefix .. "Y"] = { "<Cmd>OpenInGHFileLines! +<CR>", desc = "Copy permalink to GitHub" }
      opts.mappings.v[prefix .. "y"] = { ":'<,'>OpenInGHFileLines+<CR>", desc = "Copy link to GitHub line" }
      opts.mappings.v[prefix .. "Y"] = { ":'<,'>OpenInGHFileLines! +<CR>", desc = "Copy permalink to GitHub" }
    end,
  },
}
