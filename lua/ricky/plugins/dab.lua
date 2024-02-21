return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "mxsdev/nvim-dap-vscode-js",
    {
      "microsoft/vscode-js-debug",
      build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out"
    },
    "rcarriga/nvim-notify"
  },
  config = function()
    ---------------- nvim dap --------------------------------------
    local dap = require("dap")
    vim.keymap.set('n', '<F5>', dap.continue)
    vim.keymap.set('n', '<F10>', dap.step_over)
    vim.keymap.set('n', '<F11>', dap.step_into)
    vim.keymap.set('n', '<F12>', dap.step_out)
    vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint)
    vim.keymap.set('n', '<leader>B', function()
      dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
    end)

    dap.defaults.fallback.force_external_terminal = true
    dap.defaults.fallback.external_terminal = {
      command = '/usr/bin/kitty',
    }

    ----------------- dap ui ----------------------------------------
    local dapui = require("dapui")
    dapui.setup()
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open({})
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dap.terminate();
      dapui.close({})
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close({})
    end
    vim.keymap.set('n', '<leader>ui', require 'dapui'.toggle)

    -- setup adapters
    require('dap-vscode-js').setup({
      debugger_path = vim.fn.stdpath('data') .. '/lazy/vscode-js-debug',
      adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
    })

    -- dap.adapters['pwa-node'] = function(cb, config)
    --   if config.preLaunchTask then
    --     local async = require('plenary.async')
    --     local notify = require('notify').async
    --
    --     async.run(function()
    --       ---@diagnostic disable-next-line: missing-parameter
    --       notify('Running [' .. config.preLaunchTask .. ']').events.close()
    --     end, function()
    --       vim.fn.system(config.preLaunchTask)
    --       dap.continue(config)
    --     end)
    --   end
    -- end

    for _, language in ipairs({ 'typescript', 'javascript' }) do
      dap.configurations[language] = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch Program",
          skipFiles = {
            "**/node_modules/**/*",
            "<node_internals>/**"
          },
          program = "${workspaceFolder}/build/index.js",
          cwd = "${workspaceFolder}",
          -- preLaunchTask = "npm run build",
          -- console = 'externalTerminal'
        }
      }
    end
  end
}
