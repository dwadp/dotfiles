-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local util = require "lspconfig.util"

-- EXAMPLE
local servers = {
  "html",
  "cssls",
  "gopls",
  "rust_analyzer",
  "zls",
  "emmet_ls",
  "yamlls",
  "intelephense",
  "sqls",
  "taplo",
  "ansiblels",
  "bashls",
  "cmake",
  "dockerls",
  "jsonls",
  "pylsp",
  "ts_ls",
}
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- lspconfig.biome.setup {
--   cmd = { "biome", "lsp-proxy" },
--   filetypes = { "javascript", "typescript" },
--   root_dir = util.root_pattern("biome.json", "biome.jsonc", "package.json", "package-lock.json"),
--   single_file_support = false,
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }

lspconfig.zls.setup {
  cmd = { "/home/dwadp/.local/bin/zls" },
  filetypes = { "zig" },
  root_dir = util.root_pattern("build.zig", ".git"),
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
}

-- configuring single server, example: typescript
lspconfig.ts_ls.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
}
