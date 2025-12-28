-- Nvim-autopairs: Auto-close brackets, quotes, etc.
return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
	local npairs = require("nvim-autopairs")
	local Rule = require("nvim-autopairs.rule")

	-- Basic setup
	npairs.setup({
	    check_ts = true, -- Use treesitter for smarter pairing
	    ts_config = {
		lua = { "string" }, -- Don't add pairs in lua string
		javascript = { "template_string" },
	    },
	    -- Don't auto-pair if next character is alphanumeric
	    enable_check_bracket_line = true,
	    -- Fast wrap with Alt+e: select text and press Alt+e to wrap in brackets
	    fast_wrap = {
		map = "<M-e>",
		chars = { "{", "[", "(", '"', "'" },
		pattern = [=[[%'%"%)%>%]%)%}%,]]=],
		end_key = "$",
		keys = "qwertyuiopzxcvbnmasdfghjkl",
		check_comma = true,
		highlight = "Search",
		highlight_grey = "Comment",
	    },
	})

	-- Add custom rule: $ pairs ONLY in Typst files
	npairs.add_rules({
	    Rule("`","`","markdown"),
	    Rule("$", "$", "typst"),
	})

	-- Integration with nvim-cmp (if you have it)
	local cmp_autopairs = require("nvim-autopairs.completion.cmp")
	local cmp = require("cmp")
	cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
}
