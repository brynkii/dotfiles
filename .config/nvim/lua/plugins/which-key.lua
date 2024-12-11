return {
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  opts = {
    icons = {
      -- set icon mappings to true if you have a Nerd Font
      mappings = true,
    },

    -- Document existing key chains
    spec = {
      { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
      { '<leader>d', group = '[D]ocument' },
      { '<leader>r', group = '[R]ename' },
      { '<leader>s', group = '[S]earch' },
      { '<leader>w', group = '[W]orkspace' },
      { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      { '<leader>f', group = '[F]ind' },
      { '<leader>e', group = '[E]xplore' },
      { '<leader>t', group = '[T]ab' },
      { '<leader>h', group = '[H]arpoon' },
      { '<leader>s', group = '[S]plit' },
      { '<leader>g', group = '[G]it' },
    },
  },
}
