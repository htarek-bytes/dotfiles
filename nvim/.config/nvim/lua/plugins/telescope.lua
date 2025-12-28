return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.5",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("telescope").setup({
      defaults = {
        -- Better layout
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            preview_width = 0.55,
            results_width = 0.8,
          },
          width = 0.87,
          height = 0.80,
        },
        -- Ignore these in searches
        file_ignore_patterns = {
          "node_modules",
          ".git/",
          "%.png",
          "%.jpg",
          "%.jpeg",
          "%.pdf",
        },
        -- Better sorting
        sorting_strategy = "ascending",
        prompt_prefix = "🔍 ",
        selection_caret = "➜ ",
      },
      pickers = {
        find_files = {
          hidden = true, -- show hidden files
        },
      },
    })
  end,
  keys = {
    -- Standard Keys
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
    { "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
    { "<leader>fc", "<cmd>Telescope grep_string<cr>", desc = "Find Word Under Cursor" },
    { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Find Keymaps" },
    
    -- The Typst Export Menu
    {
      "<leader>ep",
      function()
        local file = vim.fn.expand("%")
        local pickers = require("telescope.pickers")
        local finders = require("telescope.finders")
        local conf = require("telescope.config").values
        local actions = require("telescope.actions")
        local action_state = require("telescope.actions.state")
        pickers.new({}, {
          prompt_title = "Export Typst To...",
          finder = finders.new_table({
            results = { "pdf", "svg", "png", "html" },
          }),
          sorter = conf.generic_sorter({}),
          attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
              actions.close(prompt_bufnr)
              local selection = action_state.get_selected_entry()
              local format = selection[1]
              local cmd = string.format("typst compile %s --format %s", file, format)
              vim.notify("Compiling to " .. format .. "...", vim.log.levels.INFO)
              vim.fn.jobstart(cmd, {
                on_exit = function(_, code)
                  if code == 0 then
                    vim.notify("Compiled successfully!", vim.log.levels.INFO)
                  else
                    vim.notify("Compilation failed.", vim.log.levels.ERROR)
                  end
                end,
              })
            end)
            return true
          end,
        }):find()
      end,
      desc = "Export Typst File",
    },
  },
}
