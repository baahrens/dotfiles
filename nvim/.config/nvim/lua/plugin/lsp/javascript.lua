local lspconfig = require("lspconfig")
local on_attach = require ('plugin/lsp').on_attach

local javascript_filetypes = {
  ['typescript'] = true,
  ['typescriptreact'] = true,
  ['typescript.tsx'] = true,
  ['javascript'] = true,
  ['javascriptreact'] = true,
  ['javascript.tsx'] = true
}

local eslint = {
  lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
  lintStdin = true,
  lintFormats = {"%f:%l:%c: %m"},
  lintIgnoreExitCode = true,
  formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
  formatStdin = true
}

local prettier = {
  formatCommand = 'prettier --stdin-filepath ${INPUT}',
  formatStdin = true,
}

local function eslint_config_exists()
  local eslintrc = vim.fn.glob(".eslintrc*", 0, 1)

  if not vim.tbl_isempty(eslintrc) then
    return true
  end

  if vim.fn.filereadable("package.json") then
    if vim.fn.json_decode(vim.fn.readfile("package.json"))["eslintConfig"] then
      return true
    end
  end

  return false
end

lspconfig.efm.setup {
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = true
    client.resolved_capabilities.goto_definition = false
    on_attach(client)
  end,
  root_dir = function()
    if not eslint_config_exists() then
      return nil
    end
    return vim.fn.getcwd()
  end,
  settings = {
    languages = {
      css = { prettier },
      html = { prettier },
      javascript = { prettier, eslint },
      javascriptreact = { prettier, eslint },
      scss = { prettier },
      typescript = { prettier, eslint },
      typescriptreact = { prettier, eslint }
    }
  },
  filetypes = {
    'css',
    'html',
    'javascript',
    'javascriptreact',
    'scss',
    'typescript',
    'typescriptreact'
  }
}


local function start_tsserver()
  lspconfig.tsserver.setup {
    flags = {
      debounce_text_changes = 500
    },
    on_attach = function(client)
      client.resolved_capabilities.document_formatting = false
      on_attach(client)
    end,
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  }
end

local function start_flow()
  lspconfig.flow.setup {
    on_attach = function(client)
      client.resolved_capabilities.document_formatting = false
      on_attach(client)
    end,
    name = 'flow',
    cmd = { 'npx', '--no-install', 'flow', 'lsp' },
    filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx' },
    flags = {
      debounce_text_changes = 500
    },
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  }
end

local path_sep = vim.loop.os_uname().sysname == "Windows" and "\\" or "/"

local function dirname(filepath)
  local is_changed = false
  local result = filepath:gsub(path_sep.."([^"..path_sep.."]+)$", function()
    is_changed = true
    return ""
  end)
  return result, is_changed
end

local function path_join(...)
  return table.concat(vim.tbl_flatten {...}, path_sep)
end

local function buffer_find_root_dir(bufnr, is_root_path)
  local bufname = vim.api.nvim_buf_get_name(bufnr)
  if vim.fn.filereadable(bufname) == 0 then
    return nil
  end
  local dir = bufname
  for _ = 1, 100 do
    local did_change
    dir, did_change = dirname(dir)
    if is_root_path(dir, bufname) then
      return dir, bufname
    end
    -- If we can't ascend further, then stop looking.
    if not did_change then
      return nil
    end
  end
end

function check_start_javascript_lsp()
  local bufnr = vim.api.nvim_get_current_buf()

  if not javascript_filetypes[vim.api.nvim_buf_get_option(bufnr, 'filetype')] then
    return
  end

  local root_dir = buffer_find_root_dir(bufnr, function(dir)
    return vim.fn.filereadable(path_join(dir, 'package.json')) == 1
  end)

  if not root_dir then return end

  local has_flow_config = vim.fn.filereadable(path_join(root_dir, '.flowconfig')) == 1

  if has_flow_config then
    start_flow()
  else
    start_tsserver()
  end
end

vim.api.nvim_command [[autocmd BufReadPost * lua check_start_javascript_lsp()]]
