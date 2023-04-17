local ls = require("luasnip")
local partial = require("luasnip.extras").partial

return {
	ls.s("time", partial(vim.fn.strftime, "%H:%M:%S")),
	ls.s("date", partial(vim.fn.strftime, "%d.%m.%Y")),
}
