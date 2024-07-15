return {
  "neanias/everforest-nvim",
  version = false,
  lazy = false,
  priority = 1000, -- make sure to load this before all the other start plugins
  -- Optional; default configuration will be used if setup isn't called.
  config = function()
    require("everforest").setup({})

    vim.cmd.colorscheme("everforest")
  end,
}

-- return {
--   "oxfist/night-owl.nvim",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     -- load the colorscheme here
--     require("night-owl").setup()
--     vim.cmd.colorscheme("night-owl")
--   end,
-- }


--  Configuration for tokyonight theme
-- return {
--   "folke/tokyonight.nvim",
--   lazy = false,
--   priority = 1000,
--   opts = {},
--   config = function()
--     vim.cmd.colorscheme "tokyonight-night"
--   end
-- }


-- Configuration for github dark theme
-- return {
--   'projekt0n/github-nvim-theme',
--   lazy = false,
--   priority = 1000,
--   config = function()
--     require('github-theme').setup({
--       -- ...
--     })
--
--     vim.cmd.colorscheme "github_dark_dimmed"
--   end,
-- }


-- Configuration for catppuccin colorscheme
-- return {
--   {
--     "catppuccin/nvim",
--     name = "catppuccin",
--     priority = 1000,
--     config = function()
--       require("catppuccin").setup({
--         flavour = "mocha", -- latte, frappe, macchiato, mocha
--         background = {
--           light = "latte",
--           dark = "mocha",
--         },
--         transparent_background = true,
--         integrations = {
--           cmp = true,
--           nvimtree = true,
--           treesitter = true,
--         }
--       })
--
--       vim.cmd.colorscheme "catppuccin"
--     end
--   }
-- }
