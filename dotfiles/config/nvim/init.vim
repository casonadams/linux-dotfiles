"------------------------------------------------
" Plugins START
call plug#begin()
  Plug 'airblade/vim-gitgutter'
  Plug 'cespare/vim-toml'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'itchyny/lightline.vim'
  Plug 'junegunn/vim-easy-align'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'mengelbrecht/lightline-bufferline'
  Plug 'morhetz/gruvbox'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'tpope/vim-commentary'
call plug#end()
" Plugins END
"------------------------------------------------

"------------------------------------------------
" Settings START
let mapleader = "\<Space>"
filetype plugin on
set mouse=a
set nobackup
set nocompatible
set noswapfile
set nowritebackup
set number
set signcolumn=yes
set title
set wrap
setlocal wrap
" Settings END
"------------------------------------------------

"------------------------------------------------
" persist START
set undofile " Maintain undo history between sessions
set undodir=~/.vim/undodir

" Persist cursor
autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
  \ |   exe "normal! g`\""
  \ | endif
" persist END
"------------------------------------------------

"------------------------------------------------
" Theme START
syntax on
set termguicolors
colorscheme gruvbox
set background=dark
set cursorline
set hidden
set cmdheight=1
set list
set listchars=tab:»·,trail:·

nmap <Leader>t :call Terminal()<CR>
function! Terminal()
  :set splitbelow
  :set splitright
  :10split
  :set laststatus=0
  :set scl=no
  :set nonu
  :term
endfunction
autocmd TermOpen * startinsert
" tnoremap <Esc> <C-\><C-n><CR>

tnoremap <Esc> <C-\><C-n> <bar> :call ExitTerminal()<CR>
function! ExitTerminal()
  :set nosplitbelow
  :set nosplitright
  :set laststatus=2
  :set scl=yes
  :set number
  :q!
endfunction

" let buffers be clickable
let g:lightline#bufferline#clickable=1
let g:lightline#bufferline#shorten_path=1
let g:lightline#bufferline#min_buffer_count=1

let g:lightline = {
  \ 'colorscheme': 'jellybeans',
  \ 'active': {
  \   'left': [ [], [], [ 'relativepath' ] ],
  \   'right': [ [], [], [ 'lineinfo', 'percent' ] ]
  \ },
  \ 'inactive': {
  \   'left': [ [], [], [ 'relativepath' ] ],
  \   'right': [ [], [], [ 'lineinfo', 'percent' ] ]
  \ },
  \ 'subseparator': {
  \   'left': '', 'right': ''
  \ },
  \ 'tabline': {
  \   'left': [ ['buffers'] ],
  \   'right': [ [] ]
  \ },
  \ 'tabline_separator': {
  \   'left': "", 'right': ""
  \ },
  \ 'tabline_subseparator': {
  \   'left': "", 'right': ""
  \ },
  \ 'component_expand': {
  \   'buffers': 'lightline#bufferline#buffers'
  \ },
  \ 'component_raw': {
  \   'buffers': 1
  \ },
  \ 'component_type': {
  \   'buffers': 'tabsel'
  \ }
  \ }

" Theme END
"------------------------------------------------

"------------------------------------------------
" Remaps START
" Align GitHub-flavored Markdown tables
au FileType markdown vmap <Leader><Bslash> :EasyAlign*<Bar><Enter>

" Toggle between buffers
nmap <Leader>bn :bn<CR>
nmap <Leader>bp :bp<CR>
nnoremap <C-p> :Rg<Cr>
nnoremap <C-e> :Files<Cr>
nmap <Leader>bl :Buffers<CR>
nmap <Leader>g :GFiles<CR>
nmap <Leader>e :Files<CR>
nmap <Leader>p :Rg<CR>
nmap <Leader>g? :GFiles?<CR>
nmap <Leader>h :History<CR>
" Remaps END
"------------------------------------------------

"------------------------------------------------
" Coc START
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
