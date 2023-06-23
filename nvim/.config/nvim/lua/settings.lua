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
		prettier = true,
		eslint = false,
	},
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

local function notify(msg, enabled)
	vim.notify(msg .. " " .. (enabled and "enabled" or "disabled"))
end

function M.toggle_format_on_save()
	M.format.on_save = not M.format.on_save
	notify("Formatting on save", M.format.on_save)
end

function M.toggle_format_prettier()
  local null_ls = require("null-ls")

	M.format.prettier = not M.format.prettier
	if M.format.prettier then
		null_ls.register(null_ls.builtins.formatting.prettierd)
	else
		null_ls.deregister("prettierd")
	end
	notify("Formatting with prettier", M.format.prettier)
end

function M.toggle_format_eslint()
  local null_ls = require("null-ls")

	M.format.eslint = not M.format.eslint
	if M.format.eslint then
		null_ls.register(null_ls.builtins.formatting.eslint_d)
	else
		null_ls.deregister("eslint_d")
	end
	notify("Formatting with eslint", M.format.eslint)
end

function M.toggle_diagnostic_underline()
	M.diagnostics.show_underline = not M.diagnostics.show_underline
	vim.diagnostic.config({
		underline = M.diagnostics.show_underline,
	})
	notify("Diagnostic underlines", M.diagnostics.show_underline)
end

function M.toggle_diagnostic_virtual()
	M.diagnostics.show_virtual = not M.diagnostics.show_virtual
	vim.diagnostic.config({
		virtual_text = M.diagnostics.show_virtual and M.diagnostics.virtual_text or false,
	})
	notify("Diagnostic virtual", M.diagnostics.show_virtual)
end

return M
