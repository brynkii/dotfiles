vim.pack.add({
	"https://github.com/kevinhwang91/nvim-ufo",
	"https://github.com/kevinhwang91/promise-async",
	"https://github.com/folke/lazydev.nvim",
})

require("lazydev").setup({
	integrations = { lspconfig = true },
})
