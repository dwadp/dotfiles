lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
  "go",
  "zig"
}

lvim.lsp.installer.setup.ensure_installed = {
  "yamlls",
  "jsonls",
  "gopls",
  "zls",
  "sqls"
}

require("lvim.lsp.manager").setup("zls", {
  cmd = "/usr/local/bin/zls"
})

require("lvim.lsp.manager").setup("gopls", {})
