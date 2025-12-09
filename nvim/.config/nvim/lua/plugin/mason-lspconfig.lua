local language_servers = require("plugin.lsp").language_servers

require("mason-lspconfig").setup({
    automatic_enable = false,
    ensure_installed = language_servers
})
