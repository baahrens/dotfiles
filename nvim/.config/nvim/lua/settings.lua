local null_ls = require("null-ls")

local BORDER = {
	{ "╭", "CmpBorder" },
	{ "─", "CmpBorder" },
	{ "╮", "CmpBorder" },
	{ "│", "CmpBorder" },
	{ "╯", "CmpBorder" },
	{ "─", "CmpBorder" },
	{ "╰", "CmpBorder" },
	{ "│", "CmpBorder" },
}

local M = {
	format = {
		on_save = true,
		prettier = false,
		eslint = true,
	},
	autoformat = true,
	border = BORDER,
	diagnostics = {
		show_underline = true,
		show_virtual = true,
		virtual_text = {
			spacing = 4,
			prefix = "●",
			severity = {
				min = vim.diagnostic.severity.ERROR,
				max = vim.diagnostic.severity.ERROR,
			},
		},
		signs = {
			Error = " ",
			Warn = " ",
			Hint = " ",
			Info = " ",
		},
	},
}

function M.toggle_format_on_save()
	M.format.on_save = not M.format.on_save
	vim.notify("Formatting on save " .. (M.format.on_save and "on" or "off"))
end

function M.toggle_format_prettier()
	M.format.prettier = not M.format.prettier
	if M.format.prettier then
		null_ls.register(null_ls.builtins.formatting.prettierd)
	else
		null_ls.deregister("prettierd")
	end
	vim.notify("Formatting with prettier " .. (M.format.prettier and "on" or "off"))
end

function M.toggle_format_eslint()
	M.format.eslint = not M.format.eslint
	if M.format.eslint then
		null_ls.register(null_ls.builtins.formatting.eslint_d)
	else
		null_ls.deregister("eslint_d")
	end
	vim.notify("Formatting with eslint " .. (M.format.eslint and "on" or "off"))
end

function M.toggle_diagnostic_underline()
	M.diagnostics.show_underline = not M.diagnostics.show_underline
	vim.diagnostic.config({
		underline = M.diagnostics.show_underline,
	})
	vim.notify("Diagnostic underlines " .. (M.diagnostics.show_underline and "on" or "off"))
end

function M.toggle_diagnostic_virtual()
	M.diagnostics.show_virtual = not M.diagnostics.show_virtual
	vim.diagnostic.config({
		virtual_text = M.diagnostics.show_virtual and M.diagnostics.virtual_text or false,
	})
	vim.notify("Diagnostic virtual " .. (M.diagnostics.show_virtual and "on" or "off"))
end

return M
