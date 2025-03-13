return {
    {
        "roobert/tailwindcss-colorizer-cmp.nvim",
        -- optionally, override the default options:
        config = function()
            require("tailwindcss-colorizer-cmp").setup({
                color_square_width = 2,
            })
        end
    },
    {
        'antosha417/nvim-lsp-file-operations',
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-tree.lua",
        },
        config = function()
            require("lsp-file-operations").setup();
        end
    },
    {
        'onsails/lspkind.nvim',
        config = function()
            -- lspkind.lua
            local lspkind = require("lspkind")
            lspkind.init({
                symbol_map = {
                    Copilot = "",
                },
            })

            vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
        end
    },
    -- {
    --     'yioneko/nvim-vtsls'
    -- },
    -- {
    --     "ray-x/lsp_signature.nvim",
    --     event = "VeryLazy",
    --     opts = {},
    --     config = function(_, opts) require 'lsp_signature'.setup(opts) end
    -- },
    { 'onsails/lspkind.nvim' },
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },

    -- Autocompletion
    { 'hrsh7th/nvim-cmp' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-nvim-lua' },
    { 'saadparwaiz1/cmp_luasnip' },

    -- Snippets
    {
        'L3MON4D3/LuaSnip',
        dependencies = {
            'rafamadriz/friendly-snippets',
        }
    },
    { 'rafamadriz/friendly-snippets' },
    {
        "xzbdmw/colorful-menu.nvim",

    },
    {
        'neovim/nvim-lspconfig',
        config = function()
            local lsp_config = require("lspconfig")

            local capabilities = vim.tbl_deep_extend("force", require('cmp_nvim_lsp').default_capabilities(),
                require('lsp-file-operations').default_capabilities())

            require('luasnip.loaders.from_vscode').lazy_load({ paths = './snippets/' })

            -- Clangd
            lsp_config.clangd.setup({
                capabilities = capabilities,
                cmd = { "clangd" },
                filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
                root_dir = lsp_config.util.root_pattern(
                    '.clangd'
                    , '.clang-tidy'
                    , '.clang-format'
                    , 'compile_commands.json'
                    , 'compile_flags.txt'
                    , 'configure.ac'
                    , '.git'
                ),
                single_file_support = true,
            })

            require('mason').setup({})
            require('mason-lspconfig').setup({
                ensure_installed = { 'svelte', 'gopls', 'lua_ls', 'prismals', 'jsonls', 'yamlls' },
                handlers = {
                    lemminx = function()
                        lsp_config.lemminx.setup({
                            capabilities = capabilities,
                        })
                    end,
                    lua_ls = function()
                        lsp_config.lua_ls.setup({
                            settings = {
                                Lua = {
                                    diagnostics = {
                                        globals = { 'vim' }
                                    }
                                }
                            }
                        })
                    end,
                    ['jdtls'] = function()
                        lsp_config.jdtls.setup({
                            cmd = {
                                "jdtls",
                                "--jvm-arg=" ..
                                string.format("-javaagent:%s", vim.fn.expand "$MASON/share/jdtls/lombok.jar"),
                            },
                            settings = {
                                java = {
                                    format = {
                                        settings = {
                                            url =
                                            "https://gist.githubusercontent.com/matheustavarestrindade/1a91958791a58b35f7e2c3b3329649ea/raw/e2267c94b64ca92bc184db5ca316cbeb5fa42eba/VSCode%2520config",
                                        },
                                    }
                                }
                            },
                            capabilities = capabilities,
                        })
                    end,
                    ['gopls'] = function()
                        lsp_config.gopls.setup({
                            settings = {
                                gopls = {
                                    completeUnimported = true,
                                    usePlaceholders = true,
                                    analyses = {
                                        unusedparams = true,
                                    },
                                    staticcheck = true,
                                },
                            },
                            capabilities = capabilities,
                        })
                    end,
                    ['svelte'] = function()
                        lsp_config.svelte.setup({
                            settings = {
                                svelte = {
                                    plugin = {
                                        svelte = {
                                            format = {
                                                config = {
                                                    printWidth = 160,
                                                    svelteBracketNewLine = false,
                                                }
                                            },
                                            compilerWarnings = {
                                                ["a11y-click-events-have-key-events"] = "ignore",
                                                ["a11y-no-static-element-interactions"] = "ignore"
                                            }
                                        },
                                    }
                                }

                            },
                            capabilities = capabilities,
                        })
                    end,
                    ['prismals'] = function()
                        lsp_config.prismals.setup({
                            capabilities = capabilities,
                        })
                    end,
                    ['jsonls'] = function()
                        lsp_config.jsonls.setup({
                            settings = {
                                json = {
                                    schemas = require('schemastore').json.schemas(),
                                    validate = { enabled = true },
                                },
                            },
                            capabilities = capabilities,
                        })
                    end,
                    ['yamlls'] = function()
                        lsp_config.yamlls.setup({
                            settings = {
                                yaml = {
                                    schemaStore = {
                                        enabled = false,
                                        url = "",
                                    },
                                    schemas = require('schemastore').json.schemas(),
                                },
                            },
                            capabilities = {
                                textDocument = {
                                    foldingRange = {
                                        dynamicRegistration = false,
                                        lineFoldingOnly = true,
                                    },
                                },
                            },
                        })
                    end,
                    ['pylsp'] = function()
                        lsp_config.pylsp.setup({
                            capabilities = capabilities,
                            settings     = {
                                pylsp = {
                                    plugins = {
                                        pycodestyle = {
                                            maxLineLength = 180,
                                        }
                                    }
                                }
                            }
                        })
                    end
                }
            })

            local cmp = require('cmp')
            local cmp_select = { behavior = cmp.SelectBehavior.Select }

            cmp.setup({
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = "copilot" },
                    { name = 'luasnip' },
                }, { name = "buffer" }),
                formatting = {
                    fields = { "kind", "abbr", "menu" },

                    format = function(entry, vim_item)
                        local kind = require("lspkind").cmp_format({
                            mode = "symbol_text",
                        })(entry, vim.deepcopy(vim_item))
                        local highlights_info = require("colorful-menu").cmp_highlights(entry)
                        -- if highlight_info==nil, which means missing ts parser, let's fallback to use default `vim_item.abbr`.
                        -- What this plugin offers is two fields: `vim_item.abbr_hl_group` and `vim_item.abbr`.
                        if highlights_info ~= nil then
                            vim_item.abbr_hl_group = highlights_info.highlights
                            vim_item.abbr = highlights_info.text
                        end
                        local strings = vim.split(kind.kind, "%s", { trimempty = true })
                        vim_item.kind = " " .. (strings[1] or "") .. " "
                        vim_item.menu = ""

                        return vim_item
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                    -- Disable as the buffer switch keybinds is more useful
                    -- ['<C-j>'] = cmp.mapping.scroll_docs(-4),
                    -- ['<C-k>'] = cmp.mapping.scroll_docs(4),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    -- ['<Tab>'] = cmp.mapping.confirm({ select = true }),
                    ['<C-s>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    -- ['<C-f>'] = cmp_action.luasnip_jump_forward(),
                    -- ['<C-b>'] = cmp_action.luasnip_jump_backward(),
                }),
            })

            vim.api.nvim_create_autocmd('LspAttach', {
                desc = 'LSP Actions',
                callback = function(event)
                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    client.server_capabilities.semanticTokensProvider = nil

                    local telescopeBuiltins = require('telescope.builtin')

                    local opts = { buffer = event.bufnr, remap = false }
                    vim.keymap.set("n", "gd", function()
                        -- vim.lsp.buf.definition()
                        telescopeBuiltins.lsp_definitions({
                            initial_mode = 'normal',
                            -- Disable search bar
                            attach_mappings = function(prompt_bufnr, map)
                                map('i', '<CR>', function()
                                    local content = require('telescope.actions.state').get_selected_entry(prompt_bufnr)
                                    require('telescope.actions').close(prompt_bufnr)
                                    vim.lsp.buf.definition(content)
                                end)
                                return true
                            end,

                        })
                    end, opts)
                    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
                    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
                    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
                    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
                    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
                    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
                    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
                    vim.keymap.set("n", "<F2>", function() vim.lsp.buf.rename() end, opts)
                    vim.keymap.set("i", "<C-k>", function() vim.lsp.buf.signature_help() end, opts)
                    vim.keymap.set("n", "<C-k>", function() vim.lsp.buf.signature_help() end, opts)
                end,
            })

            vim.diagnostic.config({
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = '',
                        [vim.diagnostic.severity.WARN] = '',
                        [vim.diagnostic.severity.HINT] = '',
                        [vim.diagnostic.severity.INFO] = '',
                    },
                },
            })

            local function on_attach(oa)
                vim.api.nvim_create_autocmd("LspAttach", {
                    callback = function(args)
                        local buffer = args.buf
                        local client = vim.lsp.get_client_by_id(args.data.client_id)
                        oa(client, buffer)
                    end,
                })
            end

            on_attach(function(client)
                vim.api.nvim_create_autocmd("BufWritePost", {
                    pattern = { "*.js", "*.ts" },
                    group = vim.api.nvim_create_augroup("svelte_ondidchangetsorjsfile", { clear = true }),
                    callback = function(ctx)
                        if client.name == "svelte" then
                            client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
                        end
                    end,
                })
            end)
        end
    }
}
