local xeno = require("xeno")

xeno.color('aurora', '#3ddc97')
xeno.color('teal', '#2ec4b6')
xeno.color('cyan', '#4fd9e8')
xeno.color('ice', '#8ecae6')
xeno.color('frost', '#a8e6cf')
xeno.color('violet', '#9b7fd4')
xeno.color('indigo', '#7c93e0')
xeno.color('glow_pink', '#e39fc2')

xeno.theme('polarized', {
  background = '#0a141c',
  accent = '#3ddc97',
  foreground = '#c9dde2',
  properties = {
    contrast = 0.10,
    chroma = 0.05,
    lightness = -0.05,
    variation = 0.10,
  },

  highlights = {
    editor = {
      CursorLineNr = { fg = '@frost.100', bold = true },
      MatchParen = { fg = '@frost.100', bold = true },
      Visual = { bg = xeno.opaque('@aurora.500', 0.18) },
      CursorLine = { bg = xeno.opaque('@teal.600', 0.06) },
      Search = { bg = xeno.opaque('@cyan.400', 0.25), fg = '@foreground.50' },
      IncSearch = { bg = xeno.opaque('@frost.300', 0.35), fg = '@background.950' },
    },

    syntax = {
      Comment = { fg = '@foreground.400', italic = true },
      Keyword = { fg = '@violet.300' },
      Conditional = { fg = '@indigo.300' },
      Function = { fg = '@teal.300' },
      Type = { fg = '@cyan.200' },
      String = { fg = '@aurora.100' },
      Number = { fg = '@frost.100' },
      Boolean = { fg = '@frost.100' },
      Variable = { fg = '@foreground.300' },
      Property = { fg = '@ice.300' },
      Operator = { fg = '@cyan.300' },
      Punctuation = { fg = '@foreground.400' },

      ['@keyword'] = { link = 'Keyword' },
      ['@keyword.return'] = { link = 'Keyword' },
      ['@keyword.function'] = { link = 'Conditional' },
      ['@keyword.conditional'] = { link = 'Conditional' },
      ['@keyword.repeat'] = { link = 'Conditional' },
      ['@keyword.operator'] = { fg = '@cyan.300' },
      ['@keyword.import'] = { fg = '@teal.400' },

      ['@function'] = { link = 'Function' },
      ['@function.builtin'] = { fg = '@cyan.100' },

      ['@type'] = { link = 'Type' },

      ['@string'] = { link = 'String' },
      ['@string.escape'] = { fg = '@ice.100' },

      ['@number'] = { link = 'Number' },
      ['@boolean'] = { link = 'Boolean' },

      ['@constant'] = { fg = '@frost.200' },
      ['@constant.builtin'] = { fg = '@glow_pink.100', bold = true },

      ['@variable'] = { link = 'Variable' },
      ['@variable.builtin'] = { fg = '@indigo.200' },

      ['@property'] = { link = 'Property' },

      ['@constructor'] = { fg = '@foreground.400' },

      ['@operator'] = { link = 'Operator' },
      ['@punctuation'] = { link = 'Punctuation' },
      ['@punctuation.bracket'] = { link = 'Punctuation' },
      ['@punctuation.delimiter'] = { link = 'Punctuation' },

      ['@lsp.type.variable'] = { link = '@variable' },
      ['@lsp.type.property'] = { link = '@property' },
      ['@lsp.type.function'] = { link = '@function' },
      ['@lsp.type.type'] = { link = '@type' },
      ['@lsp.type.keyword'] = { link = '@keyword' },
      ['@lsp.mod.declaration'] = { clear = true },
      ['@lsp.typemod.property.declaration'] = { link = '@property' },
    },
  },
})

xeno.color('violet', '#7d6bab')
xeno.color('iris', '#9689c4')
xeno.color('amethyst', '#a892d6')
xeno.color('mist', '#b7ace0')

xeno.color('moonlight', '#7fb8c9')
xeno.color('frost', '#9ad4de')

xeno.color('starlight', '#e8d99a')
xeno.color('gold', '#d9b968')

xeno.color('sage', '#93b98f')
xeno.color('moss', '#7a9d78')

xeno.theme('astral', {
  background = '#191622',
  accent = '#9484bd',
  foreground = '#d6d0e6',

  properties = {
    contrast = -0.10,
    variation = 0.05,
    chroma = -0.15,
    lightness = 0.00,
  },

  highlights = {
    editor = {
      CursorLineNr = { fg = '@starlight.100', bold = true },
      MatchParen = { fg = '@starlight.100', bold = true },
      Visual = { bg = xeno.opaque('@accent.500', 0.20) },
      Search = { bg = xeno.opaque('@starlight.400', 0.25), fg = '@starlight.100' },
      CursorLine = { bg = xeno.opaque('@background.600', 0.05) },
    },

    syntax = {
      Comment = { fg = '@foreground.400', italic = true },

      Keyword = { fg = '@violet.300' },
      Conditional = { fg = '@iris.300' },

      Function = { fg = '@moonlight.300' },
      Type = { fg = '@frost.200' },
      Operator = { fg = '@moonlight.400' },

      String = { fg = '@sage.100' },
      Number = { fg = '@starlight.100' },
      Boolean = { fg = '@starlight.100' },

      Variable = { fg = '@foreground.300' },
      Property = { fg = '@mist.300' },
      Punctuation = { fg = '@foreground.400' },

      ['@keyword'] = { link = 'Keyword' },
      ['@keyword.return'] = { link = 'Keyword' },
      ['@keyword.function'] = { link = 'Conditional' },
      ['@keyword.conditional'] = { link = 'Conditional' },
      ['@keyword.repeat'] = { link = 'Conditional' },
      ['@keyword.operator'] = { link = 'Operator' },
      ['@keyword.import'] = { fg = '@violet.400' },

      ['@function'] = { link = 'Function' },
      ['@function.builtin'] = { fg = '@amethyst.200' },
      ['@type'] = { link = 'Type' },
      ['@type.builtin'] = { fg = '@frost.100' },

      ['@string'] = { link = 'String' },
      ['@string.escape'] = { fg = '@gold.100' },

      ['@number'] = { link = 'Number' },
      ['@boolean'] = { link = 'Boolean' },
      ['@constant'] = { fg = '@gold.100' },
      ['@constant.builtin'] = { fg = '@starlight.100', bold = true },

      ['@variable'] = { link = 'Variable' },
      ['@variable.builtin'] = { fg = '@amethyst.200' },
      ['@property'] = { link = 'Property' },
      ['@constructor'] = { fg = '@moss.300' },

      ['@operator'] = { link = 'Operator' },
      ['@punctuation'] = { link = 'Punctuation' },
      ['@punctuation.bracket'] = { link = 'Punctuation' },
      ['@punctuation.delimiter'] = { link = 'Punctuation' },

      ['@lsp.type.variable'] = { link = '@variable' },
      ['@lsp.type.property'] = { link = '@property' },
      ['@lsp.type.function'] = { link = '@function' },
      ['@lsp.type.type'] = { link = '@type' },
      ['@lsp.type.class'] = { link = '@type' },
      ['@lsp.type.parameter'] = { link = '@variable' },
      ['@lsp.mod.declaration'] = { clear = true },
      ['@lsp.mod.readonly'] = { clear = true },
      ['@lsp.typemod.property.declaration'] = { link = '@property' },
      ['@lsp.typemod.variable.declaration'] = { link = '@variable' },
    },
  },
})

xeno.theme('sylvan', {
  background = '#151615',
  accent = '#3b594e',
  contrast = -0.3,
  variation = 0.1,
})
