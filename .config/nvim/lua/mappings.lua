require "nvchad.mappings"

-- Delete default key mappings
vim.keymap.del("n", "<leader>h", { desc = "terminal new horizontal term" })
vim.keymap.del("n", "<leader>v", { desc = "terminal new vertical term" })

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "<leader>q", "<cmd> q <cr>", { desc = "close the current window" })

-- Line
map("n", "<A-k>", ":m .-2<cr>==", { desc = "move current line up" }) -- Alt-k
map("n", "<A-j>", ":m .+1<cr>==", { desc = "move current line down" }) -- Alt-j
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "move line up (v)" }) -- Alt-k (v)
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "move line down (v)" }) -- Alt-j (v)

-- Map Ctrl+S to save the file on all modes
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Indentation
map("v", "<", "<gv", { desc = "Indent left" }) -- Right Indentation
map("v", ">", ">gv", { desc = "Indent right" }) -- Left Indentation

-- Some LSP telescope mappings
map(
  "n",
  "<leader>lds",
  "<cmd>lua require('telescope.builtin').lsp_document_symbols() <cr>",
  { desc = "list all document symbols of the current buffer" }
)

map(
  "n",
  "<leader>lws",
  "<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols() <cr>",
  { desc = "list all document symbols of the current workspace" }
)

require "configs.git"
require "configs.term"
