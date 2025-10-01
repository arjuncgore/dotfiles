-- lua/lsp.lua
local lsp_zero = require('lsp-zero')

-- keymaps per buffer when LSP attaches
lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({buffer = bufnr})
end)

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
    'pyright',      -- Python
    'ts_ls',        -- TypeScript/JavaScript (was 'tsserver')
    'clangd',       -- C/C++
    'bashls',       -- Bash
    'texlab',       -- LaTeX
    'lua_ls',       -- Lua (Neovim)
    -- optional extras you might want:
    -- 'jsonls', 'html', 'cssls', 'eslint', 'jdtls'
  },
  handlers = {
    function(server)
      require('lspconfig')[server].setup({})
    end,
    lua_ls = function()
      require('lspconfig').lua_ls.setup(require('lsp-zero').nvim_lua_ls())
    end,
  },
})

-- nvim-cmp (completion)
local cmp = require('cmp')
local cmp_action = lsp_zero.cmp_action()

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>']      = cmp.mapping.confirm({ select = true }),
    ['<C-f>']     = cmp_action.luasnip_jump_forward(),
    ['<C-b>']     = cmp_action.luasnip_jump_backward(),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'luasnip' },
  },
})

