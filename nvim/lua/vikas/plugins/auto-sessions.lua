return {
	"rmagatti/auto-session",
	lazy = false,
	keys = {
		{ "<leader>wr", "<cmd>AutoSession restore<CR>", desc = "Restore session for cwd" },

		{ "<leader>ws", "<cmd>AutoSession save<CR>", desc = "Save session" },

		{ "<leader>wf", "<cmd>AutoSession search<CR>", desc = "Search sessions" },
	},

	opts = {
		auto_create = false,
		bypass_save_filetypes = { "snacks_dashboard" },
		-- This runs immediately after a session is loaded
		post_restore_cmds = {
			function()
				-- 'bufdo e' re-triggers BufRead events for all open buffers
				-- This 'wakes up' Gitsigns, nvim-lint, and LSP attachments
				vim.cmd("silent! bufdo e")
			end,
		},
	},
}
