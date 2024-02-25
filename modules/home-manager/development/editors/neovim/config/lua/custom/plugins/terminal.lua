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

    vim.env['GIT_EDITOR'] = "nvr -cc close -cc split --remote-wait +'set bufhidden=wipe'"
    vim.api.nvim_create_user_command('Lazygit', function(args)
      local lazygit = require('terminal').terminal:new {
        layout = { open_cmd = 'float', height = 0.9, width = 0.9 },
        cmd = { 'lazygit', '--path', FIND_GIT_ROOT() },
        autoclose = true,
      }
      lazygit.cwd = args.args and vim.fn.expand(args.args)
      lazygit:toggle(nil, true)
    end, { nargs = '?' })
  end,
}
