return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
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
        "html",
        "gopls",
        "golangci_lint_ls",
        "tsserver",
        "emmet_ls",
        "yamlls",
        "dockerls", -- for docker file
        "docker_compose_language_service", -- for docker compose file,
        "eslint",
        "jsonls",
        "sqls",
        "taplo", -- TOML language
      },
    })

    mason_tool_installer.setup({
      ensure_installed = {
        { "golangci-lint", version = "v1.47.0" },
        { "bash-language-server", auto_update = true },
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
        "json-to-struct",
        "luacheck",
        "revive",
        "shellcheck",
        "shfmt",
      },

      -- if set to true this will check each tool for updates. If updates
      -- are available the tool will be updated. This setting does not
      -- affect :MasonToolsUpdate or :MasonToolsInstall.
      -- Default: false
      auto_update = true,

      -- automatically install / update on startup. If set to false nothing
      -- will happen on startup. You can use :MasonToolsInstall or
      -- :MasonToolsUpdate to install tools and check for updates.
      -- Default: true
      run_on_start = true,

      -- set a delay (in ms) before the installation starts. This is only
      -- effective if run_on_start is set to true.
      -- e.g.: 5000 = 5 second delay, 10000 = 10 second delay, etc...
      -- Default: 0
      start_delay = 3000, -- 3 second delay

      -- Only attempt to install if 'debounce_hours' number of hours has
      -- elapsed since the last time Neovim was started. This stores a
      -- timestamp in a file named stdpath('data')/mason-tool-installer-debounce.
      -- This is only relevant when you are using 'run_on_start'. It has no
      -- effect when running manually via ':MasonToolsInstall' etc....
      -- Default: nil
      debounce_hours = 5, -- at least 5 hours between attempts to install/update
    })
  end,
}
