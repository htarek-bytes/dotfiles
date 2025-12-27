-- Global leader key and local one
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- Requires
require("config.lazy")
require('config.options')
require('config.Keybinds')
vim.opt.undofile = true
