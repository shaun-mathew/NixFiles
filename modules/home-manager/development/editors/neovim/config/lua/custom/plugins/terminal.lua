return {
  'rebelot/terminal.nvim',
  opts = {
    layout = { open_cmd = 'botright new' },
    cmd = { vim.o.shell },
    autoclose = false,
  },
  config = function(_, opts)
    require('terminal').setup(opts)

    local term_map = require 'terminal.mappings'
    vim.api.nvim_create_autocmd({ 'WinEnter', 'BufWinEnter', 'TermOpen' }, {
      callback = function(args)
        if vim.startswith(vim.api.nvim_buf_get_name(args.buf), 'term://') then
          vim.cmd 'startinsert'
        end
      end,
    })
    vim.api.nvim_create_autocmd('TermOpen', {
      command = [[setlocal nonumber norelativenumber winhl=Normal:NormalFloat]],
    })

    vim.api.nvim_create_autocmd('TermClose', {
      callback = function(ctx)
        vim.cmd 'stopinsert'
        vim.api.nvim_create_autocmd('TermEnter', {
          callback = function()
            vim.cmd 'stopinsert'
          end,
          buffer = ctx.buf,
        })
      end,
      nested = true,
    })

    vim.keymap.set('n', '<leader>ts', term_map.toggle { open_cmd = 'belowright new' }, { desc = 'Toggle terminal horizontal split' })
    vim.keymap.set('n', '<leader>tv', term_map.toggle { open_cmd = 'belowright new' }, { desc = 'Toggle terminal vertical split' })
    vim.keymap.set('n', '<leader>tt', term_map.toggle { open_cmd = 'tabnew' }, { desc = 'Toggle terminal tab' })
    vim.keymap.set('n', '<leader>tf', term_map.toggle { open_cmd = 'float', height = 0.6, width = 0.6 }, { desc = 'Toggle terminal float' })
    vim.keymap.set('n', '<leader>trs', term_map.run(nil, { layout = { open_cmd = 'belowright new' } }), { desc = 'Create terminal horizontal split' })
    vim.keymap.set('n', '<leader>trv', term_map.run(nil, { layout = { open_cmd = 'belowright vnew' } }), { desc = 'Create terminal vertical split' })
    vim.keymap.set('n', '<leader>trt', term_map.run(nil, { layout = { open_cmd = 'tabnew' } }), { desc = 'Create terminal tab' })
    vim.keymap.set('n', '<leader>t]', term_map.cycle_next, { desc = 'Cycle next term' })
    vim.keymap.set('n', '<leader>t[', term_map.cycle_prev, { desc = 'Cycle prev term' })

    local function find_git_root()
      -- Use the current buffer's path as the starting point for the git search
      local current_file = vim.api.nvim_buf_get_name(0)
      local current_dir
      local cwd = vim.fn.getcwd()
      -- If the buffer is not associated with a file, return nil
      if current_file == '' then
        current_dir = cwd
      else
        -- Extract the directory from the current file's path
        current_dir = vim.fn.fnamemodify(current_file, ':h')
      end

      -- Find the Git root directory from the current file's path
      local git_root = vim.fn.systemlist('git -C ' .. vim.fn.escape(current_dir, ' ') .. ' rev-parse --show-toplevel')[1]
      if vim.v.shell_error ~= 0 then
        print 'Not a git repository. Searching on current working directory'
        return cwd
      end
      return git_root
    end

    local lazygit = require('terminal').terminal:new {
      layout = { open_cmd = 'float', height = 0.9, width = 0.9 },
      cmd = { 'lazygit', '--path', find_git_root() },
      autoclose = true,
    }
    vim.env['GIT_EDITOR'] = "nvr -cc close -cc split --remote-wait +'set bufhidden=wipe'"
    vim.api.nvim_create_user_command('Lazygit', function(args)
      lazygit.cwd = args.args and vim.fn.expand(args.args)
      lazygit:toggle(nil, true)
    end, { nargs = '?' })
  end,
}
