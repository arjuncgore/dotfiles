return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local configs = require("nvim-treesitter.configs")
        configs.setup({
            highlight = { enable = true },
            indent = { enable = true },
            autotag = { enable = true },
            ensure_installed = {
                "lua",
                "c",
                "vim",
                "vimdoc",
                "markdown",
                "markdown_inline",
                "python",
                "java",
                "javascript",
                "cpp",
                "latex",
                "bash",
            },
            auto_install = false,
        })
    end
}
