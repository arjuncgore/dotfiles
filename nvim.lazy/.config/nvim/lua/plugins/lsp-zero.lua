---@diagnostic disable: undefined-global

return {
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            -- LSP
            { "neovim/nvim-lspconfig" },
            { "williamboman/mason.nvim", config = true }, -- :Mason
            { "williamboman/mason-lspconfig.nvim" },

            -- Completion
            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "L3MON4D3/LuaSnip" },
            { "saadparwaiz1/cmp_luasnip" },
            { "rafamadriz/friendly-snippets" },
        },
        config = function()
            local lsp = require("lsp-zero")

            -- Mason + LSP servers
            require("mason").setup({})
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "tsserver",
                    "pyright",
                    "bashls",
                    "jsonls",
                    "html",
                    "cssls",
                },
                handlers = {
                    lsp.default_setup, -- default for all
                    lua_ls = function()
                        require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())
                    end,
                },
            })

            -- buffer-local default keymaps on attach
            lsp.on_attach(function(_, bufnr)
                lsp.default_keymaps({ buffer = bufnr })
            end)

            -- nvim-cmp with lsp-zero helpers
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            local cmp_action = lsp.cmp_action()
            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup({
                snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
                mapping = cmp.mapping.preset.insert({
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<CR>"]      = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"]     = cmp_action.tab_complete(),
                    ["<S-Tab>"]   = cmp_action.select_prev_or_fallback(),
                    ["<C-e>"]     = cmp.mapping.abort(),
                }),
                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "path" },
                    { name = "buffer" },
                },
                window = {
                    completion    = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                experimental = { ghost_text = true },
            })

            -- diagnostics look (Neovim 0.11+ API)
            vim.diagnostic.config({
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = " ",
                        [vim.diagnostic.severity.WARN]  = " ",
                        [vim.diagnostic.severity.HINT]  = " ",
                        [vim.diagnostic.severity.INFO]  = " ",
                    },
                    -- optional: keep num column highlights
                    numhl = {
                        [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
                        [vim.diagnostic.severity.WARN]  = "DiagnosticSignWarn",
                        [vim.diagnostic.severity.HINT]  = "DiagnosticSignHint",
                        [vim.diagnostic.severity.INFO]  = "DiagnosticSignInfo",
                    },
                },
                underline = true,
                virtual_text = { spacing = 2, prefix = "●" },
                severity_sort = true,
                float = { border = "rounded" },
            })


        end,
    },
}

