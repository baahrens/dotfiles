local lsp = require("plugin/lsp")

require("lspconfig").cssls.setup({
	capabilities = lsp.capabilities,
	on_attach = function(client)
		client.server_capabilities.document_formatting = true
		client.server_capabilities.document_range_formatting = true

		lsp.on_attach(client)
	end,
})
