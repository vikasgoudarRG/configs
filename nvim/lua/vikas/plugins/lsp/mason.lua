return {
	"williamboman/mason.nvim",
	lazy = false,
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"neovim/nvim-lspconfig",
	},
	config = function()
		-- import mason and mason_lspconfig
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		-- NOTE: Moved these local imports below back to lspconfig.lua due to mason depracated handlers

		-- local lspconfig = require("lspconfig")
		-- local cmp_nvim_lsp = require("cmp_nvim_lsp")             -- import cmp-nvim-lsp plugin
		-- local capabilities = cmp_nvim_lsp.default_capabilities() -- used to enable autocompletion (assign to every lsp server config)

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			automatic_enable = false,
			-- servers for mason to install

			ensure_installed = {
				-- Core backend languages
				"gopls",
				"jdtls",
				"clangd",
				"rust_analyzer",
				"pyright",

				-- DevOps / infra
				"dockerls",
				"yamlls",

				-- Contracts / APIs
				"buf_ls", -- Protobuf (modern)
				-- or "protols" / "protobuf-language-server"

				-- Databases / data
				"sqlls",
				"jsonls",

				-- Scripting
				"bashls",

				-- Keep Lua for Neovim
				"lua_ls",
			},
		})

		mason_tool_installer.setup({

			ensure_installed = {
				-- Go
				"gofumpt",
				"goimports",

				-- Python
				"black",
				"isort",
				"pylint",

				-- C/C++
				"clang-format",

				-- Rust
				"rustfmt",

				-- Java
				"google-java-format",

				-- General
				"prettier", -- for json/yaml/markdown
				"stylua",
			},
			-- NOTE: mason BREAKING Change! Removed setup_handlers
			-- moved lsp configuration settings back into lspconfig.lua file
		})
	end,
}
