return {
  "ThePrimeagen/harpoon",
  config = function()
    require("harpoon").setup({
      menu = {
        width = 100,
      },
    })

    vim.keymap.set("n", "<leader>mm", ':lua require("harpoon.mark").add_file()<CR>')
    vim.keymap.set("n", "<leader>mr", ':lua require("harpoon.mark").rm_file()<CR>')
    vim.keymap.set("n", "<leader>mc", ':lua require("harpoon.mark").clear_all()<CR>')
    vim.keymap.set("n", "<leader>mf", ':lua require("harpoon.ui").toggle_quick_menu()<CR>')

    vim.keymap.set("n", "<leader>ml", ':lua require("harpoon.ui").nav_next()<CR>')
    vim.keymap.set("n", "<leader>mh", ':lua require("harpoon.ui").nav_prev()<CR>')

    vim.keymap.set("n", "<leader>fm", ":Telescope harpoon marks<CR>")
  end,
}
