return {
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
        'onsails/lspkind.nvim'
    },
    {
        'VonHeikemen/lsp-zero.nvim',
        dependencies = {
            -- Icons
            { 'onsails/lspkind.nvim' },
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
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
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        },
        config = function()
            local lsp = require("lsp-zero")
            local lsp_config = require("lspconfig")
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            local lspkind = require('lspkind')


            require('luasnip.loaders.from_vscode').lazy_load({
                paths = './snippets/'
            })

            require('mason').setup({})
            require('mason-lspconfig').setup({
                ensure_installed = { 'tsserver', 'svelte' },
                handlers = {
                    lsp.default_setup,
                    lua_ls = function()
                        local lua_opts = lsp.nvim_lua_ls()
                        lsp_config.lua_ls.setup(lua_opts)
                    end,
                    ['tsserver'] = function()
                        lsp_config.tsserver.setup({
                            on_attach = function(client)
                                client.server_capabilities.documentFormattingProvider = false
                                client.server_capabilities.documentFormattingRangeProvider = false
                            end,
                            settings = {
                                completions = {
                                    completeFunctionCalls = true,
                                },
                                javascript = {
                                    inlayHints = {
                                        includeInlayEnumMemberValueHints = true,
                                        includeInlayFunctionLikeReturnTypeHints = true,
                                        includeInlayFunctionParameterTypeHints = true,
                                        includeInlayParameterNameHints = 'all',
                                        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                                        includeInlayPropertyDeclarationTypeHints = true,
                                        includeInlayVariableTypeHints = true,
                                        includeInlayVariableTypeHintsWhenTypeMatchesName = true
                                    }
                                },
                                typescript = {
                                    inlayHints = {
                                        includeInlayEnumMemberValueHints = true,
                                        includeInlayFunctionLikeReturnTypeHints = true,
                                        includeInlayFunctionParameterTypeHints = true,
                                        includeInlayParameterNameHints = 'all',
                                        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                                        includeInlayPropertyDeclarationTypeHints = true,
                                        includeInlayVariableTypeHints = true,
                                        includeInlayVariableTypeHintsWhenTypeMatchesName = true
                                    }
                                }
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
                                            }
                                        }
                                    }
                                }

                            },
                            capabilities = capabilities,
                        })
                    end,
                    ['prismals'] = function()
                        lsp_config.prismals.setup({
                            settings = {
                                prisma = {
                                    prismaFmtBinPath = ""
                                }
                            },
                            capabilities = capabilities,
                        })
                    end,
                    ['jsonls'] = function()
                        lsp_config.jsonls.setup({
                            settings = {
                                json = {
                                    -- Schemas https://www.schemastore.org
                                    schemas = {
                                        {
                                            fileMatch = { "package.json" },
                                            url = "https://json.schemastore.org/package.json",
                                        },
                                        {
                                            fileMatch = { "tsconfig*.json" },
                                            url = "https://json.schemastore.org/tsconfig.json",
                                        },
                                        {
                                            fileMatch = {
                                                ".prettierrc",
                                                ".prettierrc.json",
                                                "prettier.config.json",
                                            },
                                            url = "https://json.schemastore.org/prettierrc.json",
                                        },
                                        {
                                            fileMatch = { ".eslintrc", ".eslintrc.json" },
                                            url = "https://json.schemastore.org/eslintrc.json",
                                        },
                                        {
                                            fileMatch = {
                                                ".babelrc",
                                                ".babelrc.json",
                                                "babel.config.json",
                                            },
                                            url = "https://json.schemastore.org/babelrc.json",
                                        },
                                        {
                                            fileMatch = { "lerna.json" },
                                            url = "https://json.schemastore.org/lerna.json",
                                        },
                                        {
                                            fileMatch = { "now.json", "vercel.json" },
                                            url = "https://json.schemastore.org/now.json",
                                        },
                                        {
                                            fileMatch = {
                                                ".stylelintrc",
                                                ".stylelintrc.json",
                                                "stylelint.config.json",
                                            },
                                            url = "http://json.schemastore.org/stylelintrc.json",
                                        },
                                    },
                                },
                            },
                            capabilities = capabilities,
                        })
                    end
                }
            })

            local cmp = require('cmp')
            local cmp_select = { behavior = cmp.SelectBehavior.Select }
            local cmp_action = require('lsp-zero').cmp_action()

            cmp.setup({
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                },
                formatting = {
                    format = lspkind.cmp_format({
                        mode = 'symbol', -- show only symbol annotations
                        maxwidth = 50,   -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                        -- can also be a function to dynamically calculate max width such as
                        -- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
                        ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

                        -- The function below will be called before any actual modifications from lspkind
                        -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
                        before = function(entry, vim_item)
                            return vim_item
                        end
                    })
                }, --[[ lsp.cmp_format(), ]]
                mapping = cmp.mapping.preset.insert({
                    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                    ['<C-j>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-k>'] = cmp.mapping.scroll_docs(4),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    -- ['<Tab>'] = cmp.mapping.confirm({ select = true }),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
                    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
                }),
            })

            lsp.on_attach(function(client, bufnr)
                local opts = { buffer = bufnr, remap = false }
                vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
                vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
                vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
                vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
                vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
                vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
                vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
                vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
                vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
                vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
                lsp.default_keymaps({ buffer = bufnr })
            end)

            lsp.set_sign_icons({
                error = '',
                warn = '',
                hint = '',
                info = ''
            })

            lsp.setup()

            function on_attach(on_attach)
                vim.api.nvim_create_autocmd("LspAttach", {
                    callback = function(args)
                        local buffer = args.buf
                        local client = vim.lsp.get_client_by_id(args.data.client_id)
                        on_attach(client, buffer)
                    end,
                })
            end

            on_attach(function(client, bufnr)
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

