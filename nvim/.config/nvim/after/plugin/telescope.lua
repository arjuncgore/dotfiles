local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)
