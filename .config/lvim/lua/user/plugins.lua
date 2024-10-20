lvim.plugins = {
  {
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
    end,
  },

  { "github/copilot.vim" },
  -- {
  --   "zbirenbaum/copilot.lua",
  --   cmd = "Copilot",
  --   event = "InsertEnter",
  --   config = function()
  --     require("copilot").setup({})
  --   end,
  -- },

  -- {
  --   "zbirenbaum/copilot-cmp",
  --   config = function()
  --     require("copilot_cmp").setup({
  --       suggestion = { enabled = false },
  --       panel = { enabled = false }
  --     })
  --   end
  -- },

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  }
}
