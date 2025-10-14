return {
    "andweeb/presence.nvim",
    event = "VeryLazy", -- loads when Neovim has started
    config = function()
        require("presence").setup({
            -- General options
            auto_update = true,
            debounce_timeout = 10,
            enable_line_number = false,
            buttons = true,

            -- Rich Presence text options
            neovim_image_text = "yes I use neovim to edit",
            main_image = "neovim",            -- or "file"
            client_id = "793271441293967371", -- default client id
            log_level = nil,

            editing_text = "Editing %s",
            file_explorer_text = "Browsing %s",
            git_commit_text = "Committing changes",
            plugin_manager_text = "Managing plugins",
            reading_text = "Reading %s",
            workspace_text = "Working on %s",
            line_number_text = "Line %s",
        })
    end,
}
