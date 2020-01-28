" # Install univeral-ctags
" # https://snapcraft.io/install/universal-ctags/fedora

" # Install neovim 0.5 or greater
" https://github.com/neovim/neovim/releases

" # Install rust deps
" # install rust
" curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

" # install rustfmt (for formatting)
" rustup component add rustfmt

" # install clippy (for semantic linting)
" rustup component add clippy

" # hardest one last, install rust-analyzer
" git clone https://github.com/rust-analyzer/rust-analyzer && cd rust-analyzer
" cargo xtask install --server

" # Install vim-plug
" curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" nvim
" :PlugInstall

" pip install pynvim

" cargo install rusty-tags

" # ~/.rusty-tags/config.toml
" # the file name used for vi tags
" # vi_tags = "rusty-tags.vi"
" vi_tags = "/home/cason.adams/.ctags"


call plug#begin()
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/syntastic'
Plug 'neovim/nvim-lsp'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/deoplete-lsp'
Plug 'ervandew/supertab'
Plug 'majutsushi/tagbar'
Plug 'Chiel92/vim-autoformat'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'morhetz/gruvbox'
Plug 'kien/ctrlp.vim'
Plug 'editorconfig/editorconfig-vim'
" Plug 'w0rp/ale'
Plug 'cespare/vim-toml'
Plug 'tmux-plugins/vim-tmux-focus-events'
call plug#end()
filetype plugin indent on    " required

let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

let g:syntastic_check_on_open = 1

syntax on
set hidden
set title
set number

" Set tabwidth
set tabstop=4
set softtabstop=0 noexpandtab
set shiftwidth=4
set noswapfile

" Wrap gitcommit file types at the appropriate length
filetype indent plugin on

autocmd BufRead *.rs :setlocal tags=/home/cason.adams/.ctags;/
autocmd BufWritePost *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!

set background=dark
colorscheme gruvbox

" Theme
let g:airline_theme = 'gruvbox'
let g:airline#extensions#tabline#enabled = 1
let g:airline_extensions = ['branch', 'tabline']
let g:airline_powerline_fonts = 1

" Buffers
nmap = :bn<CR>
nmap - :bp<CR>

set mouse=a
nmap <F8> :TagbarToggle<CR>

"let g:rust_use_custom_ctags_defs = 1
"let g:tagbar_type_rust = {
"			\ 'ctagsbin' : '/var/lib/snapd/snap/bin/universal-ctags',
"			\ 'ctagstype' : 'rust',
"			\ 'kinds' : [
"			\ 'n:modules',
"			\ 's:structures:1',
"			\ 'i:interfaces',
"			\ 'c:implementations',
"			\ 'f:functions:1',
"			\ 'g:enumerations:1',
"			\ 't:type aliases:1:0',
"			\ 'v:constants:1:0',
"			\ 'M:macros:1',
"			\ 'm:fields:1:0',
"			\ 'e:enum variants:1:0',
"			\ 'P:methods:1',
"			\ ],
"			\ 'sro': '::',
"			\ 'kind2scope' : {
"			\ 'n': 'module',
"			\ 's': 'struct',
"			\ 'i': 'interface',
"			\ 'c': 'implementation',
"			\ 'f': 'function',
"			\ 'g': 'enum',
"			\ 't': 'typedef',
"			\ 'v': 'variable',
"			\ 'M': 'macro',
"			\ 'm': 'field',
"			\ 'e': 'enumerator',
"			\ 'P': 'method',
"			\ },
"			\ }


nmap <F3> :NERDTreeToggle<CR>

" auto reloads file changes on focus in tmux
set autoread
au FocusGained,BufEnter * :checktime

" setup rust_analyzer LSP (IDE features)
lua require'nvim_lsp'.rust_analyzer.setup{}

" Use LSP omni-completion in Rust files
autocmd Filetype rust setlocal omnifunc=v:lua.vim.lsp.omnifunc

" Enable deoplete autocompletion in Rust files
let g:deoplete#enable_at_startup = 1

" customise deoplete                                                                                                                                                     " maximum candidate window length
call deoplete#custom#source('_', 'max_menu_width', 40)

" Press Tab to scroll _down_ a list of auto-completions
let g:SuperTabDefaultCompletionType = "<c-n>"

" rustfmt on write using autoformat
autocmd BufWrite * :Autoformat

"TODO: clippy on write
autocmd BufWrite * :Autoformat

nnoremap <leader>c :!cargo clippy
