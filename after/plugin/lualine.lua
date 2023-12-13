local git_blame = require('gitblame')


require('lualine').setup {
    options = {
        theme = 'auto',
        component_separators = "",
        section_separators = { left = "", right = "" },
    },
    sections = {
        lualine_a = {
            { "mode", separator = { left = "█", right = "" } },
        },
        lualine_b = {
            {
                "filetype",
                icon_only = true,
                padding = { left = 1, right = 0 },
            },
            "filename",
        },
        lualine_c = {
            {
                "branch",
                icon = "",
            },
            {
                "diff",
                symbols = { added = " ", modified = " ", removed = " " },
                colored = false,
            },
        },
        lualine_x = {
            {
                "diagnostics",
                symbols = { error = " ", warn = " ", info = " ", hint = "" },
                update_in_insert = true,
            },
        },
        lualine_y = {
            { git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available }
        },
        lualine_z = {
            { "location", separator = { left = "", right = "█" }, icon = "" },
        },
    },
    inactive_sections = {
        lualine_a = { "filename" },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { "location" },
    },
    extensions = { "toggleterm", "trouble" },
}
