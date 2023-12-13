local lsp = require("lsp-zero")
local lsp_config = require("lspconfig")
local capabilities = require('cmp_nvim_lsp').default_capabilities()

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
                settings = {
                    completions = {
                        completeFunctionCalls = true,
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
        end
    }
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
    sources = {
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
    },
    formatting = lsp.cmp_format(),
    mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-j>'] = cmp.mapping.scroll_docs(-4),
        ['<C-k>'] = cmp.mapping.scroll_docs(4),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        -- ['<Tab>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
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

-- lsp.format_on_save({
-- 	format_opts = {
-- 		async = true,
-- 		timeout_ms = 10000,
-- 		formatting_options = {
-- 			['tabSize'] = 4,
-- 			['insertSpaces'] = false,
-- 		}
-- 	},
-- 	servers = {
-- 		['tsserver'] = { 'javascript', 'typescript', 'typescriptreact', 'ts', 'jsx', 'tsx', 'js' },
-- 		['svelte']   = { 'svelte' },
-- 		['lua_ls']   = { 'lua' },
-- 		['prismals'] = { 'prisma' },
-- 	}
-- });

lsp.set_sign_icons({
    error = '',
    warn = '',
    hint = '',
    info = ''
})

lsp.setup()
