-- Set highlight on search
vim.opt.hlsearch = false

-- Make line numbers default
vim.wo.number = true
vim.opt.relativenumber = true

-- Enable mouse mode
vim.opt.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
 vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Tabs and indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.bo.softtabstop = 2

-- Line wrapping
vim.opt.wrap = false

-- Backspace
vim.opt.backspace = "indent,eol,start"

-- Enable cursor  line highlight
vim.opt.cursorline = true

-- other settings
vim.opt.scrolloff = 8

-- see fold settings
vim.opt.foldcolumn = "0"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

-- Enable incremental searching
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- Gui colots NOTE:  Make sure your terminal supports this
vim.opt.termguicolors = true

--Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

--sets how neovim will desplay certainwhitespce in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
