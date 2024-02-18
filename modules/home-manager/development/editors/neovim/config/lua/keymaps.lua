-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>le', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

vim.keymap.set('n', '-', require('oil').open, { desc = 'Open File Explorer' })

vim.keymap.set('t', '<c-\\><c-\\>', '<c-\\><c-n>', { desc = 'Switch to normal mode' })
vim.keymap.set('t', '<c-h>', '<c-\\><c-n><c-w>h', { desc = 'Switch focus left' })
vim.keymap.set('t', '<c-j>', '<c-\\><c-n><c-w>j', { desc = 'Switch focus down' })
vim.keymap.set('t', '<c-k>', '<c-\\><c-n><c-w>k', { desc = 'Switch focus up' })
vim.keymap.set('t', '<c-l>', '<c-\\><c-n><c-w>l', { desc = 'Switch focus right' })
-- vim: ts=2 sts=2 sw=2 et
