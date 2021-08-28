" line numbers and coordinates
set number
set relativenumber
set ruler

" tabs and indention
set tabstop=2
set softtabstop=2
set shiftwidth=2
set autoindent
set expandtab

" search
set hlsearch
set incsearch

" syntax
syntax enable
set list
set listchars=
set listchars+=tab:│·
set listchars+=trail:·
autocmd FileType gitconfig,make set noexpandtab
" filetype associations
autocmd BufNewFile,BufRead .vimrc         setfiletype vim
autocmd BufNewFile,BufRead .*rc           setfiletype bash
autocmd BufNewFile,BufRead *ockerfile*    setfiletype dockerfile
autocmd BufNewFile,BufRead *.hcl          setfiletype lua
autocmd BufNewFile,BufRead *enkinsfile*   setfiletype groovy
autocmd BufNewFile,BufRead ~/*kube*config setfiletype yaml
" fix spellcheck not highlighting in some colorschemes (must be *before* colorscheme command)
autocmd VimEnter,ColorScheme,BufReadPost * highlight SpellBad cterm=underline ctermbg=52 ctermfg=196

" colors: default/badwolf/firecode/gruvbox/ron/sublimemonokai/random
colorscheme sublimemonokai
set background=dark

" prevent bell and error sounds
set noerrorbells
set visualbell
set t_vb=

" misc
autocmd BufWritePost .vimrc source $MYVIMRC
set title
set wildmenu
set scrolloff=13
set updatetime=320
set noswapfile
set cursorline

" key mappings
inoremap jj <Esc>
nnoremap Y y$
nnoremap H :nohlsearch<CR>
noremap <F7> :setlocal spell!<CR>
nnoremap <C-m> :w<CR>:make<CR><CR><CR>
" substitute all instances of current word under cursor
nnoremap S #:%s/<C-r>+//g<Left><Left>
" hide all decorations (spellcheck, search highlights, gitgutter, code completion)
nmap <silent><F5> :setlocal nospell<CR>:nohlsearch<CR>:GitGutterDisable<CR>
" move current line or selection up/down
nnoremap <C-k> :m -2<CR>
nnoremap <C-j> :m +1<CR>
vnoremap <C-k> :m '<-2<CR>gv
vnoremap <C-j> :m '>+1<CR>gv
" cover for commands typos
command W w
command Q q
command Wq wq
" leader mappings
let mapleader = ','
nnoremap <leader>V :e $MYVIMRC<CR>
nnoremap <leader>c :colorscheme random<CR>
nnoremap <leader>n :set number! relativenumber!<CR>
nnoremap <leader>l :set cursorline!<CR>
nnoremap <leader>s :setlocal spell!<CR>

" install plugin manager and auto install any new plugins
let vim_plug_git = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
if empty(glob('~/.vim/autoload/plug.vim'))
  silent execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs '.vim_plug_git
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)')) | PlugInstall --sync | source $MYVIMRC | endif

" plugin downloads
call plug#begin()
  Plug 'airblade/vim-gitgutter'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'tpope/vim-surround'
call plug#end()

" plugin settings: gitgutter
nnoremap <F6> :GitGutterToggle<CR>
autocmd VimEnter,ColorScheme * highlight clear SignColumn
autocmd VimEnter,ColorScheme * highlight GitGutterDelete  ctermbg=NONE ctermfg=1
autocmd VimEnter,ColorScheme * highlight GitGutterAdd     ctermbg=NONE ctermfg=2
autocmd VimEnter,ColorScheme * highlight GitGutterChange  ctermbg=NONE ctermfg=3

" plugin settings: fzf
nnoremap <C-p> :Files<CR>
nnoremap <C-b> :Buffers<CR>
nnoremap <C-l> :Lines<CR>
nnoremap <C-g> :GFiles<CR>
nmap <C-o> <C-p>

" plugin settings: vim-surround
"nnoremap TBD  " surround current word with X
