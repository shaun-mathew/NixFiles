return {
  'rebelot/terminal.nvim',
  opts = {
    layout = { open_cmd = 'botright new' },
    cmd = { vim.o.shell },
    autoclose = false,
  },
  config = function(_, opts)
    require('terminal').setup(opts)
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
  end,
}
