return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		-- NOTE: LSP Keybinds
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Buffer local mappings
				local opts = { buffer = ev.buf, silent = true }

				-- Keymaps
				opts.desc = "Show LSP references"
				vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

				opts.desc = "Go to declaration"
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

				opts.desc = "Show LSP definitions"
				vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

				opts.desc = "Show LSP implementations"
				vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

				opts.desc = "Show LSP type definitions"
				vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

				opts.desc = "See available code actions"

				vim.keymap.set({ "n", "v" }, "<leader>vca", function()
					vim.lsp.buf.code_action()
				end, opts)

				opts.desc = "Smart rename"
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

				opts.desc = "Show buffer diagnostics"
				vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

				opts.desc = "Show line diagnostics"
				vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

				opts.desc = "Restart LSP"
				vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)

				vim.keymap.set("i", "<C-h>", function()
					vim.lsp.buf.signature_help()
				end, opts)
			end,
		})

		-- NOTE: Diagnostic Setup
		-- Define sign icons for each severity
		local signs = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = "󰠠 ",
			[vim.diagnostic.severity.INFO] = " ",
		}

		-- curosr hover hold
		local augroup = vim.api.nvim_create_augroup("LspDiagnosticsHold", { clear = true })
		local virtual_text_enabled = true
		vim.o.updatetime = 350

		-- helper functon check if cursor over diagnostic
		local function cursor_over_diagnostic()
			local bufnr = vim.api.nvim_get_current_buf()
			local cursor_pos = vim.api.nvim_win_get_cursor(0)
			local lnum = cursor_pos[1] - 1
			local col = cursor_pos[2]
			local diags = vim.diagnostic.get(bufnr, { lnum = lnum })
			for _, diag in ipairs(diags) do
				if diag.end_lnum == lnum and col >= diag.col and col < diag.end_col then
					return true
				end
			end
			return false
		end

		-- helper check for any open float (to avoid overlaps with float doc)
		local function has_floating_win()
			for _, winid in ipairs(vim.api.nvim_list_wins()) do
				local cfg = vim.api.nvim_win_get_config(winid)
				if cfg.relative ~= "" then
					return true
				end
			end
			return false
		end

		-- update diagnostic config function
		local function update_diagnostic_config()
			vim.diagnostic.config({
				signs = { text = signs },
				virtual_text = virtual_text_enabled,
				underline = true, -- Always on
				update_in_insert = true,
				float = {
					focusable = false,
					style = "minimal",
					border = "rounded",
					source = true,
				},
			})
		end

		-- call initial diagnostic setup
		update_diagnostic_config()

		-- LSP Toggle Keymaps
		-- <leader>lx toggle for virtual text (no hover changes)
		vim.keymap.set("n", "<leader>lx", function()
			virtual_text_enabled = not virtual_text_enabled
			update_diagnostic_config()
		end, { desc = "Toggle LSP virtual text" })

		-- <leader>ll toggle between virtual text mode and precise hover mode
		vim.keymap.set("n", "<leader>ll", function()
			virtual_text_enabled = not virtual_text_enabled
			update_diagnostic_config()

			-- Clear autocmds first
			vim.api.nvim_clear_autocmds({ group = augroup })

			-- Enable hover only when virtual text is off
			if not virtual_text_enabled then
				vim.api.nvim_create_autocmd("CursorHold", {
					group = augroup,
					callback = function()
						if cursor_over_diagnostic() and not has_floating_win() then
							vim.diagnostic.open_float(nil, {
								focusable = false,
								close_events = {
									"CursorMoved",
									"CursorMovedI",
									"BufHidden",
									"InsertCharPre",
									"WinLeave",
								},
							})
						end
					end,
				})
			end
		end, { desc = "Toggle LSP diagnostics virtual text or precise hover" })

		-- NOTE: Setup servers
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Global LSP settings (applied to all servers)
		vim.lsp.config("*", {
			capabilities = capabilities,
		})

		-- Configure and enable LSP servers

		-- lua_ls
		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					completion = {
						callSnippet = "Replace",
					},
					workspace = {
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
				},
			},
		})

		-- go
		vim.lsp.config("gopls", {
			settings = {
				gopls = {
					analyses = {
						unusedparams = true,
						shadow = true,
					},
					staticcheck = true,
					gofumpt = true,
				},
			},
		})

		-- java
		vim.lsp.config("jdtls", {})

		-- c/ c++
		vim.lsp.config("clangd", {
			cmd = { "clangd", "--background-index" },
		})

		-- rust
		vim.lsp.config("rust_analyzer", {
			settings = {
				["rust-analyzer"] = {
					cargo = { allFeatures = true },
					checkOnSave = true,
				},
			},
		})

		-- python
		vim.lsp.config("pyright", {
			settings = {
				python = {
					analysis = {
						typeCheckingMode = "basic",
					},
				},
			},
		})

		-- proto
		vim.lsp.config("buf_ls", {})

		-- docker
		vim.lsp.config("dockerls", {})

		-- yaml
		vim.lsp.config("yamlls", {
			settings = {
				yaml = {
					validate = true,
					completion = true,
				},
			},
		})

		-- sql
		vim.lsp.config("sqlls", {})

		-- json
		vim.lsp.config("jsonls", {})

		-- bash
		vim.lsp.config("bashls", {})

		vim.lsp.enable("gopls")
		vim.lsp.enable("jdtls")
		vim.lsp.enable("clangd")
		vim.lsp.enable("rust_analyzer")
		vim.lsp.enable("pyright")
		vim.lsp.enable("dockerls")
		vim.lsp.enable("yamlls")
		vim.lsp.enable("sqlls")
		vim.lsp.enable("jsonls")
		vim.lsp.enable("bashls")
		vim.lsp.enable("lua_ls")
	end,
}
