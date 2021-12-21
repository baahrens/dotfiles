local null_ls = require'null-ls'

local formatter = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local actions = null_ls.builtins.code_actions

require("null-ls").setup({
  sources = {
    formatter.stylua,
    formatter.prettier,

    diagnostics.shellcheck,
    diagnostics.hadolint,
    diagnostics.yamllint,
    diagnostics.eslint_d,

    actions.eslint_d,
    actions.gitsigns
  }
})
