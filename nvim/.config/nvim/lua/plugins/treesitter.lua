return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",

    dependencies = {
        "windwp/nvim-ts-autotag",
    },

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
                "html",
                "css",
                "json",
                "glimmer",
            },
            auto_install = false,
        })

        vim.filetype.add({
            extension = {
                hbs = "handlebars",
                handlebars = "handlebars"
            },
        })

        vim.treesitter.language.register("glimmer", "handlebars")
        vim.treesitter.language.register("glimmer", "html.handlebars")
    end
}
