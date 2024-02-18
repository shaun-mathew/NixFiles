return {
  'ThePrimeagen/harpoon',
  opts = {},
  keys = {
    {
      '<leader>ha',
      function()
        require('harpoon.mark').add_file()
      end,
      mode = 'n',
      desc = '[H]arpoon [a]dd file',
    },
    {
      '<leader>hh',
      function()
        require('harpoon.ui').toggle_quick_menu()
      end,
      mode = 'n',
      desc = '[H]arpoon toggle ui',
    },
    {
      '<M-h>',
      function()
        require('harpoon.ui').nav_file(1)
      end,
      mode = 'n',
      desc = '[H]arpoon goto file 1',
    },
    {
      '<M-j>',
      function()
        require('harpoon.ui').nav_file(2)
      end,
      mode = 'n',
      desc = '[H]arpoon goto file 2',
    },
    {
      '<M-k>',
      function()
        require('harpoon.ui').nav_file(3)
      end,
      mode = 'n',
      desc = '[H]arpoon goto file 3',
    },
    {
      '<M-l>',
      function()
        require('harpoon.ui').nav_file(4)
      end,
      mode = 'n',
      desc = '[H]arpoon goto file 4',
    },

    {
      '[h',
      function()
        require('harpoon.ui').nav_prev()
      end,
      mode = 'n',
      desc = '[H]arpoon prev mark',
    },
    {
      ']h',
      function()
        require('harpoon.ui').nav_next()
      end,
      mode = 'n',
      desc = '[H]arpoon next mark',
    },
  },
}
