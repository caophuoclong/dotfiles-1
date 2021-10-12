-- Auto format on save
vim.api.nvim_command [[augroup Format]]
vim.api.nvim_command [[autocmd!]]
vim.api.nvim_command [[autocmd BufWritePre * try | undojoin | Neoformat | catch /^Vim\%((\a\+)\)\=:E790/ | finally | silent Neoformat | endtry]]
vim.api.nvim_command [[augroup END]]
