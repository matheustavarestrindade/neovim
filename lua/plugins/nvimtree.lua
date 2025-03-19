return {
    --     {
    --
    --         'nvim-tree/nvim-tree.lua',
    --         config = function()
    --             vim.g.loaded_netrw = 1
    --             vim.g.loaded_netrwPlugin = 1
    --
    --             -- set termguicolors to enable highlight groups
    --             vim.opt.termguicolors = true
    --
    --             -- Mappings
    --
    --             vim.keymap.set("n", "<C-b>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
    --             vim.keymap.set("n", "<leader>r", ":NvimTreeRefresh<CR>", { noremap = true, silent = true })
    --             vim.keymap.set("n", "<leader>n", ":NvimTreeFindFile<CR>", { noremap = true, silent = true })
    --             vim.keymap.set("n", "<leader>e", ":NvimTreeFocus<CR>", { noremap = true, silent = true })
    --             local api = require("nvim-tree.api")
    --
    --             local function edit_or_open()
    --                 local node = api.tree.get_node_under_cursor()
    --
    --                 if node.nodes ~= nil then
    --                     -- expand or collapse folder
    --                     api.node.open.edit()
    --                 else
    --                     -- open file
    --                     api.node.open.edit()
    --                     -- Close the tree if file was opened
    --                     api.tree.close()
    --                 end
    --             end
    --
    --             -- open as vsplit on current node
    --             local function vsplit_preview()
    --                 local node = api.tree.get_node_under_cursor()
    --
    --                 if node.nodes ~= nil then
    --                     -- expand or collapse folder
    --                     api.node.open.edit()
    --                 else
    --                     -- open file as vsplit
    --                     api.node.open.vertical()
    --                 end
    --
    --                 -- Finally refocus on tree if it was lost
    --                 api.tree.focus()
    --             end
    --
    --             local HEIGHT_RATIO = 0.8 -- You can change this
    --             local WIDTH_RATIO = 0.5 -- You can change this too
    --             -- OR setup with some options
    --             require("nvim-tree").setup({
    --                 sort_by = "case_sensitive",
    --                 view = {
    --                     float = {
    --                         enable = true,
    --                         open_win_config = function()
    --                             local screen_w = vim.opt.columns:get()
    --                             local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
    --                             local window_w = screen_w * WIDTH_RATIO
    --                             local window_h = screen_h * HEIGHT_RATIO
    --                             local window_w_int = math.floor(window_w)
    --                             local window_h_int = math.floor(window_h)
    --                             local center_x = (screen_w - window_w) / 2
    --                             local center_y = ((vim.opt.lines:get() - window_h) / 2)
    --                                 - vim.opt.cmdheight:get()
    --                             return {
    --                                 border = 'rounded',
    --                                 relative = 'editor',
    --                                 row = center_y,
    --                                 col = center_x,
    --                                 width = window_w_int,
    --                                 height = window_h_int,
    --                             }
    --                         end,
    --                     },
    --                     width = function()
    --                         return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
    --                     end,
    --                 },
    --                 live_filter = {
    --                     prefix = " ",
    --                     always_show_folders = false
    --                 },
    --                 renderer = {
    --                     group_empty = true,
    --                 },
    --                 filters = {
    --                     dotfiles = false,
    --                 },
    --                 renderer = {
    --                     icons = {
    --                         glyphs = {
    --                             git = {
    --                                 unstaged = "󰅤",
    --                                 staged = "✓",
    --                                 unmerged = "",
    --                                 renamed = "➜",
    --                                 untracked = "★",
    --                                 deleted = "",
    --                                 ignored = "◌"
    --                             },
    --                         }
    --                     }
    --                 },
    --                 git = {
    --                     enable = true,
    --                     ignore = false,
    --                     timeout = 500
    --                 },
    --                 on_attach = function(bufnr)
    --                     local api = require('nvim-tree.api')
    --
    --                     local function opts(desc)
    --                         return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    --                     end
    --
    --                     local function trash_put()
    --                         local node = require("nvim-tree.api").tree.get_node_under_cursor()
    --                         local function trash_impl(on_exit, on_stderr)
    --                             local j =
    --                                 vim.fn.jobstart("trash" .. ' "' .. node.absolute_path .. '"', {
    --                                     on_exit = on_exit,
    --                                     on_stderr = on_stderr,
    --                                 })
    --                             vim.fn.jobwait({ j })
    --                         end
    --
    --                         local err_msg = ""
    --                         local function on_trash_error(_, data)
    --                             if type(data) == "table" then
    --                                 err_msg = err_msg .. table.concat(data, " ")
    --                             end
    --                         end
    --                         local function on_trash_exit(_, rc)
    --                             if rc ~= 0 then
    --                                 require("nvim-tree.notify").warn(
    --                                     "trash failed: " .. err_msg .. ""
    --                                 )
    --                             end
    --                         end
    --
    --                         local prompt_select = "Trash " .. node.name .. " ?"
    --                         local prompt_input = prompt_select .. " y/n: "
    --                         require("nvim-tree.lib").prompt(
    --                             prompt_input,
    --                             prompt_select,
    --                             { "y", "n" },
    --                             { "Yes", "No" },
    --                             function(item_short)
    --                                 require("nvim-tree.utils").clear_prompt()
    --                                 if item_short == "y" then
    --                                     trash_impl(on_trash_exit, on_trash_error)
    --                                 end
    --                             end
    --                         )
    --                     end
    --
    --                     if vim.fn.executable("trash") > 0 then
    --                         vim.keymap.set("n", "d", vim.fn.has('win32') > 0 and trash_put or api.fs.trash, opts("Trash Put"))
    --                     end
    --
    --
    --                     -- Default mappings. Feel free to modify or remove as you wish.
    --                     --
    --                     -- BEGIN_DEFAULT_ON_ATTACH
    --                     vim.keymap.set('n', '<C-]>', api.tree.change_root_to_node, opts('CD'))
    --                     vim.keymap.set('n', '<C-e>', api.node.open.replace_tree_buffer, opts('Open: In Place'))
    --                     vim.keymap.set('n', '<C-k>', api.node.show_info_popup, opts('Info'))
    --                     vim.keymap.set('n', '<C-r>', api.fs.rename_sub, opts('Rename: Omit Filename'))
    --                     vim.keymap.set('n', '<C-t>', api.node.open.tab, opts('Open: New Tab'))
    --                     vim.keymap.set('n', '<C-v>', api.node.open.vertical, opts('Open: Vertical Split'))
    --                     vim.keymap.set('n', '<C-x>', api.node.open.horizontal, opts('Open: Horizontal Split'))
    --                     vim.keymap.set('n', '<BS>', api.node.navigate.parent_close, opts('Close Directory'))
    --                     vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
    --                     vim.keymap.set('n', '<Tab>', api.node.open.preview, opts('Open Preview'))
    --                     vim.keymap.set('n', '>', api.node.navigate.sibling.next, opts('Next Sibling'))
    --                     vim.keymap.set('n', '<', api.node.navigate.sibling.prev, opts('Previous Sibling'))
    --                     vim.keymap.set('n', '.', api.node.run.cmd, opts('Run Command'))
    --                     vim.keymap.set('n', '-', api.tree.change_root_to_parent, opts('Up'))
    --                     vim.keymap.set('n', 'a', api.fs.create, opts('Create'))
    --                     vim.keymap.set('n', 'bmv', api.marks.bulk.move, opts('Move Bookmarked'))
    --                     vim.keymap.set('n', 'B', api.tree.toggle_no_buffer_filter, opts('Toggle No Buffer'))
    --                     vim.keymap.set('n', 'c', api.fs.copy.node, opts('Copy'))
    --                     vim.keymap.set('n', 'C', api.tree.toggle_git_clean_filter, opts('Toggle Git Clean'))
    --                     vim.keymap.set('n', '[c', api.node.navigate.git.prev, opts('Prev Git'))
    --                     vim.keymap.set('n', ']c', api.node.navigate.git.next, opts('Next Git'))
    --                     vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
    --                     vim.keymap.set('n', 'D', api.fs.trash, opts('Trash'))
    --                     vim.keymap.set('n', 'E', api.tree.expand_all, opts('Expand All'))
    --                     vim.keymap.set('n', 'e', api.fs.rename_basename, opts('Rename: Basename'))
    --                     vim.keymap.set('n', ']e', api.node.navigate.diagnostics.next, opts('Next Diagnostic'))
    --                     vim.keymap.set('n', '[e', api.node.navigate.diagnostics.prev, opts('Prev Diagnostic'))
    --                     vim.keymap.set('n', 'F', api.live_filter.clear, opts('Clean Filter'))
    --                     vim.keymap.set('n', 'f', api.live_filter.start, opts('Filter'))
    --                     vim.keymap.set('n', 'g?', api.tree.toggle_help, opts('Help'))
    --                     vim.keymap.set('n', 'gy', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
    --                     vim.keymap.set('n', 'H', api.tree.toggle_hidden_filter, opts('Toggle Dotfiles'))
    --                     vim.keymap.set('n', 'I', api.tree.toggle_gitignore_filter, opts('Toggle Git Ignore'))
    --                     vim.keymap.set('n', 'J', api.node.navigate.sibling.last, opts('Last Sibling'))
    --                     vim.keymap.set('n', 'K', api.node.navigate.sibling.first, opts('First Sibling'))
    --                     vim.keymap.set('n', 'm', api.marks.toggle, opts('Toggle Bookmark'))
    --                     vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'))
    --                     vim.keymap.set('n', 'O', api.node.open.no_window_picker, opts('Open: No Window Picker'))
    --                     vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
    --                     vim.keymap.set('n', 'P', api.node.navigate.parent, opts('Parent Directory'))
    --                     vim.keymap.set('n', 'q', api.tree.close, opts('Close'))
    --                     vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
    --                     vim.keymap.set('n', 'R', api.tree.reload, opts('Refresh'))
    --                     vim.keymap.set('n', 's', api.node.run.system, opts('Run System'))
    --                     vim.keymap.set('n', 'S', api.tree.search_node, opts('Search'))
    --                     vim.keymap.set('n', 'U', api.tree.toggle_custom_filter, opts('Toggle Hidden'))
    --                     vim.keymap.set('n', 'W', api.tree.collapse_all, opts('Collapse'))
    --                     vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
    --                     vim.keymap.set('n', 'y', api.fs.copy.filename, opts('Copy Name'))
    --                     vim.keymap.set('n', 'Y', api.fs.copy.relative_path, opts('Copy Relative Path'))
    --                     vim.keymap.set('n', '<2-LeftMouse>', api.node.open.edit, opts('Open'))
    --                     vim.keymap.set('n', '<2-RightMouse>', api.tree.change_root_to_node, opts('CD'))
    --                     -- END_DEFAULT_ON_ATTACH
    --
    --
    --                     -- Mappings migrated from view.mappings.list
    --                     --
    --                     -- You will need to insert "your code goes here" for any mappings with a custom action_cb
    --
    --                     vim.keymap.set("n", "l", edit_or_open, opts("Edit Or Open"))
    --                     vim.keymap.set("n", "L", vsplit_preview, opts("Vsplit Preview"))
    --                     vim.keymap.set("n", "h", api.tree.close, opts("Close"))
    --                     vim.keymap.set("n", "H", api.tree.collapse_all, opts("Collapse All"))
    --                 end
    --             })
    --
    --             local api = require("nvim-tree.api")
    --             local Event = api.events.Event
    --
    --             api.events.subscribe(Event.FileCreated, function(data)
    --                 if data.fname:match("%.java$") then
    --                     local file_path = data.fname
    --                     local package_path = file_path:match("src[\\/]main[\\/]java[\\/](.*)[\\/][^\\/]+%.java$")
    --
    --                     if package_path then
    --                         -- Convert path to Java package format
    --                         local package_name = package_path:gsub("[\\/]", ".")
    --
    --                         -- Extract class name from filename
    --                         local class_name = file_path:match("([^\\/]+)%.java$")
    --
    --                         -- Java file template
    --                         local java_template = string.format([[
    -- package %s;
    --
    -- public class %s {
    -- }
    -- ]], package_name, class_name, class_name, class_name)
    --
    --                         -- Write the template to the file
    --                         local file = io.open(file_path, "w")
    --                         if file then
    --                             file:write(java_template)
    --                             file:close()
    --                         end
    --                     end
    --                 end
    --             end)
    --         end
    --     },
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
            require("oil").setup({
                keymaps = {
                    ["g?"] = { "actions.show_help", mode = "n" },
                    ["l"] = "actions.select",
                    ["<C-s>"] = { "actions.select", opts = { vertical = true } },
                    ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
                    ["<C-t>"] = { "actions.select", opts = { tab = true } },
                    ["<C-p>"] = "actions.preview",
                    ["<C-c>"] = { "actions.close", mode = "n" },
                    ["q"] = { "actions.close", mode = "n" },
                    ["<C-l>"] = "actions.refresh",
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
