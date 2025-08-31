-- Set leader key to space
vim.g.mapleader = ' '

local map = vim.keymap.set

-- For conciseness
local opts = { noremap = true, silent = true }

-- General keymaps
map('i', 'jk', '<ESC>') -- exit insert mode with jk
map('n', 'gu', ':!open <c-r><c-a><CR>') -- open URL under cursor
map('n', '<Esc>', '<cmd>nohlsearch<CR>') -- Clear highlights on search when pressing <ESC> in normal mode.
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
map('n', '<space><space>x', '<cmd>source %<CR>')
map('n', '<space>x', ':.lua<CR>')
map('v', '<space>x', ':lua<CR>')

-- better up/down
map({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
map({ 'n', 'x' }, '<Down>', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down', expr = true, silent = true })
map({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })
map({ 'n', 'x' }, '<Up>', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up', expr = true, silent = true })
map('n', '<C-u>', '<C-u>zz', { desc = 'Half page up', silent = true, noremap = true })
map('n', '<C-d>', '<C-d>zz', { desc = 'Half page down', silent = true, noremap = true })

-- Find and center
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')

-- Move to buffers using the <shift> hjkl keys
map('n', '<S-h>', '[b', { desc = 'Go to Left buffer', remap = true })
map('n', '<S-l>', ']b', { desc = 'Go to Right buffer', remap = true })

-- Resize windows using <ctrl> with arrow keys
map('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Increase Window Height' })
map('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease Window Height' })
map('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease Window Width' })
map('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase Window Width' })

-- Toggle line wrapping
map('n', '<leader>lw', '<cmd>set wrap!<CR>', opts)

-- Stay in indent mode
map('v', '<', '<gv', opts)
map('v', '>', '>gv', opts)

-- Move text up and down
map('v', '<A-j>', ':m .+1<CR>==', opts)
map('v', '<A-k>', ':m .-2<CR>==', opts)

-- Keep last yanked when pasting
map('v', 'p', '"_dP', opts)

-- Split window management
map('n', '<leader>sv', '<C-w>v') -- split window vertically
map('n', '<leader>sh', '<C-w>s') -- split window horizontally
map('n', '<leader>sx', ':close<CR>') -- close split window

-- Tab management
map('n', '<leader>to', ':tabnew<CR>') -- open a new tab
map('n', '<leader>tx', ':tabclose<CR>') -- close a tab
map('n', '<leader>tn', ':tabNext<CR>') -- next tab
map('n', '<leader>tp', ':tabprevious<CR>') -- previous tab

-- Nvim-tree
map('n', '<leader>ee', ':NvimTreeToggle<CR>') -- toggle file explorer
map('n', '<leader>er', ':NvimTreeFocus<CR>') -- toggle focus to file explorer
map('n', '<leader>ef', ':NvimTreeFindFile<CR>') -- find file in file explorer

-- todo comments
map('n', ']t', function()
  require('todo-comments').jump_next()
end, { desc = 'Next todo comment' })
map('n', '[t', function()
  require('todo-comments').jump_prev()
end, { desc = 'Previous todo comment' })

-- lazy and quickfix
map('n', '<leader>l', '<cmd>Lazy<cr>', { desc = 'Lazy' })

map('n', '[q', vim.cmd.cprev, { desc = 'Previous Quickfix' })
map('n', ']q', vim.cmd.cnext, { desc = 'Next Quickfix' })

-- Diagnostic keymaps
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go { severity = severity }
  end
end

map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
map('n', '<leader>cd', vim.diagnostic.open_float, { desc = 'Line Diagnostics' })
map('n', ']d', diagnostic_goto(true), { desc = 'Next Diagnostic' })
map('n', '[d', diagnostic_goto(false), { desc = 'Prev Diagnostic' })
map('n', ']e', diagnostic_goto(true, 'ERROR'), { desc = 'Next Error' })
map('n', '[e', diagnostic_goto(false, 'ERROR'), { desc = 'Prev Error' })
map('n', ']w', diagnostic_goto(true, 'WARN'), { desc = 'Next Warning' })
map('n', '[w', diagnostic_goto(false, 'WARN'), { desc = 'Prev Warning' })

--undotree
map('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = 'UndotreeToggle' })

-- Git
vim.api.nvim_set_keymap('n', '<leader>gcc', ':Git commit<CR>', { noremap = false })
vim.api.nvim_set_keymap('n', '<leader>ga', ':Git add', { noremap = false })
vim.api.nvim_set_keymap('n', '<leader>gp', ':Git push -u origin HEAD<CR>', { noremap = false })
vim.api.nvim_set_keymap('n', '<leader>gst', ':Git status<CR>', { noremap = false })
vim.api.nvim_set_keymap('n', '<leader>gl', ':Git log --decorate --graph --oneline<CR>', { noremap = false })
