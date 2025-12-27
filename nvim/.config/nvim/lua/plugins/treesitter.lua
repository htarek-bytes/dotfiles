return {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                -- The Essentials
                "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline",
                
                -- System / Low Level
                "c", "cpp", "zig", "python",

                -- Web / Others
                "tsx", "javascript", "typescript", "html", "css", "json",
                "bash", "java", "go", "rust", "php"
            },
            highlight = { enable = true },
            indent = { enable = true },
            autotags = { enable = true },
            sync_install = false,
            auto_install = false,
        })
    end
}
