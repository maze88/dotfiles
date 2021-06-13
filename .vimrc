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

" colors, syntax and highlights
syntax on
colorscheme default  " default/ron/firecode/jellybeans/mono_sw/random/sublimemolokai
set background=dark
autocmd BufNewFile,BufRead .*rc         setfiletype sh
autocmd bufnewfile,BufRead *ockerfile*  setfiletype dockerfile
autocmd BufNewFile,BufRead *enkinsfile* setfiletype groovy
set list
set listchars=
set listchars+=tab:│·
set listchars+=trail:·

" key mappings
imap jj <esc>
imap kk <esc>0
nmap Q <Nop>
" spellcheck
imap <F7> <C-o>:setlocal spell! spelllang=en_us<CR>
map <F7> :setlocal spell! spelllang=en_us<CR>
" shift+s to substitue all instances of current word under cursor
noremap <S-s> #:%s/<C-r>+//g<left><left>
