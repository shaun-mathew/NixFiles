return {
  'nvimtools/none-ls.nvim',
  enabled = false,
  event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
  dependencies = { 'williamboman/mason.nvim' },
}
