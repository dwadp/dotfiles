return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  -- event = "VimEnter",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup({
      update_focused_file = {
        enable = true,
        update_cwd = true,
      },
      renderer = {
        root_folder_modifier = ":t",
        -- These icons are visible when you install web-devicons
        icons = {
          glyphs = {
            default = "",
            symlink = "",
            folder = {
              arrow_open = "",
              arrow_closed = "",
              default = "",
              open = "",
              empty = "",
              empty_open = "",
              symlink = "",
              symlink_open = "",
            },
            git = {
              unstaged = "",
              staged = "S",
              unmerged = "",
              renamed = "➜",
              untracked = "U",
              deleted = "",
              ignored = "◌",
            },
          },
        },
      },
      diagnostics = {
        enable = true,
        show_on_dirs = true,
        icons = {
          hint = "",
          info = "",
          warning = "",
          error = "",
        },
      },
      view = {
        width = 35,
        side = "left",
      },
    })

    local api = require "nvim-tree.api"

    vim.keymap.set("n", "<leader>tf", function()
      if vim.bo.filetype == "NvimTree" then
        vim.cmd.wincmd "p"
      else
        api.tree.focus()
      end
    end, { noremap = true, desc = "Toggle explorer focus" })

    -- custom mappings
    vim.keymap.set('n', '<leader>tc', api.tree.change_root_to_node, { noremap = true, desc = "Change root to the current node" })
    vim.keymap.set('n', '<leader>te', api.tree.open, { noremap = true, desc = "Open the sidebar file tree" })
    vim.keymap.set('n', '<leader>tr', api.tree.reload, { noremap = true, desc = "Reload the sidebar file tree" })
    vim.keymap.set('n', '<leader>tx', api.tree.close, { noremap = true, desc = "Close the sidebar file tree" })
  end
}
