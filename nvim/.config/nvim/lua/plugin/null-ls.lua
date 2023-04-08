local null_ls = require("null-ls")
local settings = require("settings")
local lsp = require("plugin/lsp")

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local actions = null_ls.builtins.code_actions

require("null-ls").setup({
	sources = {
		formatting.stylua,
		settings.format.eslint and formatting.eslint_d or nil,
		settings.format.prettier and formatting.prettierd or nil,
		formatting.fish_indent,

		diagnostics.eslint_d,
		diagnostics.fish,

		actions.eslint_d,
		actions.gitsigns,
	},
	flags = {
		debounce_text_changes = 200,
	},
	on_attach = function(client)
		client.server_capabilities.document_formatting = true
		client.server_capabilities.document_range_formatting = true

		lsp.on_attach(client)
	end,
})
