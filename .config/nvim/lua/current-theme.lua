-- ============================================
-- ~/.config/nvim/lua/tokyo-solarized.lua
-- Tokyo Night × Solarized (Scientific Edition)
-- Auto-loading - Just require("tokyo-solarized")
-- ============================================

local M = {}

-- -------- TRANSPARENCY CONFIGURATION --------
M.config = {
	transparent = true,
	transparent_mode = "full",
	alpha = 0.8,
	brightness_boost = 1.15,
}

-- Helper function to create rgba color with alpha
local function rgba(hex, alpha)
	if not hex or hex == "NONE" then
		return "NONE"
	end
	if hex:match("^#%x%x%x%x%x%x$") then
		local r = tonumber(hex:sub(2, 3), 16)
		local g = tonumber(hex:sub(4, 5), 16)
		local b = tonumber(hex:sub(6, 7), 16)
		return string.format("#%02x%02x%02x%02x", r, g, b, math.floor(alpha * 255))
	end
	return hex
end

-- Helper function to brighten a color
local function brighten(hex, factor)
	if not hex or hex == "NONE" then
		return "NONE"
	end
	if hex:match("^#%x%x%x%x%x%x$") then
		local r = tonumber(hex:sub(2, 3), 16)
		local g = tonumber(hex:sub(4, 5), 16)
		local b = tonumber(hex:sub(6, 7), 16)

		local boost = M.config.transparent and M.config.brightness_boost or 1.0

		r = math.min(255, math.floor(r * boost))
		g = math.min(255, math.floor(g * boost))
		b = math.min(255, math.floor(b * boost))

		return string.format("#%02x%02x%02x", r, g, b)
	end
	return hex
end

-- Get background color based on transparency settings
local function get_bg(original_bg)
	if not M.config.transparent then
		return original_bg
	end
	if M.config.transparent_mode == "full" then
		return "NONE"
	else
		return rgba(original_bg, M.config.alpha)
	end
end

-- -------- SCIENTIFIC COLOR PALETTE (Transparency-Optimized) --------
M.colors = {
	-- Background
	bg = "#0d1f30",
	bg_dark = "#081828",
	bg_highlight = "#203850",
	bg_visual = "#2a4460",
	bg_search = "#244568",

	-- Foreground
	fg = "#e8e2d5",
	fg_dark = "#c0baaa",
	fg_gutter = "#5a6a7a",

	-- Base colors
	base00 = "#6b7b8b",
	base01 = "#5a6a7a",
	base02 = "#4a5a6a",
	base03 = "#6b7b8b",

	-- Accent colors
	blue = "#66b0f0",
	cyan = "#7dd8e8",
	green = "#a0d87e",
	orange = "#e8a86a",
	purple = "#bca8d8",
	red = "#e07878",
	yellow = "#e8d088",
	teal = "#80d4c4",

	-- Git
	added = "#64b8a4",
	modified = "#6498b8",
	removed = "#b87a7a",

	-- Statusline
	mode_normal = "#e8d088",
	mode_insert = "#a0d87e",
	mode_visual = "#bca8d8",
	mode_replace = "#e07878",
	mode_command = "#7dd8e8",

	-- Borders and floats
	border = "#4a6a8a",
	border_focus = "#66b0f0",
	float_bg = "#1a2d42",
	visual_fg = "#ffffff",
}

-- -------- APPLY THEME FUNCTION --------
local function apply_theme()
	local c = M.colors

	-- Apply transparency to main backgrounds
	local bg = get_bg(c.bg)
	local bg_dark = get_bg(c.bg_dark)
	local bg_highlight = get_bg(c.bg_highlight)
	local bg_visual = get_bg(c.bg_visual)
	local bg_search = get_bg(c.bg_search)

	-- Editor
	vim.api.nvim_set_hl(0, "Normal", { fg = c.fg, bg = bg })
	vim.api.nvim_set_hl(0, "NormalNC", { fg = c.fg_dark, bg = bg })
	vim.api.nvim_set_hl(0, "NormalFloat", { fg = c.fg, bg = c.float_bg })
	vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = bg })
	vim.api.nvim_set_hl(0, "NonText", { fg = c.fg_gutter, bg = "NONE" })
	vim.api.nvim_set_hl(0, "LineNr", { fg = c.fg_gutter, bg = bg })
	vim.api.nvim_set_hl(0, "LineNrAbove", { fg = c.fg_gutter, bg = bg })
	vim.api.nvim_set_hl(0, "LineNrBelow", { fg = c.fg_gutter, bg = bg })
	vim.api.nvim_set_hl(0, "CursorLineNr", { fg = c.fg, bg = bg_highlight, bold = true })
	vim.api.nvim_set_hl(0, "CursorLine", { bg = bg_highlight })
	vim.api.nvim_set_hl(0, "CursorColumn", { bg = bg_highlight })
	vim.api.nvim_set_hl(0, "SignColumn", { fg = c.fg, bg = bg })

	-- Windows & Borders
	vim.api.nvim_set_hl(0, "WinSeparator", { fg = c.border, bg = bg, bold = true })
	vim.api.nvim_set_hl(0, "StatusLine", { fg = c.fg, bg = bg_dark })
	vim.api.nvim_set_hl(0, "StatusLineNC", { fg = c.fg_gutter, bg = bg_dark })
	vim.api.nvim_set_hl(0, "TabLine", { fg = c.fg_dark, bg = bg_highlight })
	vim.api.nvim_set_hl(0, "TabLineSel", { fg = c.fg, bg = bg })
	vim.api.nvim_set_hl(0, "TabLineFill", { fg = c.fg_dark, bg = bg })

	-- Floating Windows
	vim.api.nvim_set_hl(0, "FloatBorder", { fg = c.border, bg = c.float_bg })
	vim.api.nvim_set_hl(0, "FloatTitle", { fg = c.border_focus, bg = c.float_bg, bold = true })
	vim.api.nvim_set_hl(0, "FloatShadow", { bg = "#000000" })
	vim.api.nvim_set_hl(0, "FloatShadowThrough", { bg = "#000000" })
	vim.api.nvim_set_hl(0, "Pmenu", { fg = c.fg, bg = c.float_bg })
	vim.api.nvim_set_hl(0, "PmenuSel", { fg = c.fg, bg = c.bg_highlight, bold = true })
	vim.api.nvim_set_hl(0, "PmenuSbar", { bg = bg_highlight })
	vim.api.nvim_set_hl(0, "PmenuThumb", { bg = c.fg_gutter })

	-- Folds
	vim.api.nvim_set_hl(0, "Folded", { fg = c.blue, bg = bg_highlight })
	vim.api.nvim_set_hl(0, "FoldColumn", { fg = c.blue, bg = bg })

	-- Search
	vim.api.nvim_set_hl(0, "Search", { fg = c.bg_dark, bg = c.yellow, bold = true })
	vim.api.nvim_set_hl(0, "IncSearch", { fg = c.bg_dark, bg = c.orange, bold = true })
	vim.api.nvim_set_hl(0, "CurSearch", { fg = c.bg_dark, bg = c.cyan, bold = true })

	-- Matching
	vim.api.nvim_set_hl(0, "MatchParen", { fg = c.orange, bg = bg_highlight, bold = true })

	-- Visual Selection
	vim.api.nvim_set_hl(0, "Visual", { fg = c.visual_fg, bg = c.bg_visual, bold = true })
	vim.api.nvim_set_hl(0, "VisualNOS", { fg = c.visual_fg, bg = c.bg_visual })
	vim.api.nvim_set_hl(0, "VisualEnd", { fg = c.visual_fg, bg = c.bg_visual })

	-- Spell
	vim.api.nvim_set_hl(0, "SpellBad", { undercurl = true, sp = c.red })
	vim.api.nvim_set_hl(0, "SpellCap", { undercurl = true, sp = c.yellow })
	vim.api.nvim_set_hl(0, "SpellLocal", { undercurl = true, sp = c.cyan })
	vim.api.nvim_set_hl(0, "SpellRare", { undercurl = true, sp = c.purple })

	-- Diff
	vim.api.nvim_set_hl(0, "DiffAdd", { fg = c.added, bg = bg_highlight })
	vim.api.nvim_set_hl(0, "DiffChange", { fg = c.modified, bg = bg_highlight })
	vim.api.nvim_set_hl(0, "DiffDelete", { fg = c.removed, bg = bg_highlight })
	vim.api.nvim_set_hl(0, "DiffText", { fg = c.fg, bg = c.blue })

	-- Syntax
	vim.api.nvim_set_hl(0, "Comment", { fg = c.base00, italic = true, bg = "NONE" })
	vim.api.nvim_set_hl(0, "Constant", { fg = c.orange, bg = "NONE" })
	vim.api.nvim_set_hl(0, "String", { fg = c.green, bg = "NONE" })
	vim.api.nvim_set_hl(0, "Character", { fg = c.green, bg = "NONE" })
	vim.api.nvim_set_hl(0, "Number", { fg = c.orange, bg = "NONE" })
	vim.api.nvim_set_hl(0, "Boolean", { fg = c.orange, bg = "NONE" })
	vim.api.nvim_set_hl(0, "Float", { fg = c.orange, bg = "NONE" })
	vim.api.nvim_set_hl(0, "Identifier", { fg = c.cyan, bg = "NONE" })
	vim.api.nvim_set_hl(0, "Function", { fg = c.blue, bg = "NONE" })
	vim.api.nvim_set_hl(0, "Statement", { fg = c.purple, bg = "NONE" })
	vim.api.nvim_set_hl(0, "Conditional", { fg = c.purple, bg = "NONE" })
	vim.api.nvim_set_hl(0, "Repeat", { fg = c.purple, bg = "NONE" })
	vim.api.nvim_set_hl(0, "Label", { fg = c.purple, bg = "NONE" })
	vim.api.nvim_set_hl(0, "Operator", { fg = c.cyan, bg = "NONE" })
	vim.api.nvim_set_hl(0, "Keyword", { fg = c.purple, bg = "NONE" })
	vim.api.nvim_set_hl(0, "Exception", { fg = c.purple, bg = "NONE" })
	vim.api.nvim_set_hl(0, "PreProc", { fg = c.yellow, bg = "NONE" })
	vim.api.nvim_set_hl(0, "Include", { fg = c.blue, bg = "NONE" })
	vim.api.nvim_set_hl(0, "Define", { fg = c.purple, bg = "NONE" })
	vim.api.nvim_set_hl(0, "Macro", { fg = c.yellow, bg = "NONE" })
	vim.api.nvim_set_hl(0, "PreCondit", { fg = c.yellow, bg = "NONE" })
	vim.api.nvim_set_hl(0, "Type", { fg = c.yellow, bg = "NONE" })
	vim.api.nvim_set_hl(0, "StorageClass", { fg = c.purple, bg = "NONE" })
	vim.api.nvim_set_hl(0, "Structure", { fg = c.cyan, bg = "NONE" })
	vim.api.nvim_set_hl(0, "Typedef", { fg = c.yellow, bg = "NONE" })
	vim.api.nvim_set_hl(0, "Special", { fg = c.blue, bg = "NONE" })
	vim.api.nvim_set_hl(0, "SpecialChar", { fg = c.orange, bg = "NONE" })
	vim.api.nvim_set_hl(0, "Tag", { fg = c.blue, bg = "NONE" })
	vim.api.nvim_set_hl(0, "Delimiter", { fg = c.fg_dark, bg = "NONE" })
	vim.api.nvim_set_hl(0, "SpecialComment", { fg = c.base01, bg = "NONE" })
	vim.api.nvim_set_hl(0, "Debug", { fg = c.red, bg = "NONE" })
	vim.api.nvim_set_hl(0, "Underlined", { fg = c.cyan, underline = true, bg = "NONE" })
	vim.api.nvim_set_hl(0, "Ignore", { fg = c.fg_gutter, bg = "NONE" })
	vim.api.nvim_set_hl(0, "Error", { fg = c.red, bg = bg, bold = true })
	vim.api.nvim_set_hl(0, "Todo", { fg = c.yellow, bg = bg_highlight, bold = true })

	-- LSP
	vim.api.nvim_set_hl(0, "DiagnosticError", { fg = c.red, bg = "NONE", bold = true })
	vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = c.orange, bg = "NONE" })
	vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = c.blue, bg = "NONE" })
	vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = c.cyan, bg = "NONE" })
	vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = c.red })
	vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = c.orange })
	vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { undercurl = true, sp = c.blue })
	vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { undercurl = true, sp = c.cyan })
	vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = c.red, bg = bg, bold = true })
	vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { fg = c.orange, bg = bg })
	vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { fg = c.blue, bg = bg })
	vim.api.nvim_set_hl(0, "DiagnosticSignHint", { fg = c.cyan, bg = bg })

	-- Git Signs
	vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = c.added, bg = bg, bold = true })
	vim.api.nvim_set_hl(0, "GitSignsChange", { fg = c.modified, bg = bg })
	vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = c.removed, bg = bg })

	-- Statusline
	vim.api.nvim_set_hl(0, "StatusLineMode", { fg = c.bg_dark, bg = c.mode_normal, bold = true })
	vim.api.nvim_set_hl(0, "StatusLineGit", { fg = "#ffffff", bg = bg_highlight })
	vim.api.nvim_set_hl(0, "StatusLineFile", { fg = c.fg, bg = bg_highlight })
	vim.api.nvim_set_hl(0, "StatusLinePos", { fg = c.fg, bg = bg_highlight })
	vim.api.nvim_set_hl(0, "StatusLineDiag", { fg = c.fg, bg = bg_highlight })

	-- Netrw
	vim.api.nvim_set_hl(0, "netrwDir", { fg = c.blue, bold = true, bg = bg })
	vim.api.nvim_set_hl(0, "netrwExe", { fg = c.green, bg = bg })
	vim.api.nvim_set_hl(0, "netrwLink", { fg = c.cyan, underline = true, bg = bg })
	vim.api.nvim_set_hl(0, "netrwSymLink", { fg = c.cyan, bg = bg })
	vim.api.nvim_set_hl(0, "netrwTag", { fg = c.purple, bg = bg })
	vim.api.nvim_set_hl(0, "netrwClassify", { fg = c.base01, bg = bg })
	vim.api.nvim_set_hl(0, "netrwMarkFile", { fg = c.bg_dark, bg = c.orange, bold = true })

	-- Treesitter
	vim.api.nvim_set_hl(0, "@comment", { fg = c.base00, italic = true, bg = "NONE" })
	vim.api.nvim_set_hl(0, "@function", { fg = c.blue, bg = "NONE" })
	vim.api.nvim_set_hl(0, "@method", { fg = c.blue, bg = "NONE" })
	vim.api.nvim_set_hl(0, "@parameter", { fg = c.orange, bg = "NONE" })
	vim.api.nvim_set_hl(0, "@property", { fg = c.cyan, bg = "NONE" })
	vim.api.nvim_set_hl(0, "@variable", { fg = c.fg, bg = "NONE" })
	vim.api.nvim_set_hl(0, "@string", { fg = c.green, bg = "NONE" })
	vim.api.nvim_set_hl(0, "@number", { fg = c.orange, bg = "NONE" })
	vim.api.nvim_set_hl(0, "@boolean", { fg = c.orange, bg = "NONE" })
	vim.api.nvim_set_hl(0, "@type", { fg = c.yellow, bg = "NONE" })
	vim.api.nvim_set_hl(0, "@keyword", { fg = c.purple, bg = "NONE" })
	vim.api.nvim_set_hl(0, "@constant", { fg = c.orange, bg = "NONE" })
	vim.api.nvim_set_hl(0, "@operator", { fg = c.cyan, bg = "NONE" })
	vim.api.nvim_set_hl(0, "@punctuation", { fg = c.fg_dark, bg = "NONE" })
	vim.api.nvim_set_hl(0, "@tag", { fg = c.purple, bg = "NONE" })
	vim.api.nvim_set_hl(0, "@tag.attribute", { fg = c.green, bg = "NONE" })
	vim.api.nvim_set_hl(0, "@field", { fg = c.cyan, bg = "NONE" })
	vim.api.nvim_set_hl(0, "@namespace", { fg = c.yellow, bg = "NONE" })

	-- Markdown
	vim.api.nvim_set_hl(0, "markdownH1", { fg = c.blue, bold = true, bg = "NONE" })
	vim.api.nvim_set_hl(0, "markdownH2", { fg = c.cyan, bold = true, bg = "NONE" })
	vim.api.nvim_set_hl(0, "markdownH3", { fg = c.green, bold = true, bg = "NONE" })
	vim.api.nvim_set_hl(0, "markdownH4", { fg = c.yellow, bold = true, bg = "NONE" })
	vim.api.nvim_set_hl(0, "markdownH5", { fg = c.orange, bold = true, bg = "NONE" })
	vim.api.nvim_set_hl(0, "markdownH6", { fg = c.purple, bold = true, bg = "NONE" })
	vim.api.nvim_set_hl(0, "markdownCode", { fg = c.orange, bg = "NONE" })
	vim.api.nvim_set_hl(0, "markdownCodeBlock", { fg = c.fg, bg = "NONE" })
	vim.api.nvim_set_hl(0, "markdownLinkText", { fg = c.blue, underline = true, bg = "NONE" })
	vim.api.nvim_set_hl(0, "markdownItalic", { italic = true, bg = "NONE" })
	vim.api.nvim_set_hl(0, "markdownBold", { bold = true, bg = "NONE" })
	vim.api.nvim_set_hl(0, "markdownListMarker", { fg = c.purple, bg = "NONE" })
	vim.api.nvim_set_hl(0, "markdownBlockquote", { fg = c.base01, bg = "NONE" })

	-- Writing
	vim.api.nvim_set_hl(0, "SpellSuggestion", { fg = c.cyan, undercurl = true, sp = c.cyan })
	vim.api.nvim_set_hl(0, "ColorColumn", { bg = bg_highlight })
end

-- Apply theme immediately
apply_theme()

-- Set colorscheme
vim.cmd("colorscheme default")

-- Optional: Expose setup for re-application
function M.setup()
	apply_theme()
	vim.cmd("redraw!")
	print("🌙 Tokyo Solarized re-applied")
end

-- Print confirmation
print("🌙 Tokyo Solarized loaded")

return M
