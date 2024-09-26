local telescope_actions = require("telescope.actions")

lvim.builtin.telescope.defaults.mappings = {
  i = {
    ["<C-k>"] = telescope_actions.move_selection_previous,
    ["<C-j>"] = telescope_actions.move_selection_next,
  },
}

lvim.builtin.telescope.pickers.find_files = {
  hidden = true,
  ignore = true,
  find_command = {
    "rg",
    "--files",
    "--hidden",
    "--no-ignore-vcs",
    "-g",
    "!**/.git/*",
    "-g",
    "!**/node_modules/*",
    "-g",
    "!**/.repro/*", -- just to hide .repro rtp
  },
}

lvim.builtin.telescope.pickers.buffers = {
  initial_mode = "insert",
  mappings = {
    i = {
      ["<C-k>"] = telescope_actions.move_selection_previous,
      ["<C-j>"] = telescope_actions.move_selection_next,
    },
    n = {
      ["<C-k>"] = telescope_actions.move_selection_previous,
      ["<C-j>"] = telescope_actions.move_selection_next,
    },
  },
}
