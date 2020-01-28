function! myspacevim#before() abort
  autocmd FileType yaml setlocal tabstop=2 softtabstop=3 shiftwidth=2 expandtab
  set wrap
  set formatoptions-=t

  nmap = :bn<CR>
  nmap - :bp<CR>

  set noswapfile

  " update file for ctags
  " vi ~/.rusty-tags/config.toml 
  " # the file name used for vi tags
  " vi_tags = "/home/cason.adams/.ctags"

  autocmd BufRead *.rs :setlocal tags=/home/cason.adams/.ctags;/
  autocmd BufWritePost *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!

  " rustfmt on write using autoformat
  autocmd BufWrite * :Neoformat
  nnoremap <leader>c :!cargo clippy
endfunction

function! myspacevim#after() abort
endfunction
