require("tiny-inline-diagnostic").setup({
    preset = "simple",
    options = {
        show_code = false,
        use_icons_from_diagnostic = true,
        multilines = {
            enabled = true,
            always_show = true
        },
        add_messages = {
            messages = true,           -- Show full diagnostic messages
            display_count = true,     -- Show diagnostic count instead of messages when cursor not on line
            use_max_severity = false,  -- When counting, only show the most severe diagnostic
            show_multiple_glyphs = false, -- Show multiple icons for multiple diagnostics of same severity
        },
        break_line = {
            enabled = true,
            after = 60,                -- Number of characters before inserting a line break
        },
    }
})
