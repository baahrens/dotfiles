local settings = require("settings")

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = settings.border })
vim.lsp.handlers["textDocument/signatureHelp"] =
	vim.lsp.with(vim.lsp.handlers.signature_help, { border = settings.border })
vim.lsp.handlers["textDocument/references"] = require("telescope.builtin").lsp_references

local M = {}

for type, icon in pairs(settings.diagnostics.signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local format_clients = {
	"null-ls",
	"prismals",
	"rust_analyzer",
}

function M.format()
	vim.lsp.buf.format({
		filter = function(lsp_client)
			return vim.tbl_contains(format_clients, lsp_client.name)
		end,
	})
end

function M.on_attach(client, bufnr)
	local formatting_augroup = vim.api.nvim_create_augroup("Formatting", { clear = true })
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = formatting_augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = formatting_augroup,
			buffer = bufnr,
			callback = function()
				if settings.format.on_save then
					M.format()
				end
			end,
		})
	end
end

M.capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.diagnostic.config({
	virtual_text = settings.diagnostics.virtual_text,
	float = { border = settings.border, source = true },
	signs = true,
	update_in_insert = false,
	severity_sort = true,
})

return M
