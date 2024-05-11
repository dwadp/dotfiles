local opt = vim.opt

opt.autowrite = true
opt.clipboard = "unnamedplus"
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 3
opt.confirm = true
opt.cursorline = true -- Enable highlighting of the current line
opt.expandtab = true
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true
opt.incsearch = true
opt.laststatus = 0
opt.list = true
opt.mouse = "a" -- Enable mouse mode
opt.number = true
opt.relativenumber = true
opt.scrolloff = 5
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
opt.shiftround = true
opt.shiftwidth = 4
opt.shortmess:append { W = true, I = true, c = true }
opt.smartcase = true
opt.smartindent = true
opt.spelllang = { "en" }
opt.tabstop = 4
opt.termguicolors = false
opt.timeoutlen = 500
opt.undofile = true
opt.undolevels = 10000
opt.wrap = false -- Disable line wrap

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0
vim.o.termguicolors = false   
