require("mason-null-ls").setup({
	automatic_installation = true,
	ensure_installed = {
		"stylua",
		"prettierd",
		"eslint_d",
		"fish_indent",
	},
})
