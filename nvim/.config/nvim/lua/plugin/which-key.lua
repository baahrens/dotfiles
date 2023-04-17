require("which-key").setup({
	presets = {
		operators = false, -- adds help for operators like d, y, ...
		motions = false, -- adds help for motions
		text_objects = false, -- help for text objects triggered after entering an operator
		windows = false, -- default bindings on <c-w>
		nav = false, -- misc bindings to work with windows
		z = false, -- bindings for folds, spelling and others prefixed with z
		g = false, -- bindings for prefixed with g
	},
	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 3, -- spacing between columns
		align = "left", -- align columns left, center or right
	},
})
