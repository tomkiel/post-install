call plug#begin()
      
Plug 'morhetz/gruvbox'
Plug 'terryma/vim-multiple-cursors'
Plug 'HerringtonDarkholme/yats.vim' " TS Syntax
Plug 'junegunn/fzf', {'dir': '~/.fz', 'do': './install --all'}
Plug 'junegunn/fzf.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'SirVer/ultisnips'
Plug 'preservim/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'
"Plug 'christoomey/vim-tmux-navigator'
Plug 'scrooloose/nerdcommenter'
Plug 'neoclide/vim-jsx-improve'
Plug 'iamcco/markdown-preview.nvim', {'do': 'cd app & npm install'}
Plug 'tpope/vim-fugitive'
Plug 'dsawardekar/wordpress.vim'
Plug 'tpope/vim-haml'
Plug 'xolox/vim-session'
Plug 'xolox/vim-misc'
Plug 'keith/swift.vim'

call plug#end()

colorscheme gruvbox

"Set default functions
set hidden
set number
set relativenumber
set inccommand=split
set background=dark

syntax enable
set tabstop=4      
set softtabstop=4   
set shiftwidth=4    
set expandtab      
set autoindent
set copyindent

"nnoremap <c-A> :vsplit $HOME/.config/nvim/init.vim<cr>
nnoremap <c-r> :source $HOME/.config/nvim/init.vim<cr>

nnoremap <c-p> :Files<cr>
nnoremap <c-f> :Ag<space>
nnoremap <c-z> :u<cr>
nnoremap <c-s> :w<cr>
nnoremap <c-q> :wq!<cr>
nnoremap <c-d> :q<cr>
nnoremap <c-a> ggVG<cr>
nnoremap <c-i> ==<cr>
nnoremap <c-h> :/<space>
nnoremap <c-c> y<cr>
nnoremap <c-v> p<cr>
nnoremap <delete> dd<cr>
nnoremap <c-l> :NERDTreeToggle<cr>
nmap <Tab> :bp<CR>
nnoremap <c-t> :NERDTreeFocus<cr>
inoremap <c-s> <c-o>:w<cr> 


"let g:UltiSnipsEditSplit = 'vertical'
"let g:UltiSnipsSnipperDir = '~/.config/nvim/UltiSnips'

"Autoboot commands
"autocmd vimenter * NERDTree

"NerdTree
let g:NERDTreeIgnore = ['^node_modules$']
"let g:NERDTreeGitStatusWithFlags = 3
let g:NERDTreeWinPos = "left"
let g:nerdtree_tabs_open_on_console_startup=0
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let NERDTreeShowHidden=1

"coc config
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint', 
  \ 'coc-prettier', 
  \ 'coc-json',
  \ 'coc-html',
    \ 'coc-css'
  \ ]


