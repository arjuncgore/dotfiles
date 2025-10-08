return {
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- icons for buttons (optional)
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      -- Header
      dashboard.section.header.val = {
        [[ ███╗   ██╗██╗   ██╗██╗███╗   ███╗]],
        [[ ████╗  ██║██║   ██║██║████╗ ████║]],
        [[ ██╔██╗ ██║██║   ██║██║██╔████╔██║]],
        [[ ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║]],
        [[ ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║]],
        [[ ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝]],
      }

      -- Buttons
      local b = dashboard.button
      dashboard.section.buttons.val = {
        b("e",        "  New file",          ":ene | startinsert<CR>"),
        b("SPC f f",  "󰈞  Find file"),
        b("SPC f g",  "󰊄  Live grep"),
        b("SPC e",    "  File Explorer"),
        b("q",        "  Quit",              ":qa<CR>"),
      }

      -- Footer
      dashboard.section.footer.val = function()
        local v = vim.version()
        return ("  %s  |    v%d.%d.%d"):format(os.date("%A %d %B %Y"), v.major, v.minor, v.patch)
      end

      dashboard.section.header.opts.hl  = "Type"
      dashboard.section.buttons.opts.hl = "Keyword"
      dashboard.section.footer.opts.hl  = "Constant"

      alpha.setup(dashboard.opts)

      ------------------------------------------------------------------
      -- Ensure dashboard shows on empty start (no files on the cmdline)
      ------------------------------------------------------------------
      if vim.fn.argc(-1) == 0 then
        -- If something opened a buffer on VimEnter, re-open Alpha
        vim.api.nvim_create_autocmd("User", {
          pattern = "VeryLazy",      -- after Lazy finished loading plugins
          once = true,
          callback = function()
            -- Only if we're still in an empty/unnamed buffer
            local bufname = vim.api.nvim_buf_get_name(0)
            local ft      = vim.bo.filetype
            if bufname == "" and ft ~= "alpha" then
              require("alpha").start(true)
            end
          end,
        })
      end
    end,
  },
}

