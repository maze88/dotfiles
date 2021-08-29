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
autocmd BufRead .vimrc                  setfiletype vim
autocmd BufRead ~/*kube*config          setfiletype yaml
autocmd BufRead,BufNewFile .*rc         setfiletype bash
autocmd BufRead,BufNewFile *ockerfile*  setfiletype dockerfile
autocmd BufRead,BufNewFile *.hcl        setfiletype lua
autocmd BufRead,BufNewFile *enkinsfile* setfiletype groovy

" colors: default/badwolf/firecode/gruvbox/ron/sublimemonokai/random
colorscheme badwolf
set background=dark
" fix spellcheck not highlighting in some colorschemes (must be *before* colorscheme command)
autocmd VimEnter,ColorScheme,BufReadPost * highlight SpellBad cterm=underline ctermbg=52 ctermfg=196

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
set cursorline

" key mappings
inoremap jj <Esc>
nnoremap Y y$
nnoremap H :nohlsearch<CR>
noremap  <F7>      :setlocal spell!<CR>
inoremap <F7> <C-o>:setlocal spell!<CR>
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
nnoremap <leader>v :e $MYVIMRC<CR>
nnoremap <leader>c :colorscheme random<CR>
nnoremap <leader>n :set number! relativenumber!<CR>
nnoremap <leader>l :set cursorline!<CR>
nnoremap <leader>s :setlocal spell!<CR>

" install plugin manager and auto install any new plugins
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)')) | PlugInstall --sync | source $MYVIMRC | endif

" plugin downloads
call plug#begin()
  Plug 'tpope/vim-commentary'
  Plug 'airblade/vim-gitgutter'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'tpope/vim-surround'
call plug#end()

" plugin settings: vim-commentary
nnoremap <C-_> :Commentary<CR>
vnoremap <C-_> :Commentary<CR>gv

" plugin settings: gitgutter
nnoremap <leader>g :GitGutterToggle<CR>
nnoremap <F6>      :GitGutterToggle<CR>
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
" to visually surround: v<make selection>S<input surrounding><CR>
