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

" all my plugins 
call plug#begin('~/.vim/plugged') " dir = ~/.vim/plugged
Plug 'lervag/vimtex'
Plug 'tpope/vim-surround'
Plug 'morhetz/gruvbox'
Plug 'scrooloose/nerdtree'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-pandoc/vim-rmarkdown'
Plug 'rstudio/rmarkdown'
Plug 'bfrg/vim-cpp-modern'
Plug 'jpalardy/vim-slime'
Plug 'christoomey/vim-tmux-navigator'
Plug 'maverickg/stan.vim'
Plug 'vim-syntastic/syntastic'
Plug 'nvie/vim-flake8'
Plug 'JuliaEditorSupport/julia-vim'
Plug 'vim-python/python-syntax'
call plug#end()

" more misc settings
let g:vim_markdown_folding_disabled = 1
let g:vimtex_view_method = 'zathura' " set zathura as default pdf
let g:pandoc#syntax#conceal#use = 0 " stop hiding syntax
let g:slime_target = 'tmux'
let g:slime_default_config = {'socket_name': 'default', 'target_pane': '{left-of}'}
let g:python_highlight_all = 1

" syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" syntastic file types
let g:syntastic_enable_r_lintr_checker = 1
let g:syntastic_r_checkers = ['lintr']
let g:syntastic_python_checkers=['flake8']
let g:syntastic_tex_checkers = []

" syntastic automatic settings
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

" turn off indentation NO MATTER WHAT
" filetype indent off
