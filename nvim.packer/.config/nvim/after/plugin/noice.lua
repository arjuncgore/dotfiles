    require("noice").setup({
      -- Your desired configuration options here
      cmdline = {
        enabled = true,
        view = "cmdline_popup", -- or "cmdline", "cmdline_popup"
      },
      messages = {
        view = "notify", -- or "mini", "popup", "notify"
      },
    })
