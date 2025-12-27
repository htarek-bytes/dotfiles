return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    -- This 'main' line tells Lazy what to load so you don't have to 'require' it manually
    main = "nvim-treesitter.configs", 
    opts = {
        ensure_installed = {
            -- The Essentials
            "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline",
            
            -- System / Low Level
            "c", "cpp", "zig", "python",
            
            -- Web / Others
            "tsx", "javascript", "typescript", "html", "css", "json", 
            "bash", "java", "go", "rust", "php"
        },
        -- Highlight is the most important part
        highlight = { enable = true },
        indent = { enable = true },
        -- Note: autotags usually requires the 'nvim-ts-autotag' plugin to work fully
        autotags = { enable = true },
        auto_install = false,
        sync_install = false,
    },
}
