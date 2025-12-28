-- Oil.nvim: Edit filesystem like a buffer
return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    config = function()
	require("oil").setup({
	    default_file_explorer = false,
	    -- Columns to show
	    columns = {
		"icon",
	    },
	    -- Send deleted files to trash instead of permanently deleting
	    delete_to_trash = true,
	    -- Skip confirmation for simple operations
	    skip_confirm_for_simple_edits = false,
	    -- Keybindings inside oil buffer
	    keymaps = {
		["g?"] = "actions.show_help",
		["<CR>"] = "actions.select",
		["<C-v>"] = "actions.select_vsplit",
		["<C-s>"] = "actions.select_split",
		["<C-t>"] = "actions.select_tab",
		["<C-p>"] = "actions.preview",
		["<C-c>"] = "actions.close",
		["q"] = "actions.close",
		["<C-r>"] = "actions.refresh",
		["-"] = "actions.parent",
		["_"] = "actions.open_cwd",
		["`"] = "actions.cd",
		["~"] = "actions.tcd",
		["gs"] = "actions.change_sort",
		["gx"] = "actions.open_external",
		["g."] = "actions.toggle_hidden",
		["g\\"] = "actions.toggle_trash",
	    },
	    -- Show hidden files by default
	    view_options = {
		show_hidden = true,
	    },
	})
    end,
    keys = {
	{ "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
    },
}
