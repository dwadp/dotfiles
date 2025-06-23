function _G.set_terminal_keymaps()
  local opts = { noremap = true }
  vim.api.nvim_set_keymap("t", "<ESC>", [[<C-\><C-n>]], opts)
  vim.api.nvim_set_keymap("t", "<C-d>", [[<C-\><C-d>]], opts)
end

vim.cmd "autocmd! TermOpen term://* lua set_terminal_keymaps()"
