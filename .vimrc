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

" prevent bell and error sounds
set noerrorbells
set visualbell
set t_vb=

" misc
set title
set wildmenu
set scrolloff=15
set updatetime=320
autocmd BufWritePost .vimrc source $MYVIMRC
" fix spellcheck not highlighting in some colorschemes (must be *before* colorscheme command)
autocmd VimEnter,ColorScheme,BufReadPost * highlight SpellBad cterm=underline ctermbg=52 ctermfg=196
autocmd BufNewFile,BufRead *akefile*,.gitconfig set noexpandtab

" syntax and colors
syntax enable
" favorite colors: default/badwolf/firecode/gruvbox/ron/sublimemonokai/random
colorscheme gruvbox
set background=dark
set list
set listchars=
set listchars+=tab:│·
set listchars+=trail:·
autocmd BufNewFile,BufRead .vimrc         setfiletype vim
autocmd BufNewFile,BufRead .*rc           setfiletype bash
autocmd BufNewFile,BufRead *ockerfile*    setfiletype dockerfile
autocmd BufNewFile,BufRead *.hcl          setfiletype lua
autocmd BufNewFile,BufRead *enkinsfile*   setfiletype groovy
autocmd BufNewFile,BufRead ~/*kube*config setfiletype yaml

" key mappings
inoremap jj <Esc>
nnoremap Y y$
nnoremap H :nohlsearch<CR>
noremap <F7> :setlocal spell!<CR>
nnoremap <C-m> :w<CR>:make<CR><CR><CR>
" substitute all instances of current word under cursor
nnoremap S #:%s/<C-r>+//g<Left><Left>
" hide all decorations (spellcheck, search highlights, gitgutter, code completion)
nmap <silent><F5> :setlocal nospell<CR>:nohlsearch<CR>:GitGutterDisable<CR>:CocDisable<CR>
" move current line or selection up/down
nnoremap <C-k> :m -2<CR>
nnoremap <C-j> :m +1<CR>
vnoremap <C-k> :m '<-2<CR>gv
vnoremap <C-j> :m '>+1<CR>gv
" cover for commands typos
command W w
command Q q
command Wq wq

" install plugin manager
let vim_plug_git = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
if empty(glob('~/.vim/autoload/plug.vim'))
  silent execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs '.vim_plug_git
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" auto install missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)')) | PlugInstall --sync | source $MYVIMRC | endif

" plugin downloads
call plug#begin()
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-surround'
  "Plug 'neoclide/coc.nvim', {'branch': 'release'}
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

" plugin settings: coc
let g:coc_global_extensions = ['coc-json', 'coc-prettier', 'coc-python', 'coc-sh', 'coc-yaml' ]  " coc-python requires `pip3 install jedi`
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
function! s:coc_toggle()
  if g:coc_enabled
    CocDisable
  else
    CocEnable
  endif
endfunction
nnoremap <silent><F8> :call <SID>coc_toggle()<CR>
inoremap <silent><expr><C-@>   coc#refresh()
inoremap <silent><expr><Tab>   pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<Tab>" : coc#refresh()
inoremap <silent><expr><S-Tab> pumvisible() ? "\<C-p>" : "\<C-h>"
