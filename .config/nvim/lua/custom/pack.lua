-- ============================================
-- Native vim.pack Plugin Management Commands
-- ============================================

-- Helper: Create floating window
local function float_window(lines, title)
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	vim.bo[buf].modifiable = false
	vim.bo[buf].buftype = "nofile"
	vim.bo[buf].filetype = "markdown"

	local width = math.min(80, vim.o.columns - 4)
	local height = math.min(#lines + 2, vim.o.lines - 4)
	vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = (vim.o.lines - height) / 2,
		col = (vim.o.columns - width) / 2,
		style = "minimal",
		border = "rounded",
		title = " " .. title .. " ",
		title_pos = "center",
	})

	vim.keymap.set("n", "q", ":q<CR>", { noremap = true, silent = true, buffer = buf })
	vim.keymap.set("n", "<Esc>", ":q<CR>", { noremap = true, silent = true, buffer = buf })
end

-- Helper: Get plugin repo safely
local function get_plugin_repo(plugin)
	---@diagnostic disable-next-line: undefined-field
	return plugin.spec.repo
end

-- Helper: Get plugin names for completion
local function plugin_names()
	local names = {}
	for _, plugin in ipairs(vim.pack.get()) do
		table.insert(names, plugin.spec.name)
	end
	table.sort(names)
	return names
end

-- Helper: Get non-active plugins
local function get_non_active()
	return vim.iter(vim.pack.get())
		:filter(function(x)
			return not x.active
		end)
		:map(function(x)
			return x.spec.name
		end)
		:totable()
end

-- Add plugins
vim.api.nvim_create_user_command("PackAdd", function(opts)
	vim.pack.add(opts.fargs)
end, { nargs = "+", desc = "Add plugins" })

-- Delete plugins
vim.api.nvim_create_user_command("PackDel", function(opts)
	vim.pack.del(opts.fargs)
end, { nargs = "+", desc = "Delete plugins" })

-- Update plugins
vim.api.nvim_create_user_command("PackUpdate", function(opts)
	if opts.args ~= "" then
		vim.pack.update(vim.split(opts.args, "%s+", { trimempty = true }))
	else
		vim.pack.update()
	end
end, { nargs = "*", desc = "Update all or specific plugins" })

-- List plugins
vim.api.nvim_create_user_command("PackList", function(opts)
	local plugins = vim.pack.get()
	table.sort(plugins, function(a, b)
		return a.spec.name < b.spec.name
	end)

	local lines = { "# Plugins", "" }
	local active, inactive = 0, 0

	for _, plugin in ipairs(plugins) do
		local name = plugin.spec.name

		if opts.args == "" or name:lower():find(opts.args:lower(), 1, true) then
			if plugin.active or opts.bang then
				local status = plugin.active and "✓" or "✗"
				local repo = get_plugin_repo(plugin)
				local repo_info = repo and "  (" .. repo .. ")" or ""
				table.insert(lines, string.format("%s %s%s", status, name, repo_info))

				if plugin.active then
					active = active + 1
				else
					inactive = inactive + 1
				end
			end
		end
	end

	table.insert(lines, "")
	table.insert(lines, string.format("Active: %d | Inactive: %d", active, inactive))

	float_window(lines, "Plugins")
end, {
	nargs = "?",
	bang = true,
	desc = "List plugins (! for all, optional filter)",
	complete = plugin_names,
})

-- Plugin info
vim.api.nvim_create_user_command("PackInfo", function(opts)
	local plugin = nil
	for _, p in ipairs(vim.pack.get()) do
		if p.spec.name == opts.args then
			plugin = p
			break
		end
	end

	if not plugin then
		vim.notify("Plugin not found: " .. opts.args, vim.log.levels.ERROR)
		return
	end

	local lines = {
		"# " .. plugin.spec.name,
		"",
		"Status: " .. (plugin.active and "Active" or "Inactive"),
		"Type: " .. (plugin.spec.opt and "Optional" or "Start"),
	}

	local repo = get_plugin_repo(plugin)
	if repo then
		table.insert(lines, "Repo: " .. repo)
	end

	---@diagnostic disable-next-line: undefined-field
	if plugin.spec.branch then
		table.insert(lines, "Branch: " .. plugin.spec.branch)
	end
	---@diagnostic disable-next-line: undefined-field
	if plugin.spec.tag then
		table.insert(lines, "Tag: " .. plugin.spec.tag)
	end
	---@diagnostic disable-next-line: undefined-field
	if plugin.spec.commit then
		table.insert(lines, "Commit: " .. plugin.spec.commit)
	end
	if plugin.dir then
		table.insert(lines, "Path: " .. plugin.dir)
	end

	float_window(lines, "Plugin Info")
end, {
	nargs = 1,
	desc = "Show plugin details",
	complete = plugin_names,
})

-- Quick status
vim.api.nvim_create_user_command("PackStatus", function()
	local plugins = vim.pack.get()
	local active = vim.iter(plugins)
		:filter(function(x)
			return x.active
		end)
		:totable()
	local opt = vim.iter(plugins)
		:filter(function(x)
			return x.spec.opt
		end)
		:totable()

	vim.notify(
		string.format("Total: %d\nActive: %d\nInactive: %d\nOptional: %d", #plugins, #active, #plugins - #active, #opt),
		vim.log.levels.INFO,
		{ title = "Pack Status" }
	)
end, { desc = "Plugin status summary" })

-- Check inactive plugins
vim.api.nvim_create_user_command("PackCheck", function()
	local non_active = get_non_active()

	if #non_active == 0 then
		vim.notify("🆗 No inactive plugins!", vim.log.levels.INFO)
		return
	end

	print("😴 Inactive plugins: " .. table.concat(non_active, ", "))

	if vim.fn.confirm("Delete all inactive plugins?", "&Yes\n&No", 2) == 1 then
		vim.pack.del(non_active)
		vim.notify("🗑️  Deleted " .. #non_active .. " plugin(s)", vim.log.levels.INFO)
		vim.api.nvim_exec_autocmds("User", { pattern = "PackChanged" })
	end
end, { desc = "List and optionally delete inactive plugins" })

-- Clean inactive plugins
vim.api.nvim_create_user_command("PackClean", function(opts)
	local non_active = get_non_active()

	if #non_active == 0 then
		vim.notify("No inactive plugins to clean", vim.log.levels.INFO)
		return
	end

	if opts.bang or vim.fn.confirm("Delete " .. #non_active .. " inactive plugins?", "&Yes\n&No", 2) == 1 then
		vim.pack.del(non_active)
		vim.notify("🗑️  Deleted " .. #non_active .. " plugin(s)", vim.log.levels.INFO)
		vim.api.nvim_exec_autocmds("User", { pattern = "PackChanged" })
	end
end, { bang = true, desc = "Clean inactive plugins (! to skip confirmation)" })
