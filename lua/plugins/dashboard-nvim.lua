return {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
        require('dashboard').setup {
            theme = 'hyper',
            config = {
                packages = { enable = true },
                week_header = { enable = true, },
            }

        }
    end,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } }
}
