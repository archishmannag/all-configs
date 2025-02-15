return {
    name = "clang++ build",
    builder = function()
        -- Full path to current file (see :help expand())
        local file = vim.fn.expand("%:p")
        local filedirectory = vim.fn.expand("%:p:h")
        local filebasename = vim.fn.expand("%:t:r")
        return {
            cmd = { "/usr/bin/clang++" },
            args = {
                "-fdiagnostics-color=always",
                "--std=c++23",
                "-stdlib=libc++",
                "-g",
                file,
                "-o",
                filedirectory .. "/" .. filebasename,
            },
            components = { { "on_output_quickfix", open = true }, "default" },
            cwd = filedirectory,
            problemMatcher = { '$gcc' },
        }
    end,
    condition = {
        filetype = { "cpp" },
    }
}
