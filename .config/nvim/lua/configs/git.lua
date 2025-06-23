local map = vim.keymap.set
local gitsigns = require "gitsigns"

map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage hunk (line)" })
map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Unstage hunk (line)" })
map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage buffer (file)" })
map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Unstage buffer (file)" })
map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview hunk (line) " })
map("n", "<leader>hd", gitsigns.diffthis, { desc = "Show diff for the current file" })
map("n", "<leader>hD", function()
  gitsigns.diffthis "~"
end)
map("n", "<leader>td", gitsigns.toggle_deleted)
