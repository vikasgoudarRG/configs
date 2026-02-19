return {
	{ "echasnovski/mini.nvim", version = false },

	-- 1. Mini Files
	{
		"echasnovski/mini.files",
		config = function()
			local MiniFiles = require("mini.files")
			MiniFiles.setup({
				windows = {
					preview = true, -- Enables the built-in side-preview column
					width_focus = 30,
					width_preview = 50,
				},

				mappings = {
					close = "<esc>",
					go_in = "L", -- Modern 'L' to enter
					go_in_plus = "<CR>", -- Enter to open file and close explorer
					go_out = "H", -- Modern 'H' to go up
					go_out_plus = "-",
					reset = "<BS>", -- Backspace to reset changes you typed
					synchronize = "=", -- This is your 'Save to Disk' button
				},
			})

			vim.keymap.set("n", "<leader>ee", function()
				MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
				MiniFiles.reveal_cwd()
			end, { desc = "Toggle into currently opened file from root" })
			vim.keymap.set("n", "<leader>ef", function()
				MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
			end, { desc = "Toggle into currently opened file" })
		end,
	},

	-- 2. Mini Surround
	{
		"echasnovski/mini.surround",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			mappings = {
				add = "sa",
				delete = "sd",
				find = "sf",
				find_left = "sF",
				highlight = "sh",
				replace = "sr",
				suffix_last = "l",
				suffix_next = "n",
				"n",
			},
			n_lines = 20,
			search_method = "cover",
			silent = false,
		},
	},

	-- 3. Mini Trailspace
	{
		"echasnovski/mini.trailspace",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			local trail = require("mini.trailspace")

			trail.setup({
				only_in_normal_buffers = true,
			})

			vim.keymap.set("n", "<leader>cw", trail.trim, { desc = "Trim whitespace" })

			-- This group ensures'n the autocmd is cleaned up correctly
			local group = vim.api.nvim_create_augroup("TrailspaceClear", { clear = true })

			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				group = group,
				callback = function()
					trail.unhighlight()
				end,
			})
		end,
	},
	-- Split & join
	{
		"echasnovski/mini.splitjoin",
		config = function()
			local miniSplitJoin = require("mini.splitjoin")
			miniSplitJoin.setup({
				mappings = { toggle = "" }, -- Disable default mapping
			})
			vim.keymap.set({ "n", "x" }, "sj", function()
				miniSplitJoin.join()
			end, { desc = "Join arguments" })
			vim.keymap.set({ "n", "x" }, "sk", function()
				miniSplitJoin.split()
			end, { desc = "Split arguments" })
		end,
	},
}
