local mappings = require("mappings")
local u = require("util")
local cmp = require("cmp")

local kind_icons = {
  Text = "",
  Method = "󰆧",
  Function = "󰊕",
  Constructor = "",
  Field = "󰇽",
  Variable = "󰫧",
  Class = "󰠱",
  Interface = "",
  Module = "",
  Property = "󰜢",
  Unit = "",
  Value = "󰎠",
  Enum = "",
  Keyword = "󰌋",
  Snippet = "",
  Color = "󰏘",
  File = "󰈙",
  Reference = "",
  Folder = "󰉋",
  EnumMember = "",
  Constant = "󰏿",
  Struct = "",
  Event = "",
  Operator = "󰆕",
  TypeParameter = "󰅲",
}

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

cmp.setup({
  window = {
    completion = {
      border = BORDER,
    },
    documentation = {
      border = BORDER,
    },
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(_, vim_item)
      vim_item.menu = "    " .. "[" .. vim_item.kind .. "]"
      vim_item.kind = kind_icons[vim_item.kind] .. "  "

      return vim_item
    end,
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    [u.common_mappings.scroll_up] = cmp.mapping.scroll_docs(-4),
    [u.common_mappings.scroll_down] = cmp.mapping.scroll_docs(4),
    ["<C-s>"] = cmp.mapping.close(),
    ["<C-a>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    }),
    [u.common_mappings.select_prev] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    [u.common_mappings.select_next] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif require("luasnip").expand_or_locally_jumpable() then
        require("luasnip").expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif require("luasnip").jumpable(-1) then
        require("luasnip").jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    {
      name = "nvim_lsp",
      max_item_count = 50,
      priority = 4,
      keyword_length = 2,
    },
    { name = "nvim_lua" },
    { name = "nvim_lsp_signature_help", priority = 2 },
    { name = "luasnip", priority = 3 },
    { name = "buffer", priority = 1, keyword_length = 4 },
    { name = "path", priority = 1 },
  }),
  performance = {
    debounce = 200,
  },
  experimental = {
    native_menu = false,
    ghost_text = true,
  },
})

cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "buffer" },
  }),
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})
