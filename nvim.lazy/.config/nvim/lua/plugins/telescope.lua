return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",                         -- a stable release tag
    dependencies = { "nvim-lua/plenary.nvim" }, -- required dependency
    cmd = "Telescope",                     -- lazy-load on :Telescope command
    config = function()
      require("telescope").setup({
        defaults = {
          layout_config = {
            horizontal = { preview_width = 0.55 },
            vertical = { mirror = false },
          },
          sorting_strategy = "ascending",
          prompt_prefix = "🔍 ",
        },
      })
    end,
  },
}

