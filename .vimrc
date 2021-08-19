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

" reload .vimrc on change
autocmd BufWritePost .vimrc source $MYVIMRC

" plugin manager
let vim_plug_url = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
if empty(glob('~/.vim/autoload/plug.vim'))
  silent execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs '.vim_plug_url
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" plugins
call plug#end()  " can affect other settings - consider editing function in source
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'tpope/vim-surround'
call plug#end()

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
" fzf (plugin)
nmap <C-p> :Files<CR>
nmap <C-b> :Buffers<CR>
nmap <C-l> :Lines<CR>
nmap <C-g> :GFiles<CR>
nmap <C-o> <C-p>
