return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { { 'nvim-lua/plenary.nvim' } },
    config = function()
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
        vim.keymap.set('n', '<C-p>', builtin.git_files, {})
        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)
        vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})

        vim.keymap.set('n', '<leader>fb', function()
            builtin.buffers({
                sort_mru = true, ignore_current_buffer = true
            })
        end)

        require("telescope").setup({
            defaults = {
                file_ignore_patterns = {
                    "node_modules",
                    "build",
                    "%.svelte-kit",
                    "%.min.js",
                    "dist",
                },
                layout_config = {
                    prompt_position = 'top',
                },
                sorting_strategy = 'ascending',
            },
            pickers = {
                find_files = {
                    find_command = {
                        'fd',
                        '--type',
                        'f',
                        '--no-ignore-vcs',
                        '--color=never',
                        '--hidden',
                        '--follow',
                        '-E',
                        '.git',
                        '-E',
                        'node_modules/*',
                        '-E',
                        'build',
                        '-E',
                        '.svelte-kit',
                        '-E',
                        '.min.js',
                        '-E',
                        'dist/*',
                    }
                },
                live_grep = {
                    additional_args = function()
                        return {
                            '--hidden',
                            '--glob',
                            '!.git',
                            '--glob',
                            '!node_modules/*',
                            '--glob',
                            '!build',
                            '--glob',
                            '!.svelte-kit',
                            '--glob',
                            '!.min.js',
                            '-glob',
                            '!dist/*',
                            -- Make search case insensitive
                            '-i',
                        }
                    end
                },
                grep_string = {
                    additional_args = function()
                        return {
                            '--hidden',
                            '--glob',
                            '!.git',
                            '--glob',
                            '!node_modules/*',
                            '--glob',
                            '!build',
                            '--glob',
                            '!.svelte-kit',
                            '--glob',
                            '!.min.js',
                            '--glob',
                            '!dist/*',
                            -- Make search case insensitive
                            '-i',
                        }
                    end
                },
            },
        })
    end
}
