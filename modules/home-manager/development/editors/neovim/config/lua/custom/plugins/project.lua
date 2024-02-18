return {
  'ahmedkhalf/project.nvim',
  priority = 900,
  lazy = false,
  opts = {
    exclude_dirs = {
      '~/dotfiles/modules/home-manager/development/editors/neovim/config',
    },
  },
  config = function(_, opts)
    require('project_nvim').setup(opts)
  end,
}
