local colors = {
    -- StatusLine background color.
    color0 = '#161616',

    -- Mode colors.
    color1 = '#82aaff',
    color2 = '#21c7a8',
    color3 = '#ae81ff',
    color4 = '#ecc48d',
    color5 = '#ff5874',

    -- Mode text color.
    color6 = '#092236',

    -- StatusLineNC foreground.
    color7 = '#a1aab8',

    -- Normal text color.
    color8 = '#c3ccdc',
}

-- LuaFormatter on
local theme = {
    normal = {
        a = { fg = colors.color6, bg = colors.color1 },
        b = { fg = colors.color1, bg = colors.color0 },
        c = { fg = colors.color8, bg = colors.color0 }
    },
    insert = {
        a = { fg = colors.color6, bg = colors.color2 },
        b = { fg = colors.color2, bg = colors.color0 }
    },
    visual = {
        a = { fg = colors.color6, bg = colors.color3 },
        b = { fg = colors.color3, bg = colors.color0 }
    },
    command = {
        a = { fg = colors.color6, bg = colors.color4 },
        b = { fg = colors.color4, bg = colors.color0 }
    },
    replace = {
        a = { fg = colors.color6, bg = colors.color5 },
        b = { fg = colors.color5, bg = colors.color0 }
    },
    inactive = {
        a = { fg = colors.color7, bg = colors.color0 },
        b = { fg = colors.color7, bg = colors.color0 },
        c = { fg = colors.color7, bg = colors.color0 }
    },
}
return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },
    config = function()
        local git_blame = require('gitblame')
        require('lualine').setup {
            options = {
                theme = theme,
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
    end

}
