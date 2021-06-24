"          _                    
"   __   _(_)_ __ ___  _ __ ___ 
"   \ \ / / | '_ ` _ \| '__/ __|
"    \ V /| | | | | | | | | (__ 
"   (_)_/ |_|_| |_| |_|_|  \___|
"

set number relativenumber       " hybrid line numbers
set showmode	      	          " show current mode

syntax on	                      " syntax highlighting

set incsearch		                " find as you type search
set hlsearch		                " highlight search terms

set tabstop=2		                " an indentation every 2 columns
set shiftwidth=2	              " use indents of two spaces
set autoindent                  " always set autoindenting on
set copyindent                  " copy the previous indentation when autoindenting

set tw=120                      " automatically wrap lines at 120 characters

set backspace=indent,eol,start  " backspace through anything in insert mode
set expandtab		                " tabs are spaces, not tabs
"set gdefault                    " search/replace "globally" (on a line) by default
set cursorline		              " highlight current line
set showmatch		                " show matching brackets/parentheses
set ruler                       " set ruler
set laststatus=2                " status bar
set cmdheight=2                 " use a status bar that is two lines high

set ignorecase                  " ignore case when searching
set smartcase                   " ignore case if search pattern is all lowercase,
" when 'ignorecase' and 'smartcase' are both on, if a pattern contains an uppercase letter, it is case sensitive, otherwise, it is not.

set smarttab                    " insert tabs on the start of a line according to
                                "    shiftwidth, not tabstop

" change the mapleader from \ to ,
let mapleader=","
let maplocalleader="\\"

" toggle highlighting the cursor line
nnoremap <leader>, :set cursorline!<cr>

" clear a search
map <leader><space> :let @/=''<cr> 

" toggle visualize tabs and newlines
set listchars=tab:▸\ ,eol:¬,nbsp:·

" toggle tabs and eols
map <leader>l :set list!<CR>

" shortcut for writing file
map <leader>w :w<CR>

" make the keyboard faaaaaaast
set ttyfast
set timeout timeoutlen=1000 ttimeoutlen=50

" remap j and k to act as expected when used on long, wrapped, lines
nnoremap j gj
nnoremap k gk

set pastetoggle=<F2> 
" when in insert mode, press <F2> to go to 
"    paste mode, where you can paste mass data
"    that won't be autoindented

set autoread           " automatically reload files changed outside of Vim

set undolevels=1000    " record history accurately

" keep a persistent backup file
if v:version >= 730
    set undofile 
    set undodir=~/.vim/.undo,~/tmp,/tmp
endif

set nobackup                        " do not keep backup files
set nowritebackup                   " do not write out changes via backup files
set noswapfile                      " do not write intermediate swap files,

set directory=~/.vim/.tmp,~/tmp,/tmp
                                      " store swap files in one of these directories
                                      "    (in case swapfile is ever turned on)

set wildmenu                          " make tab completion for files/buffers act like bash
set wildmode=list:full                " show a list when pressing tab and complete first full match
set wildignore=*.swp,*.bak,*.pyc,*.class

set showcmd                           " show (partial) command in the last line of the screen
                                      "    this also shows visual selection info

set scrolloff=4                       " keep 4 lines off the edges of the screen when scrolling

" remove training wheels
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>

" have yank to end of line behave like C and D
nnoremap Y y$

" Jump to matching pairs easily, with Tab
nnoremap <Tab> %
vnoremap <Tab> %

set mouse-=a

" -------------------- Netrw -------------------------------------------
let g:netrw_banner = 0                  " disable banner
let g:netrw_liststyle = 3               " tree-style view
let g:netrw_browse_split = 4            " use the previous window to open file
let g:netrw_winsize = 20               " absolute width of netrw window

" Toggle Vexplore with Ctrl-E
function! ToggleVExplorer()
    if exists("t:expl_buf_num")
        let expl_win_num = bufwinnr(t:expl_buf_num)
        let cur_win_num = winnr()

        if expl_win_num != -1
            while expl_win_num != cur_win_num
                exec "wincmd w"
                let cur_win_num = winnr()
            endwhile

            close
        endif

        unlet t:expl_buf_num
    else
         Vexplore
         let t:expl_buf_num = bufnr("%")
    endif
  endfunction  

map <silent> <C-E> :call ToggleVExplorer()<CR>

" Hit enter in the file browser to open the selected
" file with :vsplit to the right of the browser.
let g:netrw_browse_split = 4
let g:netrw_altv = 1

" Change directory to the current buffer when opening files.
set autochdir
" ---------------- end Netrw -------------------------------------------

" -------------------- vim-plug -----------------------------------------
" auto-install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" youcompleteme
Plug 'valloric/youcompleteme'

" indent-guides
Plug 'nathanaelkane/vim-indent-guides'

" vim-javascript
Plug 'pangloss/vim-javascript'

" surround.vim
Plug 'tpope/vim-surround'

" Initialize plugin system
call plug#end()

" path to clangd
let g:ycm_clangd_binary_path = "/usr/bin/clangd"

" for indent-lines
set background=dark
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_exclude_filetypes = ['help', 'netrw']

" for youcompleteme
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1
" ---------------- end vim-plug -----------------------------------------

" add termdebug - visual interface for interacting with gdb
"   invoke with :Termdebug
packadd termdebug
