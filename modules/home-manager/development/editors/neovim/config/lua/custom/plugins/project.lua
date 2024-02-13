return {
  'ahmedkhalf/project.nvim',
  priority = 900,
  lazy = false,
  config = function()
    require('project_nvim').setup()
  end,
}
