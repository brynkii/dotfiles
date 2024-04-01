-- Set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap

-- General keymaps
keymap.set("i", "jk", "<ESC>") -- exit insert mode with jk
keymap.set("n", "gu", ":!open <c-r><c-a><CR>") -- open URL under cursor
keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Split window management
keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width
keymap.set("n", "<leader>sx", ":close<CR>") -- close split window
keymap.set("n", "<leader>sj", "<C-w>-") -- make split window height shorter
keymap.set("n", "<leader>sk", "<C-w>+") -- make split windows height taller
keymap.set("n", "<leader>sl", "<C-w>>5") -- make split windows width bigger
keymap.set("n", "<leader>sh", "<C-w><5") -- make split windows width smaller

-- Tab management
keymap.set("n", "<leader>to", ":tabnew<CR>") -- open a new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close a tab
keymap.set("n", "<leader>tn", ":tabn<CR>") -- next tab
keymap.set("n", "<leader>tp", ":tabp<CR>") -- previous tab

-- Nvim-tree
keymap.set("n", "<leader>ee", ":NvimTreeToggle<CR>") -- toggle file explorer
keymap.set("n", "<leader>er", ":NvimTreeFocus<CR>") -- toggle focus to file explorer
keymap.set("n", "<leader>ef", ":NvimTreeFindFile<CR>") -- find file in file explorer

--- harpoon
local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

keymap.set("n", "<leader>ha", function()
	harpoon:list():append()
end)
keymap.set("n", "<leader>ho", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end)
keymap.set("n", "<leader>h1", function()
	harpoon:list():select(1)
end)
keymap.set("n", "<leader>h2", function()
	harpoon:list():select(2)
end)
keymap.set("n", "<leader>h3", function()
	harpoon:list():select(3)
end)
keymap.set("n", "<leader>h4", function()
	harpoon:list():select(4)
end)
keymap.set("n", "<leader>h4", function()
	harpoon:list():select(5)
end)
keymap.set("n", "<leader>hp", function()
	harpoon:list():prev()
end)
keymap.set("n", "<leader>hn", function()
	harpoon:list():next()
end)

-- trouble
keymap.set("n", "<leader>tt", function()
	require("trouble").toggle()
end)
keymap.set("n", "[t", function()
	require("trouble").next({ skip_groups = true, jump = true })
end)
keymap.set("n", "]t", function()
	require("trouble").previous({ skip_groups = true, jump = true })
end)

-- todo comments
keymap.set("n", "]T", function()
	require("todo-comments").jump_next()
end, { desc = "Next todo comment" })
keymap.set("n", "[T", function()
	require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

-- Diagnostic keymaps
keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
keymap.set("n", "<leader>ea", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

--undotree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "UndotreeToggle" })

--Git
-- Git
vim.api.nvim_set_keymap("n", "<leader>gc", ":Git commit<CR>", { noremap = false })
vim.api.nvim_set_keymap("n", "<leader>ga", ":Git add", { noremap = false })
vim.api.nvim_set_keymap("n", "<leader>gp", ":Git push -u origin HEAD<CR>", { noremap = false })
vim.api.nvim_set_keymap("n", "<leader>gs", ":Git status<CR>", { noremap = false })
vim.api.nvim_set_keymap("n", "<leader>gl", ":Git log --decorate --graph --oneline<CR>", { noremap = false })
