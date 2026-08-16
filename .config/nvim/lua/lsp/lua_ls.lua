vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			completion = {
				callSnippet = "Replace",
			},
			-- workspace = {
			--     library = {
			--         [vim.fn.expand("$VIMRUNTIME/lua")] = true,
			--         [vim.fn.stdpath("config") .. "/lua"] = true,
			--     },
			-- },
		},
	},
})
