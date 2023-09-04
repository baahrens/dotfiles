local lsp = require("plugin/lsp")

require("typescript-tools").setup({
  on_attach = function(client)
    client.server_capabilities.document_formatting = false
    client.server_capabilities.document_range_formatting = false

    require("util").remap("n", "gd", "<cmd>TSToolsGoToSourceDefinition<CR>", { noremap = true, silent = true })
    lsp.on_attach(client)
  end,
  settings = {
    separate_diagnostic_server = true,
    publish_diagnostic_on = "insert_leave",
    expose_as_code_action = { "fix_all", "add_missing_imports", "remove_unused" },
    tsserver_path = nil,
    tsserver_plugins = {},
    tsserver_max_memory = "auto",
    tsserver_format_options = {},
    tsserver_file_preferences = {},
    complete_function_calls = false,
  },
})
