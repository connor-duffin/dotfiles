" line numbering
set number
set relativenumber

" syntax highlighting
filetype plugin on
syntax on

" misc settings
set cc=80
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'
set nofoldenable
set mouse=a
set laststatus=2
set statusline+=%F
set clipboard=unnamed

" colors
colorscheme gruvbox
let g:gruvbox_contrast_dark = 'medium'
set background=dark

" hotkeys
map <C-n> :NERDTreeToggle<CR>
nnoremap j gj
nnoremap k gk
nnoremap L gt
nnoremap H gT
nnoremap <C-q> :q!<CR>
nnoremap <C-j> <C-W><C-j>
nnoremap <C-k> <C-W><C-k>
nnoremap <C-l> <C-W><C-l>
nnoremap <C-h> <C-W><C-h>

" set tabs = 2
set tabstop=2
set expandtab
set shiftwidth=2
set softtabstop=2

" indentation settings (i don't want indentation)
" set noai nocin nosi inde=<CR>

" gvim options (if needed)
set guioptions-=m  "menu bar
set guioptions-=T  "toolbar
set guioptions-=r  "scrollbar

" install vim-plug if not already installed
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" all my plugins
call plug#begin('~/.vim/plugged') " dir = ~/.vim/plugged
Plug 'morhetz/gruvbox'
Plug 'scrooloose/nerdtree'
Plug 'christoomey/vim-tmux-navigator'
Plug 'vim-python/python-syntax'
call plug#end()

" more misc settings
let g:python_highlight_all = 1

" turn off indentation NO MATTER WHAT
" filetype indent off
