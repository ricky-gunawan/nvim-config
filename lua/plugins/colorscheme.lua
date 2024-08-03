return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000,
  config = function()
    local gruvbox = require('gruvbox')

    gruvbox.setup({
      contrast = "hard", -- can be "hard", "soft" or empty string
      overrides = {
        SignColumn = { bg = gruvbox.palette.dark0_hard },
        GitSignsAdd = { fg = gruvbox.palette.bright_green },
        GitSignsChange = { fg = gruvbox.palette.neutral_blue }
      },
    })
    vim.cmd("colorscheme gruvbox")
  end
}
