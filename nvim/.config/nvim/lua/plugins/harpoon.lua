local conf = require('telescope.config').values
local themes = require('telescope.themes')

-- helper function to use telescope on harpoon list.
-- change get_ivy to other themes if wanted
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end
    local opts = themes.get_ivy({
        promt_title = "Working List"
    })

    require("telescope.pickers").new(opts, {
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer(opts),
        sorter = conf.generic_sorter(opts),
    }):find()
end

return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    config = function()
        local harpoon = require('harpoon')
        vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = 'Harpoon: add file' })
        vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
            { desc = 'Harpoon: switcher' })
        vim.keymap.set("n", "<leader>hf", function() toggle_telescope(harpoon:list()) end,
            { desc = 'Harpoon: Telescope' })
        vim.keymap.set("n", "<leader>hr", function() harpoon:list():prev() end, { desc = 'Harpoon: prev file' })
        vim.keymap.set("n", "<leader>ht", function() harpoon:list():next() end, { desc = 'Harpoon: next file' })
        vim.keymap.set("n", "<leader>h1", function() harpoon:list():select(1) end, { desc = 'Harpoon: file 1' })
        vim.keymap.set("n", "<leader>h2", function() harpoon:list():select(2) end, { desc = 'Harpoon: file 2' })
        vim.keymap.set("n", "<leader>h3", function() harpoon:list():select(3) end, { desc = 'Harpoon: file 3' })
        vim.keymap.set("n", "<leader>h4", function() harpoon:list():select(4) end, { desc = 'Harpoon: file 4' })
        vim.keymap.set("n", "<leader>h5", function() harpoon:list():select(5) end, { desc = 'Harpoon: file 5' })
        vim.keymap.set("n", "<leader>h6", function() harpoon:list():select(6) end, { desc = 'Harpoon: file 6' })
        vim.keymap.set("n", "<leader>h7", function() harpoon:list():select(7) end, { desc = 'Harpoon: file 7' })
    end
}
