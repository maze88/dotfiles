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
colorscheme badwolf
set background=dark

" syntax
syntax on
autocmd BufNewFile,BufRead .vimrc         setfiletype vim
autocmd BufNewFile,BufRead .*rc           setfiletype bash
autocmd bufnewfile,BufRead *ockerfile*    setfiletype dockerfile
autocmd BufNewFile,BufRead *enkinsfile*   setfiletype groovy
autocmd BufNewFile,BufRead ~/*kube*config setfiletype yaml
autocmd BufNewFile,BufRead *akefile*      set noexpandtab
set list
set listchars=
set listchars+=tab:│·
set listchars+=trail:·

" vim-plug (plugin manager)
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl --insecure -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" vim-plug (plugins)
call plug#begin()
" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call plug#end()

" key mappings
imap jj <esc>
nmap Q <Nop>
map H :noh<CR>
" substitute all instances of current word under cursor
nmap <S-s> #:%s/<C-r>+//g<left><left>
" spellcheck
map <F7>       :setlocal spell!<CR>
imap <F7> <C-o>:setlocal spell!<CR>
" move current line or selection up/down
nmap <C-k> :m -2<CR>==
nmap <C-j> :m +1<CR>==
vmap <C-k> :m '<-2<CR>gv=gv
vmap <C-j> :m '>+1<CR>gv=gv
" fzf (plugin)
let $FZF_DEFAULT_COMMAND = 'find .'
nmap <C-p> :Files<CR>
nmap <C-g> :GFiles<CR>
nmap <C-b> :Buffers<CR>
nmap <C-l> :Lines<CR>
