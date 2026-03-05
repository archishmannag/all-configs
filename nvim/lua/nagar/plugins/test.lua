return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        "orjangj/neotest-ctest",
    },
    keys = function()
        local neotest = require("neotest")

        return {
            {
                "<leader>tf",
                function()
                    neotest.run.run(vim.fn.expand("%"))
                end,
                desc = "Run File",
            },
            {
                "<leader>tt",
                function()
                    neotest.run.run()
                end,
                desc = "Run Nearest",
            },
            {
                "<leader>tw",
                function()
                    neotest.run.run(vim.loop.cwd())
                end,
                desc = "Run Workspace",
            },
            {
                "<leader>tr",
                function()
                    neotest.output.open({ short = true, auto_close = true })
                end,
                desc = "Results (short)",
            },
            {
                "<leader>tR",
                function()
                    neotest.output.open({ enter = true })
                end,
                desc = "Results (full)",
            },
            {
                "<leader>ts",
                function()
                    neotest.summary.toggle()
                end,
            },
            {
                "<leader>to",
                function()
                    neotest.output_panel.toggle()
                end,
            },
        }
    end,
    config = function()
        local neotest_ns = vim.api.nvim_create_namespace("neotest")
        vim.diagnostic.config({
            virtual_text = {
                format = function(diagnostic)
                    local message = diagnostic.message:gsub("[\r\n\t%s]+", " ")
                    return message
                end,
            },
        }, neotest_ns)
        require("neotest").setup({
            adapters = {
                require("neotest-ctest").setup({
                    is_test_file = function(file_path)
                        local lib = require("neotest.lib")
                        local elems = vim.split(
                            file_path,
                            lib.files.sep,
                            { plain = true }
                        )
                        local name, extension = unpack(
                            vim.split(elems[#elems], ".", { plain = true })
                        )
                        local supported_extensions =
                            { "cpp", "cc", "cxx", "cppm" }
                        return vim.tbl_contains(supported_extensions, extension)
                                and vim.endswith(name, "_test")
                            or false
                    end,
                }),
            },
        })
    end,
}
