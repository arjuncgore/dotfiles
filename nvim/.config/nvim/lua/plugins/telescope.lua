return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
        defaults = {
            file_ignore_patterns = {
                "node_modules", ".git/", "dist/", "build/", "venv/", "__pycache__",
            },
        },
        pickers = {
            live_grep = {
                additional_args = function(_)
                    return { "--glob", "!**/node_modules/*" }
                end,
            },
        },
    },

    config = function(_, opts)
        require('telescope').setup(opts)
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
        vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = 'Telescope find git files' })
        vim.keymap.set('n', '<leader>fg', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") });
        end, { desc = 'Grep String' })
    end
}
