return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		config = function()
			-- import nvim-treesitter configuration engine
			local treesitter = require("nvim-treesitter.config")

			-- configure treesitter
			treesitter.setup({
				-- 1. Syntax Highlighting
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},

				-- 2. Indentation
				indent = { enable = true },

				-- 3. Language Parsers (Your Backend/Infra List)
				ensure_installed = {
					-- Backend / Systems
					"go",
					"gomod",
					"gowork",
					"gosum",
					"java",
					"cpp",
					"c",
					"rust",
					"python",
					"proto",
					-- Infra / DevOps
					"dockerfile",
					"yaml",
					"toml",
					"make",
					"terraform",
					-- Databases / Data
					"sql",
					"json",
					"json5",
					"graphql",
					-- Shell / Scripting
					"bash",
					"git_config",
					"lua",
					"vim",
					"vimdoc",
					"query",
					-- Docs
					"markdown",
					"markdown_inline",
					"regex",
				},

				-- 4. NEW: Text Objects Module
				textobjects = {
					-- Selection: Select blocks of code logically
					select = {
						enable = true,
						lookahead = true, -- Automatically jump forward to find the object
						keymaps = {
							-- Functions
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							-- Classes / Structs
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
							-- Conditionals (if/else)
							["ai"] = "@conditional.outer",
							["ii"] = "@conditional.inner",
							-- Loops (for/while)
							["al"] = "@loop.outer",
							["il"] = "@loop.inner",
							-- Parameters (Arguments)
							["aa"] = "@parameter.outer", -- includes comma
							["ia"] = "@parameter.inner", -- just the content
						},
					},

					-- Navigation: Jump between borders
					move = {
						enable = true,
						set_jumps = true, -- save to jump list for Ctrl-o / Ctrl-i
						goto_next_start = {
							["]]"] = "@function.outer",
							["]c"] = "@class.outer",
							["]a"] = "@parameter.inner",
						},
						goto_next_end = {
							["]M"] = "@function.outer",
							["]C"] = "@class.outer",
						},
						goto_previous_start = {
							["[["] = "@function.outer",
							["[c"] = "@class.outer",
							["[a"] = "@parameter.inner",
						},
						goto_previous_end = {
							["[M"] = "@function.outer",
							["[C"] = "@class.outer",
						},
					},

					-- Swap: Quickly reorder code (like function arguments)
					swap = {
						enable = true,
						swap_next = {
							["<leader>na"] = "@parameter.inner", -- swap with next argument
						},
						swap_previous = {
							["<leader>pa"] = "@parameter.inner", -- swap with previous argument
						},
					},
				},
			})

			-- Force start treesitter for all filetypes (from your original config)
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "*",
				callback = function()
					pcall(vim.treesitter.start)
				end,
			})
		end,
	},
}
