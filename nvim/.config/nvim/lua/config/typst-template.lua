-- Auto-load Typst template for new .typ files
vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*.typ",
  callback = function()
    local template_path = vim.fn.expand("~/.config/nvim/templates/typst-template.typ")
    
    if vim.fn.filereadable(template_path) == 1 then
      local template = vim.fn.readfile(template_path)
      vim.api.nvim_buf_set_lines(0, 0, -1, false, template)
      vim.api.nvim_win_set_cursor(0, {1, 0})
    else
      vim.notify("Typst template not found at: " .. template_path, vim.log.levels.WARN)
    end
  end,
})
