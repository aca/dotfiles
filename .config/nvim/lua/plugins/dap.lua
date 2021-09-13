if vim.g._minimal then
  return
end

local dap = require("dap")

vim.g.dap_virtual_text = true

dap.set_log_level("TRACE")

dap.adapters.go = function(callback, config)
    local handle
    local pid_or_err
    local port = 38697
    handle, pid_or_err =
        vim.loop.spawn(
        "dlv",
        {
            args = {"dap", "-l", "127.0.0.1:" .. port},
            detached = true
        },
        function(code)
            handle:close()
            print("Delve exited with exit code: " .. code)
        end
    )
    -- Wait 100ms for delve to start
    vim.defer_fn(
        function()
            --dap.repl.open()
            callback({type = "server", host = "127.0.0.1", port = port})
        end,
        500
    )
end

-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
dap.configurations.go = {
    {
        type = "go",
        name = "Debug",
        request = "launch",
        program = "${file}"
    },
    {
        type = "go",
        name = "Debug test", -- configuration for debugging test files
        mode = "test",
        request = "launch",
        program = "./${relativeFileDirname}"
    }
}

vim.cmd(
    [[
nnoremap <silent> 'c :lua require'dap'.continue()<CR>
nnoremap <silent> 'n :lua require'dap'.step_over()<CR>
nnoremap <silent> 'i :lua require'dap'.step_into()<CR>
nnoremap <silent> 'o :lua require'dap'.step_out()<CR>
nnoremap <silent> 'b :lua require'dap'.toggle_breakpoint()<CR>
" nnoremap <silent> <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
" nnoremap <silent> <leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
" nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>
" nnoremap <silent> <leader>dl :lua require'dap'.run_last()<CR>

]]
)

require("dapui").setup()
