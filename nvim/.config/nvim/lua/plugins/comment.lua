-- Comment.nvim: Smart commenting
return {
  "numToStr/Comment.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("Comment").setup({
      -- Add a space between comment and the line
      padding = true,
      -- Ignore empty lines
      ignore = "^$",
      -- Keybindings
      toggler = {
        line = "gcc",  -- Line-comment toggle
        block = "gbc", -- Block-comment toggle
      },
      opleader = {
        line = "gc",   -- Line-comment operator
        block = "gb",  -- Block-comment operator
      },
    })
  end,
}
