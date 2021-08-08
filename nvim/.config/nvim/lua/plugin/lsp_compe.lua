require'compe'.setup {
  documentation = {
    border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
    winhighlight = 'NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder',
    max_width = math.floor(vim.o.columns * 0.5),
    min_width = math.floor(vim.o.columns * 0.2),
    max_height = math.floor(vim.o.lines * 0.3),
    min_height = 1,
  },
  source = {
    path = true;
    buffer = { kind = "   (Buffer)", true },
    calc = true;
    luasnip = true;
    nvim_lsp = true;
    nvim_lua = true;
    treesitter = true;
    snippets_nvim = true;
    emoji = { kind = " ﲃ  (Emoji)", filetypes = { "markdown", "text" } };
  };
}

vim.lsp.protocol.CompletionItemKind = {
  '   (Text) ',
  '   (Method)',
  '   (Function)',
  '   (Constructor)',
  ' ﴲ  (Field)',
  '[] (Variable)',
  '   (Class)',
  ' ﰮ  (Interface)',
  '   (Module)',
  ' 襁 (Property)',
  '   (Unit)',
  '   (Value)',
  ' 練 (Enum)',
  '   (Keyword)',
  '   (Snippet)',
  '   (Color)',
  '   (File)',
  '   (Reference)',
  '   (Folder)',
  '   (EnumMember)',
  ' ﲀ  (Constant)',
  ' ﳤ  (Struct)',
  '   (Event)',
  '   (Operator)',
  '   (TypeParameter)',
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
  local col = vim.fn.col('.') - 1
  if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
      return true
  else
      return false
  end
end

_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif require("luasnip").expand_or_jumpable() then
    return t "<cmd>lua require'luasnip'.jump(1)<Cr>"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn["compe#complete"]()
  end
end

_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif require("luasnip").jumpable(-1) then
    return t "<cmd>lua require'luasnip'.jump(-1)<CR>"
  else
    return t "<S-Tab>"
  end
end
