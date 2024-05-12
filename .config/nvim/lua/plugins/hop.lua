return {
  'phaazon/hop.nvim',
  branch = 'v2',
  config = function()
    local hop = require('hop')

    hop.setup({ keys = 'etovxqpdygfblzhckisuran' })

    -- Changing the default f keyword
    vim.api.nvim_set_keymap('', 'f', "<cmd>lua require'hop'.hint_char1()<cr>", {})

    -- Pattern Matching with t keyword
    vim.api.nvim_set_keymap('n', 't', "<cmd>HopPattern<CR>", {noremap = true})
  end
}
