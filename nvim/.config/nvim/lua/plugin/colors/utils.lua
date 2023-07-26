local M = {}

function M.overwrite_hl_groups(groups)
	for group, spec in pairs(groups) do
		vim.api.nvim_set_hl(0, group, spec)
	end
end

function M.is_macos()
	return vim.loop.os_uname().sysname == "Darwin"
end

local dotfile_path
local alacritty_path
local escaped_alacritty_path

if M.is_macos() then
	dotfile_path = "~/.dotfiles"
	alacritty_path = dotfile_path .. "/alacritty/.config/alacritty/alacritty.yml"
	escaped_alacritty_path = [[~\/\.dotfiles\/alacritty\/\.config\/alacritty\/]]
else
	dotfile_path = "~/dotfiles"
	alacritty_path = dotfile_path .. "/alacritty_linux/.config/alacritty/alacritty.yml"
	escaped_alacritty_path = [[~\/dotfiles\/alacritty_linux\/\.config\/alacritty\/]]
end

-- taken from folke/tokyonight.nvim
-- https://github.com/folke/tokyonight.nvim/blob/main/lua/tokyonight/util.lua
local function hexToRgb(c)
	c = string.lower(c)
	return { tonumber(c:sub(2, 3), 16), tonumber(c:sub(4, 5), 16), tonumber(c:sub(6, 7), 16) }
end

function M.blend(foreground, background, alpha)
	alpha = type(alpha) == "string" and (tonumber(alpha, 16) / 0xff) or alpha
	local bg = hexToRgb(background)
	local fg = hexToRgb(foreground)

	local blendChannel = function(i)
		local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
		return math.floor(math.min(math.max(0, ret), 255) + 0.5)
	end

	return string.format("#%02x%02x%02x", blendChannel(1), blendChannel(2), blendChannel(3))
end

function M.darken(hex, amount, bg)
	return M.blend(hex, bg or "#000000", amount)
end

function M.lighten(hex, amount, fg)
	return M.blend(hex, fg or M.fg, amount)
end

local function set_tmux_colors(color)
	vim.fn.system([[fish -c 'set -Ux BACKGROUND_COLOR "]] .. color .. [["']])
	vim.fn.system([[tmux set-environment -g "BACKGROUND_COLOR" "]] .. color .. '"')
	vim.fn.system("tmux source-file" .. " " .. dotfile_path .. "/tmux/.tmux.conf")
end

local function set_alacritty_theme(name)
	vim.fn.system("sed -i '' '2s/.*/  - " .. escaped_alacritty_path .. name .. ".yml/'" .. " " .. alacritty_path)
end

local function load_theme_config(name) end

local function set_theme_env(name)
	vim.fn.system([[fish -c 'set -Ux THEME "]] .. name .. [["']])
end

local themes = {
	tokyonight = {
		bg = "#1a1b26",
		alacritty_theme = "tokyonight",
	},
	mellifluous = {
		bg = "#1a1a1a",
		alacritty_theme = "everforest",
	},
	duskfox = {
		bg = "#1b1f32",
		alacritty_theme = "duskfox",
	},
	base2tone_drawbridge_dark = {
		bg = "#1b1f32",
		alacritty_theme = "duskfox",
	},
	["no-clown-fiesta"] = {
		bg = "#151515",
		alacritty_theme = "clown",
	},
	nord = {
		bg = "#373e4d",
		alacritty_theme = "nord",
	},
}

function M.set_colorscheme(colorscheme)
	local theme_name = colorscheme or vim.fn.getenv("THEME")
	if theme_name == vim.NIL then
		theme_name = "duskfox"
	end

	local conf = themes[theme_name]
	if not conf then
		return
	end

	-- if a colorscheme is passed, this is not the initial colorscheme load
	-- so we need to set all the themes
	if colorscheme then
		set_theme_env(theme_name)
		set_tmux_colors(conf.bg)
		set_alacritty_theme(conf.alacritty_theme)
	end

	local ok, colorscheme_conf = pcall(require, "plugin/colors/" .. theme_name)
	if not ok then
		print("Error loading colorscheme config: " .. theme_name)
		print(colorscheme_conf)
		return
	end

	-- setup colorscheme if needed
	if colorscheme_conf.setup then
		colorscheme_conf.setup()
	end

	vim.cmd("colorscheme" .. " " .. theme_name)

	M.overwrite_hl_groups(colorscheme_conf.highlight_overwrites or {})
end

return M
