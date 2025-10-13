return {
    {
        'tpope/vim-fugitive',
        config = function()
            vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = 'Git Status' } ); 
        end
    },
    {
        'mbbill/undotree',
        config = function()
            vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = 'Undotree' })
        end
    },
    { 'nvim-mini/mini.nvim', version = false },

}
