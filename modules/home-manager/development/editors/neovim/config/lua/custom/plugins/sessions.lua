return {
  'rmagatti/auto-session',
  opts = {
    auto_session_use_git_branch = true,
    auto_restore_enabled = true,
    auto_save_enabled = true,
  },
  config = function(_, opts)
    require('auto-session').setup(opts)
  end,
}
