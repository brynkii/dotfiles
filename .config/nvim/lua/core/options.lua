-- -------- GENERAL --------
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.termguicolors = true -- True color support
vim.opt.hidden = true -- Allow hidden buffers
vim.opt.autoread = true -- Auto-read external changes
vim.opt.timeoutlen = 300 -- Faster key sequences
vim.opt.ttimeoutlen = 10 -- Faster terminal key sequences
-- -------- BACKUP & SWAP --------
vim.opt.backup = false -- Enable backup files
vim.opt.swapfile = true -- Enable swap files
vim.opt.undofile = true -- Enable persistent undo
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"
-- -------- EDITING BEHAVIOR --------
vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.whichwrap = "b,s,h,l,<,>,[,]" -- Allow cursor wrapping
vim.opt.mouse = "a" -- Enable mouse everywhere
vim.opt.mousemodel = "popup" -- Better mouse behavior
vim.opt.mousehide = true -- Hide mouse while typing
-- -------- SEARCH --------
vim.opt.ignorecase = true -- Case insensitive search
vim.opt.smartcase = true -- Case sensitive if uppercase
vim.opt.incsearch = true -- Incremental search
vim.opt.hlsearch = true -- Highlight search
vim.opt.wildignorecase = true -- Case insensitive completion
-- -------- DISPLAY --------
vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.cursorline = true -- Highlight current line
vim.opt.showcmd = true -- Show partial commands
vim.opt.showmode = true -- Show current mode
vim.opt.showmatch = true -- Show matching brackets
vim.opt.matchtime = 2 -- Match time in tenths of second
vim.opt.scrolloff = 8 -- Lines above/below cursor
vim.opt.sidescrolloff = 8 -- Columns left/right cursor
vim.opt.signcolumn = "yes" -- Always show sign column
vim.opt.cmdheight = 1 -- Command line height
vim.opt.laststatus = 3 -- Global statusline (neovim 0.10+)
vim.opt.winbar = "%=%m %f" -- Simple winbar
vim.opt.fillchars = {
	eob = " ", -- No ~ at end of buffer
	fold = " ",
	foldopen = "▾",
	foldclose = "▸",
	foldsep = " ",
	diff = "╱",
	msgsep = "‾",
	horiz = "─",
	horizup = "┴",
	horizdown = "┬",
	vert = "│",
	vertleft = "┤",
	vertright = "├",
	verthoriz = "┼",
}
-- -------- WINDOW SPLITS --------
vim.opt.splitbelow = true -- Open splits below
vim.opt.splitright = true -- Open splits to the right
vim.opt.equalalways = false -- Don't equalize window sizes
-- -------- TABS & INDENT --------
vim.opt.expandtab = true -- Use spaces for tabs
vim.opt.shiftwidth = 2 -- Indent width
vim.opt.tabstop = 2 -- Tab width
vim.opt.softtabstop = 2 -- Soft tab width
vim.opt.smartindent = true -- Smart auto-indent
vim.opt.autoindent = true -- Auto indent
vim.opt.wrap = false -- Disable line wrapping
vim.opt.linebreak = true -- Break at word boundaries
vim.opt.breakindent = true -- Preserve indent when wrapping
-- -------- COMPLETION --------
vim.opt.completeopt = { "menuone", "noinsert", "noselect", "popup" }
vim.opt.wildmenu = true -- Show completion menu
vim.opt.wildmode = "list:longest,full" -- Completion mode
vim.opt.wildoptions = { "pum" } -- Use popup menu
-- -------- FOLDING --------
vim.opt.foldmethod = "expr" -- Expression based folding
vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- Treesitter folding
vim.opt.foldlevel = 99 -- Start unfolded
vim.opt.foldenable = true -- Enable folding
-- -------- MISC --------
vim.opt.conceallevel = 0 -- Don't conceal text
vim.opt.helplang = "en" -- Help language
vim.opt.history = 1000 -- Command history
vim.opt.modelines = 0 -- Disable modelines (security)
vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
vim.opt.shortmess = {
	a = true, -- All shortened
	I = false, -- Show intro
	W = false, -- Show warnings
	c = true, -- Notify completion
	q = true, -- Quiet mode
	s = true, -- Search message
	t = true, -- Truncate file messages
	o = true, -- Overwrite read-only
	T = true, -- Truncate messages
}
vim.opt.updatetime = 100 -- Faster CursorHold
vim.opt.redrawtime = 1000 -- Redraw timeout
-- -------- BORDERS --------
vim.opt.winborder = "rounded" -- Rounded floating windows (0.12+)
-- -------- AUTOCOMMANDS --------
local augroup = vim.api.nvim_create_augroup("OptionsGroup", { clear = true })
-- Resize splits on window resize
vim.api.nvim_create_autocmd("VimResized", {
	group = augroup,
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})
-- Save cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup,
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})
-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup,
	callback = function()
		vim.hl.hl_op({ higroup = "IncSearch", timeout = 200 })
	end,
})
-- Disable line numbers in terminal
vim.api.nvim_create_autocmd("TermOpen", {
	group = augroup,
	callback = function()
		vim.wo.number = false
		vim.wo.relativenumber = false
		vim.wo.signcolumn = "no"
	end,
})
-- Auto-resize splits when opening help
vim.api.nvim_create_autocmd("BufWinEnter", {
	pattern = "*.txt",
	group = augroup,
	callback = function()
		if vim.bo.filetype == "help" then
			vim.cmd("wincmd _")
			vim.cmd("wincmd |")
		end
	end,
})
-- -------- ENVIRONMENT VARIABLES --------
-- XDG compliance
vim.env.XDG_CONFIG_HOME = vim.fn.expand("~/.config")
vim.env.XDG_DATA_HOME = vim.fn.expand("~/.local/share")
vim.env.XDG_CACHE_HOME = vim.fn.expand("~/.cache")
-- Language
vim.env.LANG = "en_US.UTF-8"
vim.env.LC_ALL = "en_US.UTF-8"
-- Editor
vim.env.EDITOR = "nvim"
vim.env.VISUAL = "nvim"
vim.env.GIT_EDITOR = "nvim"
-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = "unnamedplus"
