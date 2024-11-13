return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.6",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        prompt_prefix = "$ ",
        path_display = { "smart" },
        mappings = {
          i = {
            ["<C-h>"] = "which_key",
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
          },
        },
        winblend = 0,
        border = {},
        borderchars = nil,
        color_devicons = true,
      },
      pickers = {
        find_files = {
          theme = "dropdown",
          hidden = false,
          ignore = false,
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
        },
      },
      extensions = {
        --
      },
    })

    local builtin = require("telescope.builtin")
    local opts = { noremap = true }

    opts.desc = "Lists files in your current working directory, respects .gitignore"
    vim.keymap.set("n", "<leader>ff", builtin.find_files, opts)

    vim.keymap.set("n", "<leader>fl", ":Telescope git_files<CR>", opts)

    opts.desc =
      "Search for a string in your current working directory and get results live as you type, respects .gitignore"
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, opts)

    opts.desc = "Lists open buffers in current neovim instance"
    vim.keymap.set("n", "<leader>fb", builtin.buffers, opts)

    opts.desc = "Lists available help tags and opens a new window with the relevant help info on <cr>"
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, opts)

    opts.desc = "Lists LSP document symbols in the current buffer"
    vim.keymap.set("n", "<leader>od", builtin.lsp_document_symbols, opts)

    opts.desc = "Lists LSP document symbols in the current workspace"
    vim.keymap.set("n", "<leader>ow", builtin.lsp_dynamic_workspace_symbols, opts)
  end,
}
