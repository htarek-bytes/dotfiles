return {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        -- 1. Disable netrw (Required)
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        -- 2. ENABLE 24-bit color
        -- This is the "magic switch" that usually brings back the blue colors
        vim.opt.termguicolors = true

        -- 3. Setup nvim-tree
        require("nvim-tree").setup({
            sort = {
                sorter = "case_sensitive",
            },
            view = {
                width = 35,
            },
            renderer = {
                group_empty = true,
                icons = {
                    show = {
                        git = true,
                        folder = true,
                        file = true,
                        folder_arrow = true,
                    },
                    -- This section ensures folders look different when empty vs full
                    glyphs = {
                        folder = {
                            default = "",  -- Filled folder (blue usually)
                            open = "",     -- Filled open folder
                            empty = "",    -- Empty outline folder
                            empty_open = "",
                        }
                    }
                },
            },
            filters = {
                dotfiles = false,
            },
        })

        -- Keymaps
        vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
        vim.keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFile<CR>", { desc = "Find current file in explorer" })
        
        -- Fix for your <leader>cd issue
        vim.keymap.set("n", "<leader>cd", function()
            vim.cmd("cd %:p:h")
            vim.cmd("NvimTreeOpen")
        end, { desc = "Change root to current file" })
    end,
}
