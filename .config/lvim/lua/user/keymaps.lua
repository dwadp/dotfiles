lvim.leader = "space"

-- Remap the default keybindings for switching between buffers
lvim.builtin.which_key.mappings["bn"] = {}
lvim.builtin.which_key.mappings["bb"] = {}

lvim.keys.normal_mode["<S-l>"] = "<cmd>BufferLineCycleNext<cr>"
lvim.keys.normal_mode["<S-h>"] = "<cmd>BufferLineCyclePrev<cr>"

lvim.builtin.which_key.mappings["bq"] = { "<cmd>BufferKill<cr>", "Close" }

local telescope_ok, _ = pcall(require, "telescope")

if telescope_ok then
  local builtin = require("telescope.builtin")

  -- Remove the default binding "<leader>f" to open files and remap it with "<leader>ff" instead
  lvim.builtin.which_key.mappings["f"] = {}
  lvim.builtin.which_key.mappings["ff"] = { builtin.find_files, "Find files" }

  lvim.builtin.which_key.mappings["fb"] = { builtin.buffers, "Open buffers in current neovim instance" }
end

local cmp = require("lvim.utils.modules").require_on_index "cmp"
local luasnip = require("lvim.utils.modules").require_on_index "luasnip"
local cmp_mapping = require("cmp.config.mapping")

-- Modify the default completion keybinding
lvim.builtin.cmp.mapping["<Tab>"] = cmp_mapping(function(fallback)
  local copilot_keys = vim.fn["copilot#Accept"]("")

  -- Prioritize the copilot suggestion over the default completion
  if copilot_keys ~= "" then
    vim.api.nvim_feedkeys(copilot_keys, "i", false)
  elseif cmp.visible() then
    cmp.select_next_item()
  elseif luasnip.expand_or_locally_jumpable() then
    luasnip.expand_or_jump()
  elseif lvim.builtin.cmp.methods.jumpable(1) then
    luasnip.jump(1)
  elseif lvim.builtin.cmp.methods.has_words_before() then
    -- cmp.complete()
    fallback()
  else
    fallback()
  end
end, { "i", "s" })
