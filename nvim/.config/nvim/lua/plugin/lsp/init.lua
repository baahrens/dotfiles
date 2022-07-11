vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    virtual_text = {
      prefix = "",
      spacing = 5
    },
    signs = true,
    underline = true,
    update_in_insert = false
  }
)

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = 'rounded',
  silent = true,
  focusable = false, -- Sometimes gets set to true if not set explicitly to false for some reason
})

local M = {}

local signs = {
  Error = " ",
  Warn = " ",
  Hint = " ",
  Info = " "
}

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

function M.format_range_operator()
  local old_func = vim.go.operatorfunc
  _G.op_func_formatting = function()
    local start = vim.api.nvim_buf_get_mark(0, '[')
    local finish = vim.api.nvim_buf_get_mark(0, ']')
    vim.lsp.buf.range_formatting({}, start, finish)
    vim.go.operatorfunc = old_func
    _G.op_func_formatting = nil
  end
  vim.go.operatorfunc = 'v:lua.op_func_formatting'
  vim.api.nvim_feedkeys('g@', 'n', false)
end

function M.on_attach (client)
  if client.server_capabilities.document_formatting then
    vim.api.nvim_create_augroup('LspFormatting', {})
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = 'LspFormatting',
      pattern = '*',
      callback = function()
        vim.lsp.buf.format {
          filter = function(lsp_client)
            return lsp_client.name == "null-ls" or lsp_client.name == "prismals"
          end
        }
      end
    })
  end
end

return M
