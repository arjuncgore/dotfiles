require('neo-tree').setup({
    close_if_last_window = true, -- Close Neo-tree if it's the last window open
    popup_border_style = "rounded",
    enable_git_status = true,
    enable_diagnostics = true,

    default_component_configs = {
        indent = {
            with_markers = true,
            indent_size = 2,
            padding = 1,
        },
        icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "",
            default = "*",
        },
        name = {
            trailing_slash = false,
            use_git_status_colors = true,
        },
        git_status = {
            symbols = {
                -- Change type
                added     = "✚",
                modified  = "",
                deleted   = "✖",
                renamed   = "",
                -- Status type
                untracked = "",
                ignored   = "",
                unstaged  = "",
                staged    = "",
                conflict  = "",
            },
        },
    },

    window = {
        position = "left",
        width = 30,
        mapping_options = {
            noremap = true,
            nowait = true,
        },
        mappings = {
            ["<space>"] = "toggle_node",
            ["<cr>"] = "open",
            ["s"] = "open_split",
            ["S"] = "open_vsplit",
            ["t"] = "open_tabnew",
            ["q"] = "close_window",
            ["R"] = "refresh",
            ["a"] = "add",
            ["d"] = "delete",
            ["r"] = "rename",
            ["c"] = "copy",
            ["m"] = "move",
            ["y"] = "copy_to_clipboard",
            ["p"] = "paste_from_clipboard",
            ["x"] = "cut_to_clipboard",
            ["?"] = "show_help",
        },
    },

    filesystem = {
        filtered_items = {
            visible = false,
            hide_dotfiles = false,
            hide_gitignored = false,
        },
        follow_current_file = { enabled = true},
        group_empty_dirs = true,
        hijack_netrw_behavior = "open_default",
        use_libuv_file_watcher = true,

        },

        buffers = {
            follow_current_file = { enabled = true},
            group_empty_dirs = true,
        },

        git_status = {
            window = {
                position = "float",
            },
        },
    })

    -- Keymap to toggle Neo-tree
    vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', { noremap = true, silent = true })

