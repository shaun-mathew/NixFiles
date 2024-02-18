return {
  'RRethy/vim-illuminate',
  event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
  opts = {
    delay = 200,
    large_file_cutoff = 2000,
    large_file_overrides = {
      providers = { 'lsp' },
    },
    filetypes_denylist = {
      'dirbuf',
      'dirvish',
      'fugitive',
      'TelescopePrompt',
      'harpoon',
      'DressingInput',
      'mason',
    },
  },
  config = function(_, opts)
    require('illuminate').configure(opts)

    local buffer = vim.api.nvim_get_current_buf()
    vim.keymap.set('n', '<leader>]', function()
      require('illuminate').goto_next_reference()
    end, { desc = 'Goto next reference', buffer = buffer })

    vim.keymap.set('n', '<leader>[', function()
      require('illuminate').goto_prev_reference()
    end, { desc = 'Goto prev reference', buffer = buffer })
  end,
}
