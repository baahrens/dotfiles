local null_ls = require'null-ls'

local formatter = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local actions = null_ls.builtins.code_actions

require("null-ls").setup({
  sources = {
    formatter.stylua,
    formatter.prettier.with({
      prefer_local = "node_modules/.bin"
    }),

    diagnostics.shellcheck,
    diagnostics.hadolint,
    diagnostics.yamllint,
    diagnostics.eslint_d,

    actions.eslint_d,
    actions.gitsigns
  },
  on_attach = function(client)
    if client.resolved_capabilities.document_formatting then
      vim.cmd([[
        augroup LspFormatting
          autocmd! * <buffer>
          autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
        augroup END
      ]])
    end
  end
})
