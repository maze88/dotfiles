" line numbers and coordinates
set relativenumber
set number
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

" colors
colorscheme default  " favorites: default/badwolf/gruvbox/firecode/ron/sublimemonokai
set background=dark

" syntax
syntax on
autocmd BufNewFile,BufRead .*rc           setfiletype sh
autocmd bufnewfile,BufRead *ockerfile*    setfiletype dockerfile
autocmd BufNewFile,BufRead *enkinsfile*   setfiletype groovy
autocmd BufNewFile,BufRead ~/*kube*config setfiletype yaml
autocmd BufNewFile,BufRead *akefile*      set noexpandtab
set list
set listchars=
set listchars+=tab:│·
set listchars+=trail:·

" key mappings
imap ;; <esc>
imap jj <esc>
nmap Q <Nop>
" spellcheck
imap <F7> <C-o>:setlocal spell! spelllang=en_us<CR>
map <F7>       :setlocal spell! spelllang=en_us<CR>
" shift+s to substitute all instances of current word under cursor
noremap <S-s> #:%s/<C-r>+//g<left><left>
