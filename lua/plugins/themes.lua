return {
    {
        'bluz71/vim-nightfly-colors',
        name = "nightfly",
        lazy = false,
        priority = 1000,
        config = function()
            local nightfly = require("nightfly")

            -- 1. Apply custom colors BEFORE anything else
            nightfly.custom_colors({
                bg     = "#161616",
                violet = "#ff74b8",
                purple = "#c693ff",
                tan    = "#ff9b42",
            })

            -- 2. Define the Autocmd BEFORE calling the colorscheme
            local custom_highlight = vim.api.nvim_create_augroup("CustomHighlight", { clear = true })
            vim.api.nvim_create_autocmd("ColorScheme", {
                pattern = "nightfly",
                callback = function()
                    local colors = nightfly.palette
                    -- Highlight for the UFO plugin or other overrides
                    vim.api.nvim_set_hl(0, "FoldColumn", { bg = colors.bg, fg = colors.purple })
                end,
                group = custom_highlight,
            })

            -- 3. Load the theme
            -- nightfly.style() is usually not needed if you just call colorscheme
            vim.cmd [[colorscheme nightfly]]
        end
    }
}
