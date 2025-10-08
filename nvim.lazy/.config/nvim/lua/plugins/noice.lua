return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",        -- load after UI is ready
    dependencies = {
      "MunifTanjim/nui.nvim",  -- required
      "rcarriga/nvim-notify",  -- optional but recommended
    },
    opts = {
      lsp = {
        -- override markdown rendering so nvim can use treesitter and markdown syntax highlighting
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = true,         -- classic bottom cmdline for search
        command_palette = true,       -- cmdline and popupmenu together
        long_message_to_split = true, -- long messages go to split
        inc_rename = false,          -- enable if using inc-rename.nvim
        lsp_doc_border = true,       -- add border to hover/signature help
      },
    },
    config = function(_, opts)
      require("noice").setup(opts)

      -- Use nvim-notify as the default notification UI
      vim.notify = require("notify")
    end,
  },
}

