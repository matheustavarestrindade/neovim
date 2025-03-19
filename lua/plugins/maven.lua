return {
    "matheustavarestrindade/maven.nvim",
    cmd = { "Maven", "MavenInit", "MavenExec" },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
    },
    opts = {}, -- options, see default configuration
    keys = { { "<Leader>M", "<cmd>Maven<cr>", desc = "Maven" } },
    config = function()
        require("maven").setup({
            mvn_executable = 'mvn.cmd', -- Example: mvn, ./mvnw or a path to Maven executable
            project_scanner_depth = 5,
            console = {
                show_command_execution = true,
                show_lifecycle_execution = true,
                show_plugin_goal_execution = true,
                show_dependencies_load_execution = false,
                show_plugins_load_execution = false,
                show_project_create_execution = true,
                clean_before_execution = true,
            },
            cache = {
                enable_dependencies_cache = true,
                enable_plugins_cache = true,
                enable_help_options_cache = true,
            },
            projects_view = {
                custom_commands = {
                    -- Example:
                    -- {
                    --   name = "lazy",
                    --   cmd_args = { "clean", "package", "-DskipTests" },
                    --   description = "clean package and skip tests",
                    -- }
                },
                position = 'right',
                size = 65,
            },
            dependencies_view = {
                size = { -- see the nui doc for details about size
                    width = '70%',
                    height = '80%',
                },
                resolved_dependencies_win = {
                    border = { style = 'rounded' },
                },
                dependency_usages_win = {
                    border = { style = 'rounded' },
                },
                filter_win = {
                    border = { style = 'rounded' },
                },
                dependency_details_win = {
                    size = {
                        width = '80%',
                        height = '6',
                    },
                    border = { style = 'rounded' },
                },
            },
            initializer_view = {
                project_name_win = {
                    border = { style = 'rounded' },
                },
                project_package_win = {
                    default_value = '', -- Example: io.github.username
                    border = { style = 'rounded' },
                },
                archetypes_win = {
                    input_win = {
                        border = {
                            style = { '╭', '─', '╮', '│', '│', '─', '│', '│' },
                        },
                    },
                    options_win = {
                        border = {
                            style = { '', '', '', '│', '╯', '─', '╰', '│' },
                        },
                    },
                },
                archetype_version_win = {
                    border = { style = 'rounded' },
                },
                workspaces_win = {
                    options = {
                        { name = 'HOME',        path = vim.loop.os_homedir() },
                        { name = 'CURRENT_DIR', path = vim.fn.getcwd() },
                    },
                    border = { style = 'rounded' },
                },
            },
            execution_view = {
                size = {
                    width = '40%',
                    height = '60%',
                },
                input_win = {
                    border = {
                        style = { '╭', '─', '╮', '│', '│', '─', '│', '│' },
                    },
                },
                options_win = {
                    border = {
                        style = { '', '', '', '│', '╯', '─', '╰', '│' },
                    },
                },
            },
            help_view = {
                size = {
                    width = '80%',
                    height = '34%',
                },
                border = { style = 'rounded' },
            },
            default_arguments_view = {
                arguments = {},
                size = {
                    width = '40%',
                    height = '60%',
                },
                input_win = {
                    border = {
                        style = { '╭', '─', '╮', '│', '│', '─', '│', '│' },
                    },
                },
                options_win = {
                    border = {
                        style = { '', '', '', '│', '╯', '─', '╰', '│' },
                    },
                },
            },
            icons = {
                plugin = '',
                package = '',
                new = '',
                tree = '󰙅',
                expanded = ' ',
                collapsed = ' ',
                maven = '',
                project = '',
                tool_folder = '',
                tool = '',
                command = '',
                help = '󰘥',
                package_dependents = '',
                package_dependencies = '',
                warning = '',
                entry = ' ',
                search = '',
                argument = '',
            },
        })
    end,

}
