-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set('n', '<c-h>', '<c-w><c-h>', { desc = 'Focus left window' })
vim.keymap.set('n', '<c-j>', '<c-w><c-j>', { desc = 'Focus lower window' })
vim.keymap.set('n', '<c-k>', '<c-w><c-k>', { desc = 'Focus upper window' })
vim.keymap.set('n', '<c-l>', '<c-w><c-l>', { desc = 'Focus right window' })

vim.keymap.set('n', '[b', ':bprev<CR>', { desc = 'Goto previous buffer' })
vim.keymap.set('n', ']b', ':bnext<CR>', { desc = 'Goto next buffer' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>le', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })

vim.keymap.set('n', '<leader>q', function()
  local qf_winid = vim.fn.getqflist({ winid = 0 }).winid
  local action = qf_winid > 0 and 'cclose' or 'copen'
  vim.cmd('botright ' .. action)
end, { desc = 'Open Quickfix list' })

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

vim.keymap.set('n', '<leader>gg', ':Lazygit<CR>', { desc = 'Toggle Lazygit' })
-- vim: ts=2 sts=2 sw=2 et
