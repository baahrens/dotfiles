local toggleterm = require'toggleterm'
local Terminal = require'toggleterm.terminal'.Terminal

local function set_close_keymap(bufnr, cmd)
  vim.api.nvim_buf_set_keymap(bufnr, "t", cmd, "<cmd>close<CR>", { noremap = true, silent = true })
end

toggleterm.setup {
  open_mapping = [[<c-\>]],
  shell = "/usr/local/bin/fish",
  direction = "float",
}

local test_term = Terminal:new({
  cmd = "yarn test --watch",
  dir = "git_dir",
  on_open = function(term)
    set_close_keymap(term.bufnr, "<leader>tt")
  end
})

local node_term = Terminal:new({
  cmd = "node",
  on_open = function(term)
    set_close_keymap(term.bufnr, "<leader>tn")
  end
})

local cheat_term = Terminal:new({
  cmd = "cht.sh --shell",
  on_open = function(term)
    set_close_keymap(term.bufnr, "<leader>th")
  end
})

local M = {}

function M.toggle_test_term()
  test_term:toggle()
end

function M.toggle_cheat_term()
  cheat_term:toggle()
end

function M.toggle_node_term()
  node_term:toggle()
end

return M
