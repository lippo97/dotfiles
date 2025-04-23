return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "saghen/blink.cmp",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "folke/neodev.nvim",
  },
  config = function()
    require("neodev").setup {}
    require("mason").setup {}
    require("mason-lspconfig").setup {
      ensure_installed = { "lua_ls", "rust_analyzer" },
    }

    local capabilities = require('blink.cmp').get_lsp_capabilities()

    require("lspconfig").lua_ls.setup { capabilities = capabilities }
    require("lspconfig").rust_analyzer.setup { capabilities = capabilities }

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
        vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })
        -- try to use defaults for these
        -- K - vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
        -- grr - vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = 0 })
        -- grn - vim.keymap.set("n", "<space>cr", vim.lsp.buf.rename, { buffer = 0 })
        -- gra - vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, { buffer = 0 })

        vim.diagnostic.config({
          virtual_text = true,
          signs = false,
          update_in_insert = true,
        })

        vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, { buffer = 0 })
        vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, { buffer = 0 })
        vim.keymap.set("n", "g?", vim.diagnostic.open_float)
      end
    })
  end
}
