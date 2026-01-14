-- 1. GET CURRENT LOCATION
-- This file is at: .../nvim/lua/config/typst-template.lua
local current_file = debug.getinfo(1, "S").source:sub(2)
local current_dir = vim.fn.fnamemodify(current_file, ":h")

-- 2. CALCULATE TARGET (The Fix: Go up TWO levels)
-- current_dir  = .../lua/config
-- ..           = .../lua
-- ../..        = .../nvim (The Root)
-- Result       = .../nvim/templates/typst-template.typ
local template_path = vim.fn.resolve(current_dir .. "/../../templates/typst-template.typ")

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = "*.typ",
    group = vim.api.nvim_create_augroup("TypstTemplate", { clear = true }),
    callback = function()
        -- Guard: Only run on truly empty files
        local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
        if #lines > 1 or (#lines == 1 and lines[1] ~= "") then return end

        -- 3. EXECUTE LOAD
        if vim.fn.filereadable(template_path) == 1 then
            local content = vim.fn.readfile(template_path)
            vim.api.nvim_buf_set_lines(0, 0, -1, false, content)
            pcall(vim.api.nvim_win_set_cursor, 0, {26, 0})
            print(">>> Success! Template loaded.")
        else
            -- Debugging: If this still fails, double check the folder name isn't 'template' (singular)
            vim.api.nvim_err_writeln("FAILED. Looked at: " .. template_path)
        end
    end,
})
