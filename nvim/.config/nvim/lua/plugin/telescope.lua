local actions = require("telescope.actions")
local keyopts = { noremap = true, silent = true }

local telescope = require("telescope")
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

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

local buffers_entry_maker = function(entry)
	local res = require("telescope.make_entry").gen_from_buffer()(entry)
	res.display = function(entry_tbl)
		local icon, dir, name = refine_filename(entry_tbl.filename)
		local offset = generate_offset(tostring(entry_tbl.bufnr), 4)
		return generate_display({
			{ tostring(entry_tbl.bufnr) .. offset, "TelescopeResultsNumber" },
			{ entry_tbl.indicator, "TelescopeResultsComment" },
			icon,
			dir,
			name,
			{ " " .. tostring(entry_tbl.lnum), "TelescopeResultsLineNr" },
		})
	end
	return res
end

require("telescope").setup({
	pickers = {
		live_grep = {
			entry_maker = grep_entry_maker,
			additional_args = { "--trim" },
			prompt_title = "~ search ~",
		},
		find_files = {
			layout_config = {
				width = 0.5,
			},
			entry_maker = files_entry_maker,
			path_display = {
				shorten = 5,
			},
			prompt_title = false,
		},
		oldfiles = {
			entry_maker = files_entry_maker,
		},
		buffers = {
			entry_maker = buffers_entry_maker,
			sort_mru = true,
			mappings = {
				i = {
					["<C-q>"] = actions.delete_buffer,
				},
			},
			prompt_title = "~ buffers ~",
			previewer = false,
			path_display = { shorten = 1 },
			ignore_current_buffer = true,
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
		layout_strategy = "flex",
		layout_config = {
			prompt_position = "bottom",
			width = 0.75,
			height = 0.5,
			flex = {
				flip_columns = 200,
				flip_lines = 50,
				vertical = {
					mirror = true,
				},
				horizontal = {
					mirror = false,
				},
			},
		},
		color_devicons = false,
		file_ignore_patterns = {
			"%.jpg",
			"%.jpeg",
			"%.png",
			"%.svg",
			"%.otf",
			"%.ttf",
		},
		mappings = {
			i = {
				["<C-t>"] = require("trouble.providers.telescope").open_with_trouble,
				["<ESC>"] = actions.close,
				["<leader>ff"] = actions.close, -- Alacritty: CMD + p
				["<leader>kk"] = actions.move_selection_previous, -- Alacritty: CMD + k
				["<S-Tab>"] = actions.move_selection_previous,
				["<leader>jj"] = actions.move_selection_next, -- Alacritty: CMD + j
				["<Tab>"] = actions.move_selection_next,
				["<C-d>"] = actions.preview_scrolling_down,
				["<C-u>"] = actions.preview_scrolling_up,
				["<leader>ww"] = actions.file_vsplit, -- Alacritty: CMD + <CR>
				["<C-f>"] = actions.to_fuzzy_refine,
				["<leader>f;"] = function() end,
			},
		},
		prompt_prefix = " ",
		selection_caret = " ",
	},
})
