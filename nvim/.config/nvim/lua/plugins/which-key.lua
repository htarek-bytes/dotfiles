-- Which-key: shows keybindings popup
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")
    wk.setup({
      preset = "modern",
      delay = 500, -- delay before showing the popup (ms)
    })

    -- Register leader key descriptions
    wk.add({
      { "<leader>c", group = "code" },
      { "<leader>ca", desc = "Code action" },
      { "<leader>r", group = "rename/refactor" },
      { "<leader>rn", desc = "Rename symbol" },
    })
  end,
}
