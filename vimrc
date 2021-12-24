" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" --------------------
"  plugin install
" --------------------
call plug#begin('~/.vim/plugged')

" colorscheme
Plug 'joshdick/onedark.vim'
Plug 'sheerun/vim-polyglot'
Plug 'lifepillar/vim-gruvbox8'
Plug 'rakr/vim-one'

" linestatus
Plug 'itchyny/lightline.vim'

" file navigation: <Leader>-n
Plug 'preservim/nerdtree'

" float terminal
Plug 'voldikss/vim-floaterm'

" tag
Plug 'ludovicchabant/vim-gutentags'
" Plug 'skywind3000/gutentags_plus'
Plug 'preservim/tagbar'

" comment: gc, <Leader>-c-c
Plug 'tpope/vim-commentary'

" auto pair
Plug 'jiangmiao/auto-pairs'

" python
" Plug 'davidhalter/jedi-vim'


call plug#end()

" --------------------
"  general
" --------------------

" basic
set nocompatible
syntax on
filetype plugin indent on

" colorscheme
if has('gui_running')
	set background=dark
	" set background=light
	" colorscheme onedark
	colorscheme gruvbox8
else
	set t_Co=256
	set background=dark
	" set background=light
	colorscheme gruvbox8
	" colorscheme onedark
endif
" set background=dark        " for the light version
" let g:one_allow_italics = 1 " I love italic for comments
" colorscheme gruvbox8

let &t_ut=''

" <leader>
let mapleader = " "

" --------------------
"  user interface
" --------------------

" line number
set nu " number lines
set rnu " relative line numbering

" search
set incsearch " incremental search (as string is being typed)
set hls " highlight search
set ignorecase
set smartcase

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" tab
set noexpandtab
set shiftwidth=8
" set softtabstop=4
set tabstop=8

" indent
set ai "Auto indent
set si "Smart indent

" line
set lbr " line break
set wrap "Wrap lines
" height current line
augroup CursorLineOnlyInActiveWindow
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
augroup END
" Return to last edit position when opening files 
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" window
set splitbelow
set splitright
" guiwindow
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar
hi VertSplit guibg=bg guifg=bg
set guifont=JetBrainsMonoNerdFontCompleteM-Medium:h18

" Turn backup off
set nobackup
set nowb
set noswapfile

" misc
set listchars=tab:>>,nbsp:~ " set list to see tabs and non-breakable spaces
set showmatch
set scrolloff=10 " show lines above and below cursor (when possible)
set cmdheight=1
set lazyredraw
set autochdir
set hidden " allow auto-hiding of edited buffers
set laststatus=2

" auto wrap
" 如果您在插入模式下输入时的目标是在窗口边缘自动软换行文本（仅在视觉上）
" set textwidth=0
" set wrapmargin=0
" set wrap
" set linebreak # (optional - breaks by word rather than character)
" 如果您在输入插入模式时的目标是在 80 列处自动硬换行文本（通过在实际文本文件中插入新行）
set textwidth=80
set wrapmargin=0
set formatoptions+=t
set linebreak " (optional - breaks by word rather than character)
" 如果您的目标是在插入模式下键入时自动软换行 80 列文本（仅在视觉上）
" set textwidth=0
" set wrapmargin=0
" set wrap
" set linebreak # (optional - breaks by word rather than character)
" set columns=80 # <<< THIS IS THE IMPORTANT PART

" --------------------
"  map
" --------------------

let mapleader = " "

" insert mode move
inoremap <C-H> <Left>
inoremap <C-l> <Right>
inoremap <C-j> <Down>
inoremap <C-k> <Up>

" windows navigate
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k



" --------------------
" Plugin configuration
" --------------------

" NERDTree
" ----------
nnoremap <c-n> :NERDTreeToggle<CR>

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" onedark
let g:onedark_hide_endofbuffer=1
let g:onedark_terminal_italics=1

" lightline 
let g:lightline = {
	\ 'colorscheme': 'powerline',
	\ 'active': {
	\   'left': [ [ 'Girl', 'paste' ],
	\             [ 'readonly', 'filename', 'modified' ] ],
	\   'right': [ [ 'lineinfo' ],
	\              [ 'percent' ],
	\              [ 'fileformat', 'fileencoding', 'filetype' ] ]
	\ },
	\ 'component': {
	\   'Girl': 'YuFei 👫 XiaoQ ',
	\   'Boy': 'დ 👫Yu Fei '
	\ },
	\ }


" auto-pair
" ----------
"  avoid <c-H> delete char, weird thing
" let g:AutoPairsMapCh = 0
" let g:AutoPairsMapBS = 0
"
"
"
" vim-gutentags
" python tag (put venv and .pytags under project)
 let g:gutentags_file_list_command = {
     \ 'markers': {
	 \ '.pytags': '~/.vim/help-sh/python_file_lister',
	 \ },
     \ }

 " gen tags or not
set statusline+=%{gutentags#statusline()}

let g:gutentags_project_root = [ '.pytags', '.git', '.root', '.project' ]

let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

" " enable gtags module
" let g:gutentags_modules = ['ctags', 'gtags_cscope']

" let g:gutentags_plus_switch = 1

" let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']

" let g:gutentags_auto_add_gtags_cscope = 0

" let $GTAGSLABEL = 'native-pygments'
" let $GTAGSCONF = '/opt/local/share/gtags/gtags.conf'
" " let $GTAGSFORCECPP = 1
" set cscopeprg='gtags-cscope'
" let g:gutentags_plus_nomap = 1
" noremap <silent> <leader>gs :GscopeFind s <C-R><C-W><cr>
" noremap <silent> <leader>gg :GscopeFind g <C-R><C-W><cr>
" noremap <silent> <leader>gc :GscopeFind c <C-R><C-W><cr>
" noremap <silent> <leader>gt :GscopeFind t <C-R><C-W><cr>
" noremap <silent> <leader>ge :GscopeFind e <C-R><C-W><cr>
" noremap <silent> <leader>gf :GscopeFind f <C-R>=expand("<cfile>")<cr><cr>
" noremap <silent> <leader>gi :GscopeFind i <C-R>=expand("<cfile>")<cr><cr>
" noremap <silent> <leader>gd :GscopeFind d <C-R><C-W><cr>
" noremap <silent> <leader>ga :GscopeFind a <C-R><C-W><cr>
" noremap <silent> <leader>gz :GscopeFind z <C-R><C-W><cr>

" let g:gutentags_define_advanced_commands = 1
" tagbar
nnoremap <c-g> :TagbarToggle<CR>