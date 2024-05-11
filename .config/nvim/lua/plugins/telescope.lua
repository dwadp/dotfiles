return {
  'nvim-telescope/telescope.nvim', tag = '0.1.6',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('telescope').setup({
      defaults = {
        mappings = {
          i = {
            ["<C-h>"] = "which_key",
          }
        }
      },
      pickers = {
        find_files = {
          theme = "dropdown",
          hidden = true,
          ignore = false,
        }
      },
      extensions = {
        --
      }
    })

    local builtin = require('telescope.builtin')
    local opts = { noremap = true }

    opts.desc = "Lists files in your current working directory, respects .gitignore"
    vim.keymap.set('n', '<leader>ff', builtin.find_files, opts)

    opts.desc = "Search for a string in your current working directory and get results live as you type, respects .gitignore"
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, opts)

    opts.desc = "Lists open buffers in current neovim instance"
    vim.keymap.set('n', '<leader>fb', builtin.buffers, opts)


    opts.desc = "Lists available help tags and opens a new window with the relevant help info on <cr>"
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, opts)

    opts.desc = "Lists LSP document symbols in the current buffer"
    vim.keymap.set('n', '<leader>od', builtin.lsp_document_symbols, opts)

    opts.desc = "Lists LSP document symbols in the current workspace"
    vim.keymap.set('n', '<leader>ow', builtin.lsp_dynamic_workspace_symbols, opts)
  end
}
