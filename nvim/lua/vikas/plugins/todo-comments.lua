return {
	"folke/todo-comments.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "nvim-lua/plenary.nvim" },

	config = function()
		local todo_comments = require("todo-comments")
		todo_comments.setup({
			FIXME = {
				icon = " ", -- icon used for the sign, and in search results
				color = "error", -- can be a hex color, or a named color (see below)
				-- signs = false, -- configure signs for some keywords individually
			},
			TODO = { icon = " ", color = "info" },

			HACK = { icon = " ", color = "warning" },

			WARNING = { icon = " ", color = "warning" },

			PERFORMACE = { icon = " " },

			NOTE = { icon = " ", color = "hint" },

			TEST = { icon = "⏲ ", color = "test", alt = { "PASSED", "FAILED" } },

			multiline = true,
			highlight = {
				multiline_pattern = "^.",
				multiline_context = 10,
				before = "",
				keyword = "wide",
				after = "fg",
				pattern = {
					[[.*<(KEYWORDS)\s*:]], -- default pattern
					[[<!--\s*(KEYWORDS)\s*:.*-->]], -- HTML comments with colon
					[[<!--\s*(KEYWORDS)\s*.*-->]], -- HTML comments without colon
				},
				comments_only = true, -- highlighting outside of comments
			},
		})

		vim.keymap.set("n", "<leader>pt", "<cmd>TodoTelescope<cr>", { desc = "Find Todos in Telescope" })
		vim.keymap.set("n", "]t", function()
			todo_comments.jump_next()
		end, { desc = "Next todo comment" })

		vim.keymap.set("n", "[t", function()
			todo_comments.jump_prev()
		end, { desc = "Previous todo comment" })
	end,
}
-- PERF:
-- HACK:
-- TODO:
-- NOTE:
-- FIX:
-- WARNING
