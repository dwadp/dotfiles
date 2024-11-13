return {
  'echasnovski/mini.bufremove',
  version = '*',
  config = function()
    local bufremove = require('mini.bufremove')

    bufremove.setup()

    vim.keymap.set('n', "<leader>bd", function()
      if vim.bo.modified then
        local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
        if choice == 1 then -- Yes
          vim.cmd.write()
          bufremove.delete(0)
        elseif choice == 2 then -- No
          bufremove.delete(0, true)
        end
      else
        bufremove.delete(0)
      end
    end, { noremap = true, desc = 'Close the current buffer'})
  end
}
