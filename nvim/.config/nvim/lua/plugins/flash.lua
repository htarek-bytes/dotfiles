return {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {
	-- I removed the extra "opts = {" that was here. This is the correct nesting.
	highlight = {
	    groups = {
		FlashLabel = { fg = "#ffffff", bg = "#ff007c", bold = true },
		FlashMatch = { fg = "#000000", bg = "#ffff00" },
	    },
	},
    },
    keys = {
	{
	    "s",
	    mode = { "n", "x", "o" },
	    function()
		require("flash").jump({
		    -- This custom action runs when you pick a letter
		    action = function(match, state)
			state:hide() -- 1. Close the Flash window
			vim.api.nvim_win_set_cursor(0, match.pos) -- 2. Move your cursor
			vim.cmd("normal! zz")
		    end,
		})
	    end,
	    desc = "Flash (Centered)",
	},
	{ "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
	{ "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
	{ "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    },
}
