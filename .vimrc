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

" colors: default/badwolf/firecode/gruvbox/ron/sublimemonokai
colorscheme gruvbox
set background=dark

" syntax
syntax on
autocmd BufNewFile,BufRead .*rc           setfiletype bash
autocmd bufnewfile,BufRead *ockerfile*    setfiletype dockerfile
autocmd BufNewFile,BufRead *enkinsfile*   setfiletype groovy
autocmd BufNewFile,BufRead ~/*kube*config setfiletype yaml
autocmd BufNewFile,BufRead *akefile*      set noexpandtab
set list
set listchars=
set listchars+=tab:│·
set listchars+=trail:·

" key mappings
imap jj <esc>
nmap Q <Nop>
" spellcheck
map <F7>       :setlocal spell! spelllang=en_us<CR>
imap <F7> <C-o>:setlocal spell! spelllang=en_us<CR>
" substitute all instances of current word under cursor
nmap <S-s> #:%s/<C-r>+//g<left><left>
" move current line or selection up/down
nmap <C-K> :m -2<CR>==
nmap <C-J> :m +1<CR>==
vmap <C-K> :m '<-2<CR>gv=gv
vmap <C-J> :m '>+1<CR>gv=gv
