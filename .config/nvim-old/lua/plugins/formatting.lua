return {
  "stevearc/conform.nvim",
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        toml = { "prettier" },
        go = { "goimports", "gofmt" },
        sql = { "sqlfmt" },
        yaml = { "yamlfix" },
        zig = { "zig fmt" },
      },
      format_on_save = {
        timeout_ms = 500,
        async = false,
        lsp_fallback = true,
      },
    })

    vim.keymap.set("n", "<leader>mp", function()
      conform.format({
        timeout_ms = 500,
        async = false,
        lsp_fallback = true,
      })
    end, { desc = "Format file or range (in visual mode)" })
  end,
}
