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

" colors and syntax
" favorites: badwolf/firecode/gruvbox/slate/sublimemonokai
colorscheme badwolf
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
" fix spellcheck not highlighting in some colorschemes
autocmd VimEnter,ColorScheme,BufReadPost * highlight SpellBad cterm=underline ctermbg=52 ctermfg=196

" prevent bell and error sounds
set noerrorbells
set visualbell
set t_vb=

" misc
autocmd BufWritePost $MYVIMRC source $MYVIMRC
set title
set wildmenu
set scrolloff=13
set updatetime=500
set foldmethod=indent
set foldlevel=99
set cursorline

" key mappings
inoremap jj <Esc>
nnoremap Y y$
nnoremap H :nohlsearch<CR>
nnoremap <F7>      :setlocal spell!<CR>
inoremap <F7> <C-o>:setlocal spell!<CR>
nnoremap <silent> <F5> :setlocal nospell<CR>:nohlsearch<CR>
nnoremap <C-m> :w<CR>:make<CR><CR><CR>
" search and replace all instances of current word under cursor
nnoremap S #:%s/<C-r>+//g<Left><Left>
" move current line or selection up/down
nnoremap <silent> <C-k> :m -2<CR>
nnoremap <silent> <C-j> :m +1<CR>
vnoremap <silent> <C-k> :m '<-2<CR>gv
vnoremap <silent> <C-j> :m '>+1<CR>gv
" improve indentation shortcuts
nnoremap < <<
nnoremap > >>
vnoremap <silent> < <gv
vnoremap <silent> > >gv
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
nnoremap <leader>w :set wrap!<CR>
nnoremap <leader>s :setlocal spell!<CR>
nnoremap <Leader>b :let &background=(&background == 'dark' ? 'light' : 'dark')<CR>
nnoremap <expr> <leader>f &foldlevel ? 'zM' :'zR'

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
if has_key(plugs, 'vim-commentary')
  nnoremap <silent> <C-_> :Commentary<CR>
  vnoremap <silent> <C-_> :Commentary<CR>gv
endif

" plugin settings: gitgutter
if has_key(plugs, 'vim-gitgutter')
  nnoremap <leader>g :GitGutterToggle<CR>
  nnoremap <F6>      :GitGutterToggle<CR>
  autocmd VimEnter,ColorScheme * highlight clear SignColumn
  autocmd VimEnter,ColorScheme * highlight GitGutterDelete  ctermbg=NONE ctermfg=1
  autocmd VimEnter,ColorScheme * highlight GitGutterAdd     ctermbg=NONE ctermfg=2
  autocmd VimEnter,ColorScheme * highlight GitGutterChange  ctermbg=NONE ctermfg=3
endif

" plugin settings: fzf
if has_key(plugs, 'fzf.vim')
  nnoremap <C-p> :Files<CR>
  nnoremap <C-b> :Buffers<CR>
  nnoremap <C-l> :Lines<CR>
  nnoremap <C-g> :GFiles<CR>
  nmap <C-o> <C-p>
endif

" plugin settings: vim-surround
if has_key(plugs, 'vim-surround')
  for s in ['"', "'", '`', '*', '_', ')', ']', '}']
    execute 'nmap ys'.s.' ysiw'.s
  endfor
  nmap ys( ysiw)
  nmap ys[ ysiw]
  nmap ys{ ysiw}
  " can also visual surround with: vS*
endif
