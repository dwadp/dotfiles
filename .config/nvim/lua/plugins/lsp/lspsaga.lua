return {
  "nvimdev/lspsaga.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter", -- optional
    "nvim-tree/nvim-web-devicons", -- optional
  },
  config = function()
    local lspsaga = require("lspsaga")
    local keymap = vim.api.nvim_set_keymap

    lspsaga.setup({})

    local opts = { noremap = true, silent = true }

    keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
    keymap("n", "<leader>ca", ":Lspsaga code_action<CR>", opts)
    keymap("n", "<leader>D", "<cmd>Lspsaga show_buf_diagnostics ++float<CR>", opts)
    keymap("n", "<leader>d", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
    keymap("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)

    vim.keymap.set("n", "<leader>ne", function()
      require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
    end, opts)

    vim.keymap.set("n", "<leader>pe", function()
      require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
    end, opts)

    local group = vim.api.nvim_create_augroup("Line Diagnostics", { clear = true })

    vim.api.nvim_create_autocmd("CursorHold", {
      command = "Lspsaga show_line_diagnostics",
      group = group,
    })
  end,
}
