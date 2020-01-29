function! myspacevim#before() abort
  autocmd FileType yaml setlocal tabstop=2 softtabstop=3 shiftwidth=2 expandtab
  set wrap
  set formatoptions-=t

  nmap = :bn<CR>
  nmap - :bp<CR>

  set noswapfile

" Need racer installed!:w
" https://rls.booyaa.wtf/install/

  autocmd BufRead *.rs :setlocal tags=/home/cason.adams/.ctags;/
  autocmd BufWritePost *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!

  " rustfmt on write using autoformat
  autocmd BufWrite * :Neoformat
  nnoremap <leader>c :!cargo clippy
endfunction

function! myspacevim#after() abort
endfunction
