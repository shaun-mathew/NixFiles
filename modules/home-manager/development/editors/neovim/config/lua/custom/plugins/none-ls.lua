return {
  'nvimtools/none-ls.nvim',
  event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
  dependencies = { 'williamboman/mason.nvim' },
  config = function(_, _)
    local null_ls = require 'null-ls'

    null_ls.setup {
      sources = {
        null_ls.builtins.formatting.alejandra,
      },
    }
  end,
}
