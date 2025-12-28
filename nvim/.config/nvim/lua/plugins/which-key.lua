return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")
    wk.setup({
      preset = "modern", -- Floating window style
      delay = 500,

      -- DISABLE menus for basic Vim features if they feel "broken"
      plugins = {
        marks = false,     -- stops which-key from intercepting ' and `
        registers = false, -- stops which-key from intercepting "
      },
    })

    -- Register your groups
    wk.add({
      -- Define the groups explicitly to overwrite any default names
      { "<leader>c", group = "Code" },
      { "<leader>r", group = "Rename" },
      
      -- This line forces the name to be "Diagnostics" instead of "Delete"
      -- { "<leader>d", group = "Diagnostics" }, 
    })
  end,
}
