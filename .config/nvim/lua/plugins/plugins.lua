return {
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',
  'tpope/vim-surround',
  'brenoprata10/nvim-highlight-colors',
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
  {
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {},
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' },
  },
}
