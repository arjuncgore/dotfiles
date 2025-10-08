return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup({
        -- List of parsers to install
        ensure_installed = {
          "lua",
          "vim",
          "vimdoc",
          "bash",
          "python",
          "javascript",
          "typescript",
          "json",
          "html",
          "css",
          "markdown",
          "markdown_inline",
          "c",
          "cpp",
        },

        -- Install languages synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Auto install missing parsers when entering buffer
        auto_install = true,

        highlight = {
          enable = true,              -- false will disable the whole extension
          additional_vim_regex_highlighting = false,
        },

        indent = {
          enable = true,
        },
      })
    end,
  },
}

