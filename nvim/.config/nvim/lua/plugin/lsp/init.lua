local cmd = vim.cmd

vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    virtual_text = {
      prefix = "",
      spacing = 0,
      severity_limit = "Warning"
    },
    signs = true,
    underline = true,

    update_in_insert = false
  }
)


local M = {}

function M.on_attach(client)
  cmd('autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()')
  cmd('autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()')
  cmd('autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()')

  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_exec([[
      augroup LspAutocommands
        autocmd! * <buffer>
        autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()
      augroup END
      ]], true)
  end
end


cmd [[
  sign define LspDiagnosticsSignError text=🩸 linehl= numhl=
  sign define LspDiagnosticsSignWarning text=⚠️ linehl= numhl=
]]

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

return M
