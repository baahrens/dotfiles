-- Disable diagnostics for node_modules
vim.api.nvim_create_autocmd(
  { "BufRead", "BufNewFile" },
  { pattern = "*/node_modules/*", command = "lua vim.diagnostic.disable(0)" }
)

local sid_cache = {}

function get_sid(file)
    file = file or "autoload/fugitive.vim"
    if sid_cache[file] then return sid_cache[file] end

    local script_entry = vim.api.nvim_exec2(
      "filter #vim-fugitive.*/" .. file .. "# scriptnames",
      { output = true }
    ).output
    sid_cache[file] = tonumber(script_entry:match("^%s*(%d+)"))

    return sid_cache[file]
  end

function call(file_or_sid, func, ...)
    local sid

    if type(file_or_sid) == "number" then
      if file_or_sid == 0 then
        sid = get_sid()
      else
        sid = file_or_sid
      end
    else
      sid = get_sid(file_or_sid)
    end

    if not sid then return end
    return vim.fn[string.format("<SNR>%d_%s", sid, func)](...)
  end

function get_status_cursor_info()
    if vim.bo.ft ~= "fugitive" then return end
    return call(0, "StageInfo", vim.api.nvim_win_get_cursor(0)[1])
end

-- These are ripped from https://github.com/sindrets/dotfiles/blob/master/.config/nvim/lua/user/plugins/fugitive.lua
vim.api.nvim_create_autocmd("FileType", {
  pattern = "fugitive",
  callback = function(ctx)
    vim.keymap.set("n", "<C-s>", function()
          local info = get_status_cursor_info()
          if info then
            if #info.paths > 0 then
              vim.cmd(string.format("DiffviewOpen --selected-file=%s", vim.fn.fnameescape(info.paths[1])))
            elseif info.commit ~= "" then
              vim.cmd(string.format("DiffviewOpen %s^!", info.commit))
            end
          end
        end, {
          buffer = ctx.buf,
          desc = "Open Diffview for the item under the cursor",
        })

    vim.keymap.set("n", "<C-f>", function()
          local info = get_status_cursor_info()
          if info then
            if #info.paths > 0 then
              vim.cmd(string.format("DiffviewFileHistory %s", vim.fn.fnameescape(info.paths[1])))
            elseif info.commit ~= "" then
              vim.cmd(string.format("DiffviewFileHistory --range=%s", info.commit))
            end
          end
        end, {
          buffer = ctx.buf,
          desc = "Open file history for the item under the cursor",
        })

  end
})
