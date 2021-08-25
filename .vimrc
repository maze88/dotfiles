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

" navigation
set scrolloff=8

" misc
set title
set wildmenu
autocmd BufNewFile,BufRead *akefile*,*.sublime-settings set noexpandtab
autocmd BufWritePost .vimrc source $MYVIMRC
set updatetime=320

" colors: default/badwolf/firecode/gruvbox/ron/sublimemonokai/random
colorscheme sublimemonokai

" syntax
syntax on
set background=dark
set list
set listchars=
set listchars+=tab:│·
set listchars+=trail:·
autocmd BufNewFile,BufRead .vimrc         setfiletype vim
autocmd BufNewFile,BufRead .*rc           setfiletype bash
autocmd BufNewFile,BufRead *ockerfile*    setfiletype dockerfile
autocmd BufNewFile,BufRead *enkinsfile*   setfiletype groovy
autocmd BufNewFile,BufRead ~/*kube*config setfiletype yaml
autocmd BufNewFile,BufRead *.hcl          setfiletype lua

" key mappings
inoremap jj <Esc>
nnoremap Y y$
nnoremap H :nohlsearch<CR>
noremap <F7> :setlocal spell!<CR>
" write then make
nnoremap <C-m> :w<CR>:make<CR><CR><CR>
" substitute all instances of current word under cursor
nnoremap S #:%s/<C-r>+//g<Left><Left>
" hide all decorations (spellcheck, gitgutter, code completion)
nmap <silent><F5> :setlocal nospell<CR>:GitGutterDisable<CR>:CocDisable<CR>
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
  Plug 'neoclide/coc.nvim', {'branch': 'release'}  " requires node >=12.12
  Plug 'tpope/vim-surround'
call plug#end()

" plugin settings: gitgutter
nnoremap <F6> :GitGutterToggle<CR>
highlight clear SignColumn
highlight GitGutterDelete guifg=#ff2222 ctermfg=1
highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#dddd00 ctermfg=3

" plugin settings: fzf
nnoremap <C-p> :Files<CR>
nnoremap <C-b> :Buffers<CR>
nnoremap <C-l> :Lines<CR>
nnoremap <C-g> :GFiles<CR>
nmap <C-o> <C-p>

" plugin settings: coc
let g:coc_global_extensions = ['coc-json', 'coc-markdownlint', 'coc-prettier', 'coc-python', 'coc-sh', 'coc-yaml' ]  " coc-python requires `pip3 install jedi`
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
inoremap <silent><expr><C-@>   coc#refresh()
inoremap <silent><expr><Tab>   pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<Tab>" : coc#refresh()
inoremap <silent><expr><S-Tab> pumvisible() ? "\<C-p>" : "\<C-h>"
nnoremap <silent><F8> :call <SID>coc_toggle()<CR>

