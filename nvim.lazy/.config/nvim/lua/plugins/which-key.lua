return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = { spelling = true },
      win = {                        -- ← was `window`
        border = "rounded",
        margin = { 1, 1, 1, 1 },
        padding = { 1, 2, 1, 2 },
      },
      layout = { align = "center" },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)

      vim.o.timeout = true
      vim.o.timeoutlen = 300

      -- New spec style (replaces wk.register with nested tables)
      wk.add({
        { "<leader>f", group = "find" },
        { "<leader>g", group = "git" },
        { "<leader>e", group = "explorer" },
        { "<leader>E", group = "explorer" },
        { "<leader>u", group = "undo" },
      })
    end,
  },
}

