-- return {
--   "shaunsingh/nord.nvim",
--   config = function()
--     vim.g.nord_contrast = true
--     vim.g.nord_borders = true
--     vim.g.nord_disable_background = false
--     vim.g.nord_enable_sidebar_background = false
--     vim.g.nord_italic = true
--     vim.g.nord_uniform_diff_background = false
--     vim.g.nord_bold = false
--
--     require("nord").set()
--   end,
-- }

return {
  "oxfist/night-owl.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    local night_owl = require("night-owl")

    night_owl.setup({
      bold = true,
      italics = true,
      underline = true,
      undercurl = true,
      transparent_background = false,
    })

    vim.cmd.colorscheme("night-owl")
  end,
}
