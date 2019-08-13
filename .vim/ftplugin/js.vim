setlocal noexpandtab
setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2

command! -nargs=0 Prettier :CocCommand prettier.formatFile
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
