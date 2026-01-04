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

-- Requires
require("config.lazy")
require('config.options')
require('config.Keybinds')
vim.opt.undofile = true
