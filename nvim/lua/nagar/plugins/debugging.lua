local helpers = require("nagar/plugins/resources/helper")
return {
    {
        "folke/lazydev.nvim",
        opts = {
            library = {
                "nvim-dap-ui",
            },
        },
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "folke/lazydev.nvim",
        },
    },
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")
            dapui.setup()

            vim.api.nvim_set_hl(
                0,
                "DapStoppedLine",
                { default = true, link = "Visual" }
            )
            vim.fn.sign_define("DapBreakpoint", {
                text = "🛑",
                texthl = "DapBreakpoint",
                linehl = "",
                numhl = "",
            })
            vim.fn.sign_define("DapStopped", {
                text = "→",
                texthl = "DapStopped",
                linehl = "DapStoppedLine",
                numhl = "",
            })

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

            dap.listeners.before["event_progressStart"]["progress-notifications"] = function(
                session,
                body
            )
                local notif_data =
                    helpers.get_notif_data("dap", body.progressId)

                local message =
                    helpers.format_message(body.message, body.percentage)
                notif_data.notification = vim.notify(message, "info", {
                    title = helpers.format_title(
                        body.title,
                        session.config.type
                    ),
                    icon = helpers.spinner_frames[1],
                    timeout = false,
                    hide_from_history = false,
                })

                notif_data.notification.spinner = 1
                helpers.update_spinner("dap", body.progressId)
            end

            dap.listeners.before["event_progressUpdate"]["progress-notifications"] = function(
                session,
                body
            )
                local notif_data =
                    helpers.get_notif_data("dap", body.progressId)
                notif_data.notification = vim.notify(
                    helpers.format_message(body.message, body.percentage),
                    "info",
                    {
                        replace = notif_data.notification,
                        hide_from_history = false,
                    }
                )
            end

            dap.listeners.before["event_progressEnd"]["progress-notifications"] = function(
                session,
                body
            )
                local notif_data = helpers.client_notifs["dap"][body.progressId]
                notif_data.notification = vim.notify(
                    body.message and helpers.format_message(body.message)
                        or "Complete",
                    "info",
                    {
                        icon = "",
                        replace = notif_data.notification,
                        timeout = 3000,
                    }
                )
                notif_data.spinner = nil
            end

            dap.adapters.cppdbg = {
                id = "cppdbg",
                type = "executable",
                command = "/home/archishman/Documents/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
            }

            dap.adapters.gdb = {
                type = "executable",
                command = "gdb",
                args = {
                    "--interpreter=dap",
                    "--eval-command",
                    "set print pretty on",
                },
            }

            dap.adapters.codelldb = {
                type = "executable",
                command = "codelldb", -- or if not in $PATH: "/absolute/path/to/codelldb"

                -- On windows you may have to uncomment this:
                -- detached = false,
            }

            dap.configurations.cpp = {
                {
                    name = "CPPDBG: Launch",
                    type = "cppdbg",
                    request = "launch",
                    --'${fileDirname}/${fileBasenameNoExtension}',
                    program = function()
                        return vim.fn.input(
                            "Path to executable: ",
                            vim.fn.getcwd() .. "/",
                            "file"
                        )
                    end,
                    args = {},
                    stopOnEntry = false,
                    cwd = "${workspaceFolder}",
                    environment = {},
                    externalConsole = false,
                    MIMode = "gdb",
                    setupCommands = {
                        {
                            description = "Enable pretty-printing for gdb",
                            text = "-enable-pretty-printing",
                            ignoreFailures = true,
                        },
                    },
                    miDebuggerPath = "/usr/bin/gdb",
                },
                {
                    name = "GDB: Launch",
                    type = "gdb",
                    request = "launch",
                    program = function()
                        return vim.fn.input(
                            "Path to executable: ",
                            vim.fn.getcwd() .. "/",
                            "file"
                        )
                    end,
                    cwd = "${workspaceFolder}",
                    stopAtBeginningOfMainSubprogram = false,
                },
                {
                    name = "CodeLLDB: Launch",
                    type = "codelldb",
                    request = "launch",
                    program = function()
                        return vim.fn.input(
                            "Path to executable: ",
                            vim.fn.getcwd() .. "/",
                            "file"
                        )
                    end,
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                },
            }

            dap.configurations.c = dap.configurations.cpp

            vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, {})
            vim.keymap.set("n", "<leader>dc", dap.continue, {})
            vim.keymap.set("n", "<leader>dt", dapui.toggle, {})
            vim.keymap.set("n", "<leader>dn", dap.step_over, {})
            vim.keymap.set("n", "<leader>di", dap.step_into, {})
            vim.keymap.set("n", "<leader>do", dap.step_out, {})
            vim.keymap.set("n", "<F5", dap.continue, {})
            vim.keymap.set("n", "<F10>", dap.step_over, {})
            vim.keymap.set("n", "<F11>", dap.step_into, {})
            vim.keymap.set("n", "<S-F11>", dap.step_out, {})
            vim.keymap.set("n", "<leader>dr", dap.restart, {})
            vim.keymap.set("n", "<leader>ds", dap.close, {})
            vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
                require("dap.ui.widgets").hover()
            end)
        end,
    },
    {
        "theHamsta/nvim-dap-virtual-text",
        config = function()
            require("nvim-dap-virtual-text").setup({
                enabled = true,
                enable_commands = true,
                highlight_changed_variables = true,
                highlight_new_as_changed = false,
                show_stop_reason = true,
                commented = false,
                only_first_definition = true,
                all_references = false,
                clear_on_continue = false,
                virt_text_pos = "eol",
                all_frames = false,
                text_prefix = " ",
                separator = " ",
                error_prefix = " ",
                info_prefix = " ",
                virt_lines = false,
                virt_lines_above = true,
                display_callback = function(
                    variable,
                    buf,
                    stackframe,
                    node,
                    options
                )
                    -- by default, strip out new line characters
                    --
                    if options.virt_text_pos == "inline" then
                        return " = " .. variable.value:gsub("%s+", " ")
                    else
                        return variable.name
                            .. " = "
                            .. variable.value:gsub("%s+", " ")
                    end
                end,
                filter_references_pattern = nil,
            })
        end,
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = {
            "mason-org/mason.nvim",
            "mfussenegger/nvim-dap",
        },
        opts = {
            handlers = {},
        },
    },
}
