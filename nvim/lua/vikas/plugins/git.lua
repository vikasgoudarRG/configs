return {
	{
		"kdheepak/lazygit.nvim",
		lazy = true,
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		-- setting the keybinding for LazyGit with 'keys' is recommended in
		-- order to load the plugin when the command is run for the first time
		keys = {
			{ "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },

		config = function()
			local gs = require("gitsigns")

			gs.setup({

				signs = {
					add = { text = "┃" },
					change = { text = "┃" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
					untracked = { text = "┆" },
				},
				signs_staged = {
					add = { text = "┃" },
					change = { text = "┃" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
					untracked = { text = "┆" },
				},

				signs_staged_enable = true, -- track staging area
				signcolumn = true, -- Toggle with `:Gitsigns toggle_signs` -- column for signs
				numhl = false, -- Toggle with `:Gitsigns toggle_numhl` -- no line number highlight
				linehl = false, -- Toggle with `:Gitsigns toggle_linehl` -- no line highlight
				word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff` -- no show word_diff
				watch_gitdir = {
					follow_files = true, -- track file changes (i think syncs with lazygit)
				},

				auto_attach = true, -- auto show signs
				attach_to_untracked = false, -- only attach to git tracked files

				-- blame
				current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
					delay = 1000,
					ignore_whitespace = false,
					virt_text_priority = 100,
					use_focus = true,
				},
				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns

					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					-- navigation
					map("n", "]h", function()
						if vim.wo.diff then
							vim.cmd.normal({ "]c", bang = true })
						else
							gs.nav_hunk("next")
						end
					end)

					map("n", "[h", function()
						if vim.wo.diff then
							vim.cmd.normal({ "[c", bang = true })
						else
							gs.nav_hunk("prev")
						end
					end)

					-- actions
					map("n", "<leader>hs", gs.stage_hunk)
					map("n", "<leader>hr", gs.reset_hunk)

					map("v", "<leader>hs", function()
						gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end)

					map("v", "<leader>hr", function()
						gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end)

					map("n", "<leader>hS", gs.stage_buffer)
					map("n", "<leader>hR", gs.reset_buffer)

					map("n", "<leader>hp", gs.preview_hunk)
					map("n", "<leader>hi", gs.preview_hunk_inline)

					map("n", "<leader>hb", function()
						gs.blame_line({ full = true })
					end)

					-- difference since stage
					map("n", "<leader>hd", gs.diffthis)

					-- difference since commit
					map("n", "<leader>hD", function()
						gs.diffthis("~")
					end)

					map("n", "<leader>hQ", function()
						gs.setqflist("all")
					end)
					map("n", "<leader>hq", gs.setqflist)

					-- makes hunk a text object, so can use commands like yih (yank inner hunk)
					map({ "o", "x" }, "ih", gs.select_hunk)
				end,
			})
		end,
	},
}
