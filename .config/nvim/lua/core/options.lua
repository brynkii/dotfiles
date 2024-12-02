-- Set to true if you have a nerd font installed and selected in the terminal
vim.g.have_nerd_font = true
-- Set highlight on search
vim.opt.hlsearch = false

-- Make line numbers default
vim.wo.number = true
vim.opt.relativenumber = true

-- Enable mouse mode
vim.opt.mouse = 'a'

-- Don't show the mode, since it is already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = true

-- Copy indent from current line when starting a new one.
vim.o.autoindent = true

-- Encoding written to a file
vim.o.fileencoding = 'utf-8'

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
vim.opt.expandtab = true --use spaces instead of Tabs
vim.opt.smartindent = true
vim.bo.softtabstop = 2

-- Splits
vim.opt.splitbelow = true
vim.opt.splitright = true
-- Line wrapping
vim.opt.wrap = false
vim.o.linebreak = true --companion to wrap, don't split words

-- Backspace
vim.opt.backspace = 'indent,eol,start'

-- Enable cursor  line highlight
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- see fold settings
vim.opt.foldcolumn = '0'
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
vim.opt.fillchars = { foldopen = '', foldclose = '>', diff = '╱' }

-- Set completeopt to have a better completion experience
vim.opt.completeopt = 'menu,menuone,noselect'

if vim.fn.has 'nvim-0.10' == 1 then
  vim.opt.smoothscroll = true
  vim.opt.foldexpr = "v:lua.require'lazyvim.util'.ui.foldexpr()"
  vim.opt.foldmethod = 'expr'
  vim.opt.foldtext = ''
else
  vim.opt.foldmethod = 'indent'
  vim.opt.foldtext = "v:lua.require'lazyvim.util'.ui.foldtext()"
end
Ui = {
  -- If you are using a Nerd Font: set icons to an empty table which will use the
  -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
  icons = vim.g.have_nerd_font and {} or {
    cmd = '⌘',
    config = '🛠',
    event = '📅',
    ft = '📂',
    init = '⚙',
    keys = '🗝',
    plugin = '🔌',
    runtime = '💻',
    require = '🌙',
    source = '📄',
    start = '🚀',
    task = '📌',
    lazy = '💤 ',
  },
}
