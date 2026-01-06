require("config.embedded")
require("config.autocentering")
require("config.typst-template")
-- Filter out lspconfig deprecation warnings
local notify = vim.notify
vim.notify = function(msg, ...)
  if msg:match("lspconfig") then
    return
  end
  notify(msg, ...)
end
-- Global leader key and local one
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set('n', 'E', 'ge', { noremap = true, silent = true })
vim.keymap.set('n', 'ge', 'E', { noremap = true, silent = true })
local modes = {'i','v','c','t'}
vim.keymap.set(modes, '\\\\', [[<C-\><C-n>]], { noremap = true, silent = true})
-- Selects text inside asterisks (Visual Mode)
vim.keymap.set('x', 'i*', ':<C-u>normal! T*vt*<CR>', { silent = true })

-- Maps the inner asterisk text object for operators like c, d, and y
vim.keymap.set('o', 'i*', ':normal vi*<CR>', { silent = true })

vim.opt.timeoutlen = 300

-- Make netrw change working directory when you browse
vim.g.netrw_keepdir = 0

-- Optional: Better netrw settings
vim.g.netrw_browse_split = 0  -- Open in same window
vim.g.netrw_localcopydircmd = 'cp -r'
vim.g.netrw_sizestyle = "H"
--
-- Requires
require("config.lazy")
require('config.options')
require('config.Keybinds')
vim.opt.undofile = true
