return {
  "williamboman/mason.nvim",
  priority = 999,
  config = function()
    require('mason').setup()
    ------- lsp ----------
    --     'cssls',
    --     'emmet_ls',
    --     'html',
    --     'jsonls',
    --     'tsserver',
    --     'lua_ls',
    --     'sqlls'

    ------- dap ----------
    -- js-debug-adapter

    ------- linter -------
    -- eslint_d

    ------ formatter -----
    -- prettier
  end
}
