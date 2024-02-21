return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      ensure_installed = { "lua", "vimdoc", "css", "gitignore", "typescript", "tsx", "javascript", "html", "sql", "http", "markdown", "yaml" },
      sync_install = false,
      highlight = {
        enable = true,
        disable = { "" },
        additional_vim_regex_highlighting = true
      },
      indent = {
        enable = true,
        disable = { "yaml" }
      },
      autopairs = {
        enable = true,
      },
      autotag = {
        enable = true
      }
    })
  end
}
