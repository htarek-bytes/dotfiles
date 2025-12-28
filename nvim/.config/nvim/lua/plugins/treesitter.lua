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
        "bash", "java", "go", "rust", "php",
        -- YOU WERE MISSING THIS!
        "typst",
      },
      highlight = {
        enable = true,
        -- Disable in large files for performance
        disable = function(lang, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
        -- Better highlighting for some filetypes
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
      -- Smart incremental selection
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<CR>",
          node_incremental = "<CR>",
          scope_incremental = "<TAB>",
          node_decremental = "<BS>",
        },
      },
      -- Better text objects (select functions, classes, etc.)
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
        },
      },
      sync_install = false,
      auto_install = true, -- Auto-install missing parsers
    })
  end,
}
