return {
    {
        'stevearc/oil.nvim',
        opts = {},
        dependencies = { { "nvim-mini/mini.icons", opts = {} } },
        lazy = false,
        opts = {
            default_file_explorer = true,
            view_options = {
                show_hidden = true,
            }
        },
    }
}
