return {
    -- {
    --     "baliestri/aura-theme",
    --     lazy = false,
    --     priority = 1000,
    --     config = function(plugin)
    --         vim.opt.rtp:append(plugin.dir .. "/packages/neovim")
    --         vim.cmd([[colorscheme aura-dark]])
    --     end
    -- },
    -- {
    --     "EdenEast/nightfox.nvim",
    --     config = function()
    --         -- require('nightfox').load()
    --         -- vim.cmd [[colorscheme carbonfox]]
    --     end
    --
    -- },
    -- {
    --     "rafamadriz/neon",
    --     config = function()
    --         vim.g.neon_style = "dark"
    --         -- vim.cmd [[colorscheme neon]]
    --     end
    -- },
    -- {
    --     'olivercederborg/poimandres.nvim',
    --     lazy = false,
    --     priority = 1000,
    --     config = function()
    --         require('poimandres').setup {}
    --     end,
    --     init = function()
    --         -- vim.cmd("colorscheme poimandres")
    --     end
    -- },
    --
    -- {
    --     "bluz71/vim-moonfly-colors",
    --     name = "moonfly",
    --     lazy = false,
    --     priority = 1000,
    --     config = function()
    --         -- vim.cmd [[colorscheme moonfly]]
    --     end
    -- },
    {
        'bluz71/vim-nightfly-colors',
        lazy = false,
        priority = 1000,
        config = function()
            require("nightfly").custom_colors({
                bg     = "#161616",
                violet = "#ff74b8",
                purple = "#c693ff",
                -- theme.palette.tan    = "#00c1bb",
                tan    = "#ff9b42",
            })

            local theme            = require("nightfly")
            local colors           = theme.palette

            local custom_highlight = vim.api.nvim_create_augroup("CustomHighlight", {})

            vim.api.nvim_create_autocmd("ColorScheme", {
                pattern = "nightfly",
                callback = function()
                    -- Hightlight for the UFO plugin
                    vim.api.nvim_set_hl(0, "FoldColumn", { bg = colors.bg, fg = colors.purple }) -- Example for fold column
                end,
                group = custom_highlight,
            })
            theme.style()
            vim.cmd [[colorscheme nightfly]]
        end
    }
    -- {
    --     "oxfist/night-owl.nvim",
    --     lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    --     priority = 1000, -- make sure to load this before all the other start plugins
    --     config = function()
    --         -- load the colorscheme here
    --         require("night-owl").setup()
    --         vim.cmd.colorscheme("night-owl")
    --     end,
    -- }
    -- {
    --     "folke/tokyonight.nvim",
    --     lazy = false,
    --     priority = 1000,
    --     opts = {},
    -- },
    -- {
    --     "nyoom-engineering/oxocarbon.nvim",
    --     priority = 1000,
    --     lazy = false,
    --     config = function()
    --         vim.cmd [[colorscheme oxocarbon]]
    --     end
    -- },
    -- {
    --     'shaunsingh/moonlight.nvim',
    --     priority = 1000,
    --     lazy = false,
    --     config = function()
    --         vim.cmd [[colorscheme moonlight]]
    --     end
    -- }

}
