return {
	-- Setup Folding with nvim-ufo
	{
		"kevinhwang91/nvim-ufo",
		dependencies = {
			"kevinhwang91/promise-async",
		},
		config = function()
			require("ufo").setup({
				-- treesitter not required
				-- ufo uses the same query files for folding (queries/<lang>/folds.scm)
				-- performance and stability are better than `foldmethod=nvim_treesitter#foldexpr()`-
				provider_selector = function(_, _, _)
					return { "treesitter", "indent" }
				end,
				open_fold_hl_timeout = 0, -- Disable highlight timeout after opening
			})

			vim.o.foldenable = true
			vim.o.foldcolumn = "0" -- '0' is not bad
			vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
			vim.o.foldlevelstart = 99

			-- Toggle all folds
			vim.keymap.set("n", "zA", function()
				local ufo = require("ufo")
				-- We use a simple toggle state or check if any folds are closed
				-- But the most reliable way is to track a local toggle variable
				if _G.all_folds_closed then
					ufo.openAllFolds()
					_G.all_folds_closed = false
				else
					ufo.closeAllFolds()
					_G.all_folds_closed = true
				end
			end, { desc = "Toggle all folds" })
		end,
	},
}
