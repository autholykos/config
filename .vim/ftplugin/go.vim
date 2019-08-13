setlocal noexpandtab
setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4

""******************************************************************
" VIM-GO SETUP
""******************************************************************
nmap <leader>b <Plug>(go-build)
nmap <leader>r <Plug>(go-run)
nmap <leader>db <Plug>(go-doc-browser)

" Allowing coc to do the `gd` (GoDef) resolution
let g:go_def_mapping_enabled = 0

" style
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_functions = 1

let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['vet', 'golint']

function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

let g:go_list_type = "quickfix"
let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 1

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_structs = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_space_tab_error = 0
let g:go_highlight_array_whitespace_error = 0
let g:go_highlight_trailing_whitespace_error = 0

command! -bang A call go#alternate#Switch(<bang>0, 'edit')   et g:go_highlight_extra_types = 1
command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
command! -bang AS call go#alternate#Switch(<bang>0, 'split')
command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
                                                              
nmap <Leader>dd <Plug>(go-def-vertical)
nmap <Leader>dv <Plug>(go-doc-vertical)
nmap <Leader>db <Plug>(go-doc-browser)
                                                              
nmap <leader>r  <Plug>(go-run)
nmap <leader>t  <Plug>(go-test)
nmap <Leader>gt <Plug>(go-coverage-toggle)
nmap <Leader>i <Plug>(go-info)
nmap <silent> <Leader>l <Plug>(go-metalinter)
nmap <C-g> :GoDecls<cr>
nmap <leader>dr :GoDeclsDir<cr>
nmap <leader>rb :<C-u>call <SID>build_go_files()<CR>
