return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  opts = {
    ensure_installed = {
      "hadolint",
      "eslint_d",
      "php-debug-adapter",
      "phpstan",
      "pint",
      "blade-formatter",
    },
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")

    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconfig.setup({
      ensure_installed = { -- See: https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers for more information
        "lua_ls",
        "ast_grep",
        "gopls",
        "golangci_lint_ls",
        "tsserver",
        "emmet_ls",
        "yamlls",
        "dockerls",
        "docker_compose_language_service",
        "jsonls",
        "sqls",
        "taplo",
        "intelephense",
      },
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "golangci-lint",
        "bash-language-server",
        "lua-language-server",
        "vim-language-server",
        "gopls",
        "stylua",
        "shellcheck",
        "editorconfig-checker",
        "gofumpt",
        "golines",
        "gomodifytags",
        "gotests",
        "revive",
        "shellcheck",
        "shfmt",
        "zls",
      },
      auto_update = true,
      run_on_start = true,
      start_delay = 3000,
      debounce_hours = 5,
    })
  end,
}
