return {
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      -- local highlights = require("nord").bufferline.highlights({
      --   italic = true,
      --   bold = true,
      --   fill = "#181c24",
      -- })

      require("bufferline").setup({
        options = {
          separator_style = "slant",
          hover = {
            enabled = true,
            reveal = { "close" },
          },
        },
      })
    end,
  },
}
