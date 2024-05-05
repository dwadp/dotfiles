return {
  'mrcjkb/rustaceanvim',
  version = '^4', -- Recommended
  lazy = false, -- This plugin is already lazy
  config = function()
    local bufnr = vim.api.nvim_get_current_buf()
    vim.keymap.set("n", "<leader>a", function()
        vim.cmd.RustLsp('codeAction') -- supports rust-analyzer's grouping
        -- or vim.lsp.buf.codeAction() if you don't want grouping.
      end,
      { desc = "Open code action grouped by rust-analyzer", silent = true, buffer = bufnr }
    )
  end
}
