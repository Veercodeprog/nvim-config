vim.api.nvim_exec([[
    augroup prettier_config
        autocmd!
        autocmd BufRead,BufNewFile *.js,*.jsx,*.ts,*.tsx,*.json setlocal formatprg=<path_to_prettier_executable>
    augroup END
]], false)

