local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    go = { "goimports" },
    rust = { "rustfmt" },
    sql = { "sql-formatter" },
    toml = { "prettier" },
    yaml = { "prettier" },
    css = { "prettier" },
    json = { "prettier" },
    html = { "prettier" },
    js = { "biome" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },

  formatters = {
    zig = {
      function()
        return {
          exe = "zig",
          args = { "fmt", "--stdin" },
          stdin = true,
          cwd = require("conform.util").root_file { "build.zig" },
          require_cwd = true,
        }
      end,
    },
  },
}

return options
