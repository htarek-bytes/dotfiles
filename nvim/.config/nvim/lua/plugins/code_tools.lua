return {
  ---------------------------------------------------------
  -- 1. THE SPECIALIST (Typst Preview)
  -- This replaces omni-preview with the dedicated Typst tool
  ---------------------------------------------------------
  {
    "chomosuke/typst-preview.nvim",
    lazy = false, -- Load immediately
    version = "1.*", 
    keys = {
      -- We map <Space>p to the special Toggle command
      { "<space>p", "<cmd>TypstPreviewToggle<cr>", desc = "Typst Preview" },
    },
    build = function() require("typst-preview").update() end,
    config = function()
        require("typst-preview").setup({
            -- Auto-open the browser
            open_cmd = "xdg-open %s",
            
            -- Tell it exactly where Mason hid the Tinymist binary
            dependencies_bin = {
                ['tinymist'] = vim.fn.stdpath("data") .. "/mason/bin/tinymist",
                ['websocat'] = nil -- Let the plugin handle the websocket tool
            },
        })
    end,
  },

  ---------------------------------------------------------
  -- 2. THE INSTALLER (Mason)
  ---------------------------------------------------------
  {
    "williamboman/mason.nvim",
    config = true, 
  },

  ---------------------------------------------------------
  -- 3. THE ENGINE (LSP) - Neovim 0.11 Compatible
  ---------------------------------------------------------
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
    config = function()
      -- Force Leader Key
      vim.g.mapleader = " "

      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "tinymist", "lua_ls", "pyright", "clangd" },
        automatic_installation = true,
      })

      -- The "Safe Enable" Function (Works on Nightly & Stable)
      local function start_server(name, config)
        config = config or {}
        if vim.lsp.config then
          vim.lsp.config[name] = config
          vim.lsp.enable(name)
        else
          require("lspconfig")[name].setup(config)
        end
      end

      -- Start Servers
      start_server("tinymist", {
        single_file_support = true,
        root_dir = function() return vim.fn.getcwd() end,
        settings = { exportPdf = "never" }
      })
      
      start_server("lua_ls", { settings = { Lua = { diagnostics = { globals = { "vim" } } } } })
      start_server("pyright", {})
      start_server("clangd", {})

      if vim.fn.executable("zls") == 1 then
        start_server("zls", {})
      end
    end,
  },
}
