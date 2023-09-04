local null_ls = require("null-ls")
local settings = require("settings")

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local actions = null_ls.builtins.code_actions

null_ls.setup({
	debug = true,
	sources = {
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

		require("plugin/lsp").on_attach(client)
	end,
})

if settings.format.prettier then
	null_ls.register(null_ls.builtins.formatting.prettierd)
end

if settings.format.eslint then
	null_ls.register(null_ls.builtins.formatting.eslint_d)
end
