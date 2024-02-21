return {
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPre', 'BufNewfile' },
  config = function()
    local gitsigns = require('gitsigns')

    gitsigns.setup({
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 200
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', ']c', gitsigns.next_hunk, { buffer = bufnr })
        vim.keymap.set('n', '[c', gitsigns.prev_hunk, { buffer = bufnr })
        vim.keymap.set('n', '<leader>c', gitsigns.preview_hunk, { buffer = bufnr })
      end
    })
  end
}
