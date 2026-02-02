local M = {}

function M.setup()
    require("silkcircuit").setup({
        dim_inactive = true,
        variant = "soft", -- Theme variant: "neon" | "vibrant" | "soft" | "glow"

        styles = {
            comments = { italic = true },
            keywords = { bold = true },
            functions = { bold = true, italic = false },
            variables = {},
            strings = { italic = true },
        },
    })
end

return M
