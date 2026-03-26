return {
    'stevearc/conform.nvim',
    config = function()
        require('conform').setup({
            formatters_by_ft = {
                json = { "prettierd", "prettier" },
                javascript = { "prettierd", "prettier" },
                typescript = { "prettierd", "prettier" },
                typescriptreact = { "prettierd", "prettier" },
                javascriptreact = { "prettierd", "prettier" },
                html = { "prettierd", "prettier" },
                css = { "prettierd", "prettier" },
                scss = { "prettierd", "prettier" },
                markdown = { "prettierd", "prettier" },
                svelte = { "prettierd", "prettier" },
                prisma = { "prettierd", "prettier" },
                nix = { "alejandra" },
            },
        })

        vim.keymap.set("n", "<leader><leader>", "<cmd>Format<cr>");
        vim.api.nvim_create_user_command("Format", function(args)
            local range = nil
            if args.count ~= -1 then
                local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
                range = {
                    start = { args.line1, 0 },
                    ["end"] = { args.line2, end_line:len() },
                }
            end
            require("conform").format({ async = true, lsp_fallback = true, range = range })
        end, { range = true })
    end
}
