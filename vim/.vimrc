" ==========================================================
" Minimal Visual Vim (single file) — modern nvim-like feel
" ==========================================================
set runtimepath^=~/.config/vim
set runtimepath+=~/.config/vim/after

set nocompatible
filetype plugin indent on
syntax enable
set encoding=utf-8

" --------------------------
" UI / Visual
" --------------------------
set termguicolors
set number
set relativenumber
set cursorline
set signcolumn=yes
set showcmd
set noshowmode
set laststatus=2
set ruler
set cmdheight=1

" Make splits behave nicely
set splitbelow
set splitright

" Comfortable scrolling
set scrolloff=8
set sidescrolloff=8

" Hide extra UI noise
set shortmess+=c
set nowrap

" Better redraw/feel
set updatetime=200
set lazyredraw
set ttimeout
set ttimeoutlen=10
set timeoutlen=400

" --------------------------
" Colorscheme (no plugins)
" --------------------------
" If you want Rose Pine in Vim without plugins, you need a colorscheme file.
" For now: use a built-in scheme that looks clean in dark terminals.
" Pick ONE:
set background=dark
colorscheme rosepine_moon
" alternatives you might like:
" colorscheme evening
" colorscheme desert
" colorscheme slate

" If you later install a rose-pine vim colorscheme file, replace the above with:
" colorscheme rose-pine-moon

" Slightly softer UI (tweak to taste)
hi! link CursorLineNr Number
hi! link SignColumn LineNr

" --------------------------
" Indentation / Tabs
" --------------------------
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
set smartindent

" --------------------------
" Search
" --------------------------
set ignorecase
set smartcase
set incsearch
set hlsearch

" Clear highlight with <leader>h
let mapleader=" "
nnoremap <silent> <leader>h :nohlsearch<CR>

" --------------------------
" Whitespace visuals
" --------------------------
set list
set listchars=tab:»·,trail:·,extends:›,precedes:‹,nbsp:␣

" --------------------------
" Line wrapping visuals (if you ever enable wrap)
" --------------------------
set breakindent
set showbreak=↳\

" --------------------------
" Clipboard (works if Vim compiled with +clipboard)
" --------------------------
if has("clipboard")
  set clipboard=unnamedplus
endif

" --------------------------
" Mouse + true terminal behavior
" --------------------------
set mouse=a

" --------------------------
" Statusline (no plugin)
" --------------------------
set statusline=
set statusline+=\ %f                      " file
set statusline+=%m%r%h%w                  " flags
set statusline+=\ %=                      " split left/right
set statusline+=\ %y                      " filetype
set statusline+=\ [%{&fileencoding?&fileencoding:&encoding}]
set statusline+=\ [%{&fileformat}]
set statusline+=\ %l:%c                   " line:col
set statusline+=\ %p%%                    " percent

" --------------------------
" Tabs: hide tabline if only one (nvim-like)
" --------------------------
set showtabline=1

" --------------------------
" Keymaps (lightweight)
" --------------------------
" Save/quit
nnoremap <silent> <leader>w :w<CR>
nnoremap <silent> <leader>q :q<CR>

" Split navigation (nvim muscle memory)
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-j> <C-w>j
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-l> <C-w>l

" Resize splits
nnoremap <silent> <leader><Left>  :vertical resize -5<CR>
nnoremap <silent> <leader><Right> :vertical resize +5<CR>
nnoremap <silent> <leader><Up>    :resize +3<CR>
nnoremap <silent> <leader><Down>  :resize -3<CR>

" Better Y behavior (copy whole line like nvim)
nnoremap Y y$

" --------------------------
" Cursor shape (best-effort in terminal Vim)
" --------------------------
" Kitty + Vim: you can request cursor shape changes via DECSCUSR.
" This generally works in modern terminals.
" 1=block, 3=underline, 5=beam
let &t_SI = "\e[5 q"   " insert: beam
let &t_EI = "\e[1 q"   " normal: block
let &t_SR = "\e[3 q"   " replace: underline

" ==========================================================
" End
" ==========================================================

