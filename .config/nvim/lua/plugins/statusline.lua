-- ============================================
-- ~/.config/nvim/lua/plugins/statusline.lua
-- Auto-loading statusline with dynamic colors
-- ============================================

-- Get colors from existing theme (like your inspiration)
local pms = vim.api.nvim_get_hl(0, { name = "PmenuSel", link = false })
local dir = vim.api.nvim_get_hl(0, { name = "Directory", link = false })
local vis = vim.api.nvim_get_hl(0, { name = "Visual", link = false })

-- Create custom highlight groups based on theme colors
vim.api.nvim_set_hl(0, "StlMode", { fg = pms.fg, bg = vis.bg })
vim.api.nvim_set_hl(0, "StlGit", { fg = dir.fg, bg = pms.bg })
vim.api.nvim_set_hl(0, "StlFile", { fg = pms.fg, bg = "NONE" })
vim.api.nvim_set_hl(0, "StlNetrw", { fg = dir.fg, bg = pms.bg })

-- Mode mappings
local modes = {
	n = "NORMAL",
	i = "INSERT",
	v = "VISUAL",
	V = "V-LINE",
	["\22"] = "V-BLOCK",
	c = "COMMAND",
	t = "TERMINAL",
	R = "REPLACE",
	s = "SELECT",
	S = "S-LINE",
	["\19"] = "S-BLOCK",
}

-- File icons based on extension
local file_icons = {
	lua = "󰢱",
	python = "󰌠",
	javascript = "󰌞",
	typescript = "󰛦",
	rust = "󱘗",
	go = "󰟓",
	c = "󰙱",
	cpp = "󰙲",
	java = "󰬷",
	sh = "󱆃",
	bash = "󱆃",
	zsh = "󱆃",
	vim = "󰕷",
	md = "󰍔",
	markdown = "󰍔",
	json = "󰘦",
	yaml = "󰘦",
	yml = "󰘦",
	toml = "󰘦",
	html = "󰌝",
	css = "󰌜",
	scss = "󰌜",
	sql = "󰆼",
	dockerfile = "󰡨",
	gitignore = "󰊢",
	license = "󰿃",
	readme = "󰂺",
}

-- Get file icon
local function get_file_icon(filename)
	local ext = filename:match("%.([^.]+)$")
	if ext then
		ext = ext:lower()
		if file_icons[ext] then
			return file_icons[ext] .. " "
		end
	end
	if filename:match("^README") then
		return file_icons.readme .. " "
	end
	if filename:match("^Dockerfile") then
		return file_icons.dockerfile .. " "
	end
	if filename:match("^LICENSE") then
		return file_icons.license .. " "
	end
	if filename:match("^%.gitignore") then
		return file_icons.gitignore .. " "
	end
	return "󰈔 "
end

-- Special netrw status
local function netrw_status()
	if vim.bo.filetype ~= "netrw" then
		return nil
	end
	
	local dir_path = vim.fn.getcwd()
	local dir_name = vim.fn.fnamemodify(dir_path, ":t")
	if dir_name == "" then
		dir_name = "/"
	end
	
	local item_count = 0
	local lines = vim.fn.getline(1, "$")
	for _, line in ipairs(lines) do
		if not line:match('^"') and not line:match("^%s*$") then
			item_count = item_count + 1
		end
	end
	
	local sort_by = vim.g.netrw_sort_by or "name"
	local sort_dir = vim.g.netrw_sort_direction == "normal" and "↑" or "↓"
	
	-- Simplified hidden check without problematic escape sequences
	local hidden = "○"
	if vim.g.netrw_list_hide and vim.g.netrw_list_hide ~= "" then
		hidden = "●"
	end
	
	return string.format(
		"%%#StlMode# 󰉋 NETRW %%* %%#StlGit# %s %%* %d items | %s %s | hidden: %s %%= %%#StlFile# q:quit %%*",
		dir_name,
		item_count,
		sort_by,
		sort_dir,
		hidden
	)
end

-- Main statusline function
function _G._statusline()
	-- Check for netrw first
	local netrw = netrw_status()
	if netrw then
		return netrw
	end
	
	-- Get mode
	local mode = modes[vim.fn.mode()] or vim.fn.mode():upper()
	
	-- Git branch
	local branch = ""
	if vim.b.git_branch and vim.b.git_branch ~= "" then
		branch = "%#StlGit#  " .. vim.b.git_branch .. " %*"
	end
	
	-- File path
	local path = vim.b.rel_path or "%f"
	local filename = vim.fn.expand("%:t")
	local icon = get_file_icon(filename)
	
	-- Modified indicator
	local modified = vim.bo.modified and " ●" or ""
	local readonly = vim.bo.readonly and " " or ""
	
	-- Diagnostics
	local diag = ""
	local counts = vim.diagnostic.count(0) or {}
	local labels = { " ", " ", " ", " " }
	local hls = { "DiagnosticError", "DiagnosticWarn", "DiagnosticInfo", "DiagnosticHint" }
	for i = 1, 4 do
		if counts[i] and counts[i] > 0 then
			diag = diag .. "%#" .. hls[i] .. "#" .. labels[i] .. counts[i] .. "%* "
		end
	end
	
	-- File type
	local filetype = vim.bo.filetype ~= "" and vim.bo.filetype or "no ft"
	
	-- Position
	local line = vim.fn.line(".")
	local col = vim.fn.col(".")
	local total = vim.fn.line("$")
	local pct = total > 0 and math.floor(line * 100 / total) or 0
	
	-- Build statusline
	return string.format(
		"%%#StlMode# %s %%* %s %%#StlFile# %s%s%s%s %%* %%= %s %s %d:%d %d%%%%",
		mode,
		branch,
		icon,
		path,
		modified,
		readonly,
		diag,
		filetype,
		line,
		col,
		pct
	)
end

-- Git integration
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		local root = vim.fn.system("git rev-parse --show-toplevel 2>/dev/null"):gsub("%s+$", "")
		if root ~= "" then
			vim.b.git_branch = vim.fn.system("git branch --show-current 2>/dev/null"):gsub("%s+$", "")
			vim.b.rel_path = vim.fn.expand("%:p"):sub(#root + 2)
		else
			vim.b.git_branch = nil
			vim.b.rel_path = vim.fn.expand("%:p:~")
		end
	end,
})

-- Refresh on diagnostics change
vim.api.nvim_create_autocmd("DiagnosticChanged", {
	callback = function()
		vim.cmd("redrawstatus!")
	end,
})

-- Refresh on mode change
vim.api.nvim_create_autocmd("ModeChanged", {
	callback = function()
		vim.cmd("redrawstatus!")
	end,
})

-- Apply statusline
vim.o.laststatus = 2
vim.o.statusline = "%!v:lua._statusline()"

-- Optional: Add a command to manually refresh
vim.api.nvim_create_user_command("RefreshStatusline", function()
	vim.cmd("redrawstatus!")
end, {})

-- Print confirmation when loaded
vim.notify("📊 Statusline loaded!", vim.log.levels.INFO, { title = "Statusline" })
