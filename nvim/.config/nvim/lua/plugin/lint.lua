local lint = require("lint")

local js_filetypes = {
  "javascript",
  "typescript",
  "javascriptreact",
  "typescriptreact",
}

for _, v in pairs(js_filetypes) do
  lint.linters_by_ft[v] = { "eslint_d" }
end

vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
  callback = function()
    local ok, msg = pcall(lint.try_lint)
    if not ok then
      vim.notify(msg, vim.log.levels.WARN, { title = "Nvim-Lint" })
    end
  end,
})
