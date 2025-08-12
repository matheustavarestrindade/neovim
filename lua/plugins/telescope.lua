return {
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = { { 'nvim-lua/plenary.nvim' } },
        config = function()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
            vim.keymap.set('n', '<C-p>', builtin.git_files, {})

            vim.keymap.set('n', '<leader>ps', function()
                local ok, input = pcall(vim.fn.input, "Grep > ")
                if ok and input ~= "" then
                    require('telescope.builtin').grep_string({ search = input })
                end
            end)
            vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})

            vim.keymap.set('n', '<leader>fb', function()
                builtin.buffers({
                    sort_mru = true, ignore_current_buffer = true
                })
            end)



            local previewers = require("telescope.previewers")
            local image_cache = {}

            local function render_image(filepath, max_width, callback)
                local key = filepath .. "|w" .. max_width

                if image_cache[key] then
                    callback(image_cache[key])
                    return
                end

                vim.fn.jobstart({
                    "chafa",
                    "--size", tostring(max_width) .. "x", -- x lets chafa pick height automatically
                    filepath
                }, {
                    stdout_buffered = true,
                    on_stdout = function(_, data, _)
                        if not data then return end
                        local output = table.concat(data, "\r\n")
                        image_cache[key] = output
                        callback(output)
                    end
                })
            end

            local function image_preview(filepath, bufnr, opts)
                local ext = vim.fn.fnamemodify(filepath, ":e"):lower()
                local is_image = vim.tbl_contains({ "png", "jpg", "jpeg", "webp", "svg" }, ext)

                if is_image then
                    local term = vim.api.nvim_open_term(bufnr, {})

                    -- Schedule to wait until buffer is displayed
                    vim.schedule(function()
                        local winid = vim.fn.bufwinid(bufnr)
                        if winid == -1 then
                            -- fallback to default width if window not ready yet
                            winid = 0
                        end

                        local width = vim.api.nvim_win_get_width(winid) - 2
                        if width < 10 then width = 40 end -- sanity min width

                        render_image(filepath, width, function(output)
                            vim.api.nvim_chan_send(term, output)
                        end)
                    end)
                else
                    previewers.buffer_previewer_maker(filepath, bufnr, opts)
                end
            end


            require("telescope").setup({
                defaults = {
                    buffer_previewer_maker = image_preview,
                    file_ignore_patterns = {
                        -- Ignore target for java projects
                        "target",
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
                        },
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
                    colorscheme = {
                        enable_preview = true
                    }
                },
            })
        end
    },
}
