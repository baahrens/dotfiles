local lsp = require("plugin/lsp")

require("lspconfig").lua_ls.setup({
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
			telemetry = {
				enable = false,
			},
		},
	},
	capabilities = lsp.capabilities,
	on_attach = function(client)
		client.server_capabilities.document_formatting = false
		client.server_capabilities.document_range_formatting = false

		lsp.on_attach(client)
	end,
})
