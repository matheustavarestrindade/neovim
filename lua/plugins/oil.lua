return {
    {
        'stevearc/oil.nvim',
        ---@module 'oil'
        ---@type oil.SetupOpts
        opts = {},
        -- Optional dependencies
        dependencies = { { "echasnovski/mini.icons", opts = {} } },
        -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
        -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
        lazy = false,
        config = function()
            vim.keymap.set("n", "<leader>e", ":Oil --float<CR>", { noremap = true, silent = true })

            local oil_util = require("oil.util")

            vim.api.nvim_create_autocmd("User", {
                pattern = "OilActionsPost",
                callback = function(args)
                    if args.data.err then
                        vim.notify("Oil.nvim error: " .. tostring(args.data.err), vim.log.levels.ERROR)
                        return
                    end

                    -- Detect OS
                    local is_windows = jit and jit.os == "Windows"

                    for _, action in ipairs(args.data.actions) do
                        if action.type == "create" and action.entry_type == "file" then
                            -- Extract correct file path
                            local _, filepath = oil_util.parse_url(action.url)

                            if is_windows and filepath then
                                filepath = filepath:gsub("^/(%a)/", "%1:/") -- Convert "/C/..." to "C:/..."
                                filepath = filepath:gsub("/", "\\")         -- Convert all slashes to backslashes
                            end

                            if filepath and filepath:match("%.java$") then
                                -- Ensure directory exists
                                vim.fn.mkdir(vim.fn.fnamemodify(filepath, ":h"), "p")

                                -- Extract package path
                                local package_path = filepath:match("src[\\/]main[\\/]java[\\/](.*)[\\/][^\\/]+%.java$")
                                if package_path then
                                    local package_name = package_path:gsub("[\\/]", ".")
                                    local class_name = filepath:match("([^\\/]+)%.java$")

                                    -- Java file template
                                    local java_template = string.format([[
package %s;

public class %s {

}
]], package_name, class_name)

                                    -- Delay writing to ensure file exists
                                    vim.schedule(function()
                                        local file = io.open(filepath, "w")
                                        if file then
                                            file:write(java_template)
                                            file:flush()
                                            file:close()
                                        else
                                            vim.notify("Failed to open file for writing: " .. filepath,
                                                vim.log.levels.ERROR)
                                        end
                                    end)
                                end
                            end
                        end
                    end
                end,
            })


            require("oil").setup({
                view_options = {
                    show_hidden = true,
                },
                columns = {
                    "icon",
                    "size",
                    "mtime",
                },
                keymaps = {
                    ["g?"] = { "actions.show_help", mode = "n" },
                    ["<C-l>"] = "actions.select",
                    ["<C-s>"] = { "actions.select", opts = { vertical = true } },
                    ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
                    ["<C-t>"] = { "actions.select", opts = { tab = true } },
                    ["<C-p>"] = "actions.preview",
                    ["<C-c>"] = { "actions.close", mode = "n" },
                    ["q"] = { "actions.close", mode = "n" },
                    ["<C-r>"] = "actions.refresh",
                    ["<C-k>"] = { "actions.parent", mode = "n" },
                    ["_"] = { "actions.open_cwd", mode = "n" },
                    ["`"] = { "actions.cd", mode = "n" },
                    ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
                    ["gs"] = { "actions.change_sort", mode = "n" },
                    ["gx"] = "actions.open_external",
                    ["g."] = { "actions.toggle_hidden", mode = "n" },
                    ["g\\"] = { "actions.toggle_trash", mode = "n" },
                },


            })
        end
    }

}
