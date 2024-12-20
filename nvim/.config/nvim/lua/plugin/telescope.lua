local u = require("util")
local actions = require("telescope.actions")
local action_set = require("telescope.actions.set")
local action_state = require("telescope.actions.state")

local generate_offset = function(str, tabsize)
  local offset = (tabsize - vim.fn.strdisplaywidth(str) % tabsize) % tabsize
  return string.rep(" ", offset)
end

local generate_display = function(pieces)
  local res_text = ""
  local res_highlight = {}
  for _, piece in ipairs(pieces) do
    local text, highlight = unpack(piece)
    if highlight ~= nil then
      table.insert(res_highlight, { { #res_text, #res_text + #text }, highlight })
    end
    res_text = res_text .. text
  end
  return res_text, res_highlight
end

local refine_filename = function(filename, cwd)
  if cwd ~= nil then
    cwd = vim.loop.cwd()
  end
  local relative_filename = require("plenary.path"):new(filename):make_relative(cwd)
  local name = relative_filename:match("[^/]*$")
  local dir = relative_filename:match("^.*/") or ""
  local icon, hl_icon = require("telescope.utils").transform_devicons(filename)
  icon = icon .. generate_offset(icon, 3)
  return { icon, hl_icon }, { dir, "TelescopeResultsSpecialComment" }, { name }
end

local lsp_entry_maker = function(entry)
  local res = require("telescope.make_entry").gen_from_quickfix()(entry)
  res.display = function(entry_tbl)
    local icon, dir, name = refine_filename(entry_tbl.filename)
    local pos = " " .. entry_tbl.lnum .. ":" .. entry_tbl.col .. "  "
    local offset = generate_offset(icon[1] .. dir[1] .. name[1] .. pos, 10)
    local trimmed_text = entry_tbl.text:gsub("^%s*(.-)%s*$", "%1")
    return generate_display({
      icon,
      dir,
      name,
      { pos, "TelescopeResultsLineNr" },
      { offset .. trimmed_text },
    })
  end
  return res
end

local files_entry_maker = function(entry)
  local res = require("telescope.make_entry").gen_from_file()(entry)
  res.display = function(entry_tbl)
    return generate_display({ refine_filename(entry_tbl[1]) })
  end
  return res
end

local grep_entry_maker = function(entry)
  local res = require("telescope.make_entry").gen_from_vimgrep()(entry)
  res.display = function(entry_tbl)
    local _, _, filename, pos, text = string.find(entry_tbl[1], "^(.*):(%d+:%d+):(.*)$")
    local icon, dir, name = refine_filename(filename)
    local offset = generate_offset(icon[1] .. dir[1] .. name[1] .. " " .. pos .. "  ", 10)
    return generate_display({
      icon,
      dir,
      name,
      { " " .. pos .. "  ", "TelescopeResultsLineNr" },
      { offset .. text },
    })
  end
  return res
end

local ignore_patterns = {
  "%.jpg",
  "%.jpeg",
  "%.png",
  "%.svg",
  "%.otf",
  "%.ttf",
  "node_modules",
  "yarn.lock",
  "package-lock.json",
  "prisma/data.db",
  "build",
  ".next/",
  "dist",
  ".git/",
}

require("telescope").setup({
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
    smart_open = {
      show_score = true,
      match_algorithm = "fzf",
      disable_devicons = false,
      open_buffer_indicators = {
        previous = "•",
        others = "∘",
      },
    },
  },
  pickers = {
    help_tags = {
      attach_mappings = function(prompt_bufnr)
        action_set.select:replace(function()
          local selection = action_state.get_selected_entry()

          actions.close(prompt_bufnr)
          vim.cmd("vert help " .. selection.value)
        end)

        return true
      end,
    },
    live_grep = {
      entry_maker = grep_entry_maker,
      additional_args = { "--trim" },
    },
    find_files = {
      no_ignore = false,
      hidden = true,
      entry_maker = files_entry_maker,
      path_display = {
        shorten = 5,
      },
    },
    lsp_references = {
      entry_maker = lsp_entry_maker,
    },
    lsp_definitions = {
      entry_maker = lsp_entry_maker,
    },
    lsp_type_definitions = {
      entry_maker = lsp_entry_maker,
    },
    lsp_implementations = {
      entry_maker = lsp_entry_maker,
    },
  },
  defaults = {
    results_title = false,
    color_devicons = false,
    file_ignore_patterns = ignore_patterns,
    mappings = {
      i = {
        [u.common_mappings.select_prev] = actions.move_selection_previous,
        [u.common_mappings.select_next] = actions.move_selection_next,
        [u.common_mappings.open_vsplit] = actions.file_vsplit,
        [u.map_cmd_alt("p")] = actions.close,
        ["<c-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<ESC>"] = actions.close,
        ["<S-Tab>"] = actions.move_selection_previous,
        ["<Tab>"] = actions.move_selection_next,
        [u.common_mappings.scroll_down] = actions.preview_scrolling_down,
        [u.common_mappings.scroll_up] = actions.preview_scrolling_up,
        ["<C-f>"] = actions.to_fuzzy_refine,
        ["<leader>f;"] = false,
      },
    },
    prompt_prefix = " ",
    selection_caret = " ",
  },
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("smart_open")
