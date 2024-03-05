return {
	-- Detect tabstop and shiftwidth automatically
	"tpope/vim-sleuth",
	"tpope/vim-surround",
	-- Useful plugin to show you pending keybinds.
	{
		"folke/which-key.nvim",
		event = "VeryLazy", -- Sets the loading event to 'VeryLazy'
		config = function() -- This is the function that runs, AFTER loading
			require("which-key").setup()

			-- Document existing key chains
			require("which-key").register({
				["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
				["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
				["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
				["<leader>f"] = { name = "[F]ind", _ = "which_key_ignore" },
				["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
				["<leader>e"] = { name = "[E]xplore", _ = "which_key_ignore" },
				["<leader>t"] = { name = "[T]ab", _ = "which_key_ignore" },
				["<leader>h"] = { name = "[H]arpoon", _ = "which_key_ignore" },
				["<leader>s"] = { name = "[S]plit", _ = "which_key_ignore" },
				["<leader>g"] = { name = "[G]it", _ = "which_key_ignore" },
			})
		end,
	},
	-- "gc" to comment visual regions/lines
	{ "numToStr/Comment.nvim", opts = {} },
	--used for highlighting todo and other comments
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
}
