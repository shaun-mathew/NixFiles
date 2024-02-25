-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension 'harpoon')
pcall(require('telescope').load_extension 'projects')

-- Custom live_grep function to search in git root
local function live_grep_git_root()
  local git_root = FIND_GIT_ROOT()
  if git_root then
    require('telescope.builtin').live_grep {
      search_dirs = { git_root },
    }
  end
end

local function find_git_files()
  if IS_GIT_ROOT() then
    require('telescope.builtin').git_files()
  else
    require('telescope.builtin').find_files()
  end
end

vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

local function telescope_live_grep_open_files()
  require('telescope.builtin').live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end

vim.keymap.set('n', '<leader>f/', telescope_live_grep_open_files, { desc = 'Search in Open Files' })
vim.keymap.set('n', '<leader>fT', require('telescope.builtin').builtin, { desc = 'Search Telescope Commands' })
vim.keymap.set('n', '<leader>ff', find_git_files, { desc = 'Search Git Files' })
vim.keymap.set('n', '<leader>fF', require('telescope.builtin').find_files, { desc = 'Search Files' })
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = 'Search Help' })
vim.keymap.set('n', '<leader>f*', require('telescope.builtin').grep_string, { desc = 'Search Current Word' })
vim.keymap.set('n', '<leader>fg', ':LiveGrepGitRoot<cr>', { desc = 'Search by Grep on Git Root' })
vim.keymap.set('n', '<leader>fG', require('telescope.builtin').live_grep, { desc = 'Search by Grep' })
vim.keymap.set('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = 'earch [D]iagnostics' })
vim.keymap.set('n', '<leader>ft', require('telescope.builtin').resume, { desc = 'Resume Telescope Search' })
vim.keymap.set('n', '<leader>fr', require('telescope.builtin').oldfiles, { desc = 'Search Recently Opened Files' })

-- vim: ts=2 sts=2 sw=2 et
