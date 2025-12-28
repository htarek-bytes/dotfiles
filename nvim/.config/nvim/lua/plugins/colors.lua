local function enable_transparency()
    vim.api.nvim_set_hl(0, "Normal", { bg = "none"})
end

return {
    {
        "folke/tokyonight.nvim",
        priority = 1000,
        config = function()
            require("tokyonight").setup({
                style = "night", -- storm, moon, night, day
                transparent = true,
            })
            vim.cmd.colorscheme "tokyonight"
        end
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            theme = 'tokyonight',
        }
    },
}
