-- Set leader key to space
vim.g.mapleader = ' '

local keymap = vim.keymap

-- For conciseness
local opts = { noremap = true, silent = true }

-- General keymaps
keymap.set('i', 'jk', '<ESC>') -- exit insert mode with jk
keymap.set('n', 'gu', ':!open <c-r><c-a><CR>') -- open URL under cursor
keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>') -- Clear highlights on search when pressing <ESC> in normal mode.
keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
keymap.set('n', '<space><space>x', '<cmd>source %<CR>')
keymap.set('n', '<space>x', ':.lua<CR>')
keymap.set('v', '<space>x', ':lua<CR>')

-- Allow moving the cursor through wrapped lines with j, k
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- Vertical scroll and center
vim.keymap.set('n', '<C-d>', '<C-d>zz', opts)
vim.keymap.set('n', '<C-u>', '<C-u>zz', opts)

-- Find and center
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Resize with arrows
vim.keymap.set('n', '<Up>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<Down>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<Left>', ':vertical resize -2<CR>', opts)
vim.keymap.set('n', '<Right>', ':vertical resize +2<CR>', opts)

-- Increment/decrement numbers
vim.keymap.set('n', '<leader>+', '<C-a>', opts) -- increment
vim.keymap.set('n', '<leader>-', '<C-x>', opts) -- decrement

-- Toggle line wrapping
vim.keymap.set('n', '<leader>lw', '<cmd>set wrap!<CR>', opts)

-- Stay in indent mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- Move text up and down
vim.keymap.set('v', '<A-j>', ':m .+1<CR>==', opts)
vim.keymap.set('v', '<A-k>', ':m .-2<CR>==', opts)

-- Keep last yanked when pasting
vim.keymap.set('v', 'p', '"_dP', opts)

-- Split window management
keymap.set('n', '<leader>sv', '<C-w>v') -- split window vertically
keymap.set('n', '<leader>sh', '<C-w>s') -- split window horizontally
keymap.set('n', '<leader>se', '<C-w>=') -- make split windows equal width
keymap.set('n', '<leader>sx', ':close<CR>') -- close split window
keymap.set('n', '<leader>sj', '<C-w>-') -- make split window height shorter
keymap.set('n', '<leader>sk', '<C-w>+') -- make split windows height taller
keymap.set('n', '<leader>sl', '<C-w>>5') -- make split windows width bigger
keymap.set('n', '<leader>sh', '<C-w><5') -- make split windows width smaller

-- Tab management
keymap.set('n', '<leader>to', ':tabnew<CR>') -- open a new tab
keymap.set('n', '<leader>tx', ':tabclose<CR>') -- close a tab
keymap.set('n', '<leader>tn', ':tabn<CR>') -- next tab
keymap.set('n', '<leader>tp', ':tabp<CR>') -- previous tab

-- Nvim-tree
keymap.set('n', '<leader>ee', ':NvimTreeToggle<CR>') -- toggle file explorer
keymap.set('n', '<leader>er', ':NvimTreeFocus<CR>') -- toggle focus to file explorer
keymap.set('n', '<leader>ef', ':NvimTreeFindFile<CR>') -- find file in file explorer

-- todo comments
keymap.set('n', ']t', function()
  require('todo-comments').jump_next()
end, { desc = 'Next todo comment' })
keymap.set('n', '[t', function()
  require('todo-comments').jump_prev()
end, { desc = 'Previous todo comment' })

-- Diagnostic keymaps
keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Open floating [D]iagnostic messages' })
keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

--undotree
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = 'UndotreeToggle' })

-- Git
vim.api.nvim_set_keymap('n', '<leader>gcc', ':Git commit<CR>', { noremap = false })
vim.api.nvim_set_keymap('n', '<leader>ga', ':Git add', { noremap = false })
vim.api.nvim_set_keymap('n', '<leader>gp', ':Git push -u origin HEAD<CR>', { noremap = false })
vim.api.nvim_set_keymap('n', '<leader>gst', ':Git status<CR>', { noremap = false })
vim.api.nvim_set_keymap('n', '<leader>gl', ':Git log --decorate --graph --oneline<CR>', { noremap = false })
