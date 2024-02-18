return {
  'jiaoshijie/undotree',
  dependencies = 'nvim-lua/plenary.nvim',
  opts = {},
  keys = { -- load the plugin only when using it's keybinding:
    { '<leader>u', "<cmd>lua require('undotree').toggle()<cr>", mode = 'n', desc = '[U]ndotree Toggle' },
  },
}
