return {
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',
  'tpope/vim-surround',
  'tpope/vim-rhubarb',
  {
    -- high-performance color highlighter
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end,
  },
  -- Useful plugin to show you pending keybinds.
  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },
  --used for highlighting todo and other comments
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
}
