return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        background = {
          light = "latte",
          dark = "mocha",
        },
        transparent_background = true,
        integrations = {
          cmp = true,
          nvimtree = true,
          treesitter = true,
        }
      })

      vim.cmd.colorscheme "catppuccin"
    end
  }
}
