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
autocmd BufWritePost .vimrc source $MYVIMRC
set title
set wildmenu

" colors: default/badwolf/firecode/gruvbox/ron/sublimemonokai
colorscheme sublimemonokai
set background=dark

" syntax
syntax enable
autocmd BufNewFile,BufRead .vimrc         setfiletype vim
autocmd BufNewFile,BufRead .*rc           setfiletype bash
autocmd BufNewFile,BufRead *ockerfile*    setfiletype dockerfile
autocmd BufNewFile,BufRead *enkinsfile*   setfiletype groovy
autocmd BufNewFile,BufRead ~/*kube*config setfiletype yaml
autocmd BufNewFile,BufRead *.hcl          setfiletype lua
autocmd BufNewFile,BufRead *akefile*,*.sublime-settings set noexpandtab
set list
set listchars=
set listchars+=tab:│·
set listchars+=trail:·

" plugin manager
let vim_plug_git = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
if empty(glob('~/.vim/autoload/plug.vim'))
  silent execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs '.vim_plug_git
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" plugins
call plug#begin()
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'tpope/vim-surround'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}  " requires node >=12.12
call plug#end()

" fzf (plugin) settings
nmap <C-o> <C-p>
nmap <C-p> :Files<CR>
nmap <C-b> :Buffers<CR>
nmap <C-l> :Lines<CR>
nmap <C-g> :GFiles<CR>

" coc (plugin) settings
let g:coc_global_extensions = ['coc-json', 'coc-markdownlint', 'coc-prettier', 'coc-python', 'coc-sh', 'coc-yaml' ]  " coc-python requireds `pip3 install jedi`; other extensions chosen from https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions
inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" key mappings
imap jj <Esc>
nmap Q <Nop>
nmap Y y$
nmap H :noh<CR>
nmap <C-m> :w<CR>:make<CR><CR><CR>
" substitute all instances of current word under cursor
nmap S #:%s/<C-r>+//g<Left><Left>
" spellcheck
map <F7>       :setlocal spell!<CR>
imap <F7> <C-o>:setlocal spell!<CR>
" move current line or selection up/down
nmap <C-k> :m -2<CR>
nmap <C-j> :m +1<CR>
vmap <C-k> :m '<-2<CR>gv
vmap <C-j> :m '>+1<CR>gv
