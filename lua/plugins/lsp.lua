return {
  'neovim/nvim-lspconfig',
  cond = true,
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp"
  },
  config = function()
    require("mason-lspconfig").setup()
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    require("mason-lspconfig").setup_handlers {
      function(server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup {
          capabilities = capabilities,
          -- handlers = {
          --   ["textDocument/publishDiagnostics"] = vim.lsp.with(
          --     vim.lsp.diagnostic.on_publish_diagnostics, {
          --       -- Disable virtual_text
          --       virtual_text = false
          --     }
          --   ),
          -- }
          -- diagnostics = {
          --   settings = {
          --     virtual_text = false
          --   }
          -- }
        }
      end,

      ["lua_ls"] = function()
        require("lspconfig").lua_ls.setup {
          capabilities = capabilities,
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" }
              }
            }
          }
        }
      end,

      ["gopls"] = function()
        require("lspconfig").gopls.setup {
          capabilities = capabilities,
          cmd = { "gopls" },
          filetypes = { "go", "gomod", "gowork", "gotmpl" },
          root_dir = require('lspconfig/util').root_pattern("go.work", "go.mod", ".git"),
          settings = {
            gopls = {
              completeUnimported = true,
              usePlaceholders = true,
              analyses = {
                unusedparams = true,
              },
            },
          },
        }
      end,


    }

    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    -- vim.keymap.set('n', '<space>d', vim.diagnostic.open_float)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
    -- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
    -- vim.diagnostic.config({ virtual_text = false })

    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    -- Use LspAttach autocommand to only map the following keys
    -- after the language server attaches to the current buffer
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<space>f', function()
          vim.lsp.buf.format { async = true }
        end, opts)
      end,
    })
  end
}
