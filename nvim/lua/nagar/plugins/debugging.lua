return {
    {
        'folke/lazydev.nvim',
        opts = {
            library = {
                'nvim-dap-ui'
            }
        }
    },
    {
        'rcarriga/nvim-dap-ui',
        dependencies = {
            'folke/lazydev.nvim'
        }
    },
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            'rcarriga/nvim-dap-ui',
            'nvim-neotest/nvim-nio',
        },
        config = function()
            local dap = require('dap')
            local dapui = require('dapui')
            dapui.setup()

            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end

            dap.adapters.cppdbg = {
                id = 'cppdbg',
                type = 'executable',
                command = '/home/archishman/Documents/cpptools/extension/debugAdapters/bin/OpenDebugAD7',
            }

            dap.adapters.gdb = {
                type = 'executable',
                command = 'gdb',
                args = { '--interpreter=dap', '--eval-command', 'set print pretty on' }
            }

            dap.configurations.cpp = {
                {
                    name = 'CPPDBG: Launch',
                    type = 'cppdbg',
                    request = 'launch',
                    program = --'${fileDirname}/${fileBasenameNoExtension}',
                        function()
                            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                        end,
                    args = {},
                    stopOnEntry = false,
                    cwd = '${workspaceFolder}',
                    environment = {},
                    externalConsole = false,
                    MIMode = 'gdb',
                    setupCommands = {
                        {
                            description = 'Enable pretty-printing for gdb',
                            text = '-enable-pretty-printing',
                            ignoreFailures = true,
                        },
                    },
                    miDebuggerPath = '/usr/bin/gdb',
                },
                {
                    name = 'GDB: Launch',
                    type = 'gdb',
                    request = 'launch',
                    program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                    cwd = '${workspaceFolder}',
                    stopAtBeginningOfMainSubprogram = true,
                },
            }

            vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, {})
            vim.keymap.set('n', '<leader>dc', dap.continue, {})
            vim.keymap.set('n', '<leader>dt', dapui.toggle, {})
            vim.keymap.set('n', '<F5', dap.continue, {})
            vim.keymap.set('n', '<F10>', dap.step_over, {})
            vim.keymap.set('n', '<F11>', dap.step_into, {})
            vim.keymap.set('n', '<S-F11>', dap.step_out, {})
            vim.keymap.set('n', '<leader>dr', dap.restart, {})
            vim.keymap.set('n', '<leader>ds', dap.close, {})
            vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function()
                require('dap.ui.widgets').hover()
            end)
        end,
    },
    {
        'theHamsta/nvim-dap-virtual-text'
    },
    {
        'jay-babu/mason-nvim-dap.nvim',
        dependencies = {
            'williamboman/mason.nvim',
            'mfussenegger/nvim-dap'
        },
        opts = {
            handlers = {}
        }
    },
}
