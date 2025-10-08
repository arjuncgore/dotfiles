-- ~/.config/nvim/lua/plugins/mini-files.lua
return {
  {
    "nvim-mini/mini.files",
    version = "*",
    opts = {
      options = { use_as_default_explorer = true },
      content = { filter = function(_) return true end },
      windows = { preview = true, width_focus = 28, width_preview = 50 },
    },
    config = function(_, opts)
      require("mini.files").setup(opts)
    end,
  },
}

