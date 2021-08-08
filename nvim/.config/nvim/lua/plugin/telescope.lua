local actions = require'telescope.actions'

require'telescope'.setup({
  extensions = { fzy_native = { override_generic_sorter = false, override_file_sorter = true } },
  defaults = {
    mappings = {
      i = {
        ["<C-t>"] = require'trouble.providers.telescope'.open_with_trouble,
        ["<ESC>"] = actions.close,
        ["<leader>ff"] = actions.close,
        ["<leader>kk"] = actions.move_selection_previous,
        ["<leader>jj"] = actions.move_selection_next,
        ["<CR>"] = actions.select_default + actions.center,
        ["<leader>ww"] = actions.file_vsplit
      }
    },
    prompt_prefix = " ",
    selection_caret = " ",
    winblend = 10
  },
})

require'telescope'.load_extension("fzy_native")

M = {}

function M.find_files()
  return require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({
    prompt_title = '~ files ~',
    previewer = false,
    path_display = {
      shorten = 5
    }
  }))
end

function M.live_grep()
  return require'telescope.builtin'.live_grep({
    prompt_title = '~ search ~'
  })
end

function M.find_dotfiles()
  return require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({
    find_command = {'rg', '--files', '--hidden', '-g', '!.git' },
    cwd = '~/.dotfiles',
    prompt_title = '~ dotfiles ~',
    previewer = false
  }))
end

function M.find_help()
  return require'telescope.builtin'.help_tags(require('telescope.themes').get_ivy({
    prompt_title = '~ help ~'
  }))
end

function M.find_mappings()
  return require'telescope.builtin'.keymaps(require'telescope.themes'.get_ivy({
    prompt_title = '~ mappings ~'
  }))
end

function M.find_commands()
  return require'telescope.builtin'.commands(require'telescope.themes'.get_ivy({
    prompt_title = '~ commands ~'
  }))
end

function M.find_highlights()
  return require'telescope.builtin'.highlights(require'telescope.themes'.get_ivy({
    prompt_title = '~ highlights ~',
    previewer = false
  }))
end

function M.find_buffers()
  return require'telescope.builtin'.buffers(require'telescope.themes'.get_dropdown({
    prompt_title = '~ buffers ~',
    sort_mru = true,
    previewer = false,
    path_display = {
      shorten = 1
    }
  }))
end

function M.current_buffer_fuzzy_find()
  return require'telescope.builtin'.current_buffer_fuzzy_find(require'telescope.themes'.get_dropdown({
    prompt_title = '~ search ~',
    previewer = false,
  }))
end

return M
