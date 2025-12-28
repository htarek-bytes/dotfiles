-- Auto-center after common jumps
vim.keymap.set("n", "n", "nzz", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzz", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "*", "*zz", { desc = "Search word under cursor (centered)" })
vim.keymap.set("n", "#", "#zz", { desc = "Search word backward (centered)" })
vim.keymap.set("n", "G", "Gzz", { desc = "Go to bottom (centered)" })
vim.keymap.set("n", "gg", "ggzz", { desc = "Go to top (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })
vim.keymap.set("n", "<C-o>", "<C-o>zz", { desc = "Jump back (centered)" })
vim.keymap.set("n", "<C-i>", "<C-i>zz", { desc = "Jump forward (centered)" })

-- Auto-center after LSP jumps (go to definition, etc.)
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.cmd("normal! zz")
  end,
})
