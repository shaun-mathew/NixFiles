-- document existing key chains
require('which-key').register {
  ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
  -- ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
  -- ['<leader>g'] = { name = '[G] Commands', _ = 'which_key_ignore' },
  ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
  ['<leader>gh'] = { name = 'Git [H]unk', _ = 'which_key_ignore' },
  ['<leader>l'] = { name = '[L]sp Actions', _ = 'which_key_ignore' },
  -- ['<leader>lw'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
  ['<leader>f'] = { name = '[F]ind', _ = 'which_key_ignore' },
  ['<leader>t'] = { name = '[T]erminal', _ = 'which_key_ignore' },
  ['<leader>tr'] = { name = '[T]erminal Create', _ = 'which_key_ignore' },
}
-- register which-key VISUAL mode
-- required for visual <leader>hs (hunk stage) to work
require('which-key').register({
  ['<leader>'] = { name = 'VISUAL <leader>' },
  ['<leader>gh'] = { 'Git [H]unk' },
}, { mode = 'v' })
