""" setup Vundle """
set nocompatible              " be iMproved, required
filetype off               

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'morhetz/gruvbox'
Plugin 'flazz/vim-colorschemes'
Plugin 'chriskempson/base16-vim'
Plugin 'wlangstroth/vim-racket'
Plugin 'PotatoesMaster/i3-vim-syntax'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'nanotech/jellybeans.vim'
Plugin 'mbbill/desertEx'
Plugin 'croaker/mustang-vim'
Plugin 'vim-scripts/xoria256.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/syntastic'
Plugin 'airblade/vim-gitgutter'
Plugin 'rking/ag.vim'
Plugin 'mileszs/ack.vim'
Plugin 'junegunn/fzf.vim'
Plugin 'bkad/CamelCaseMotion'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-repeat'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'JamshedVesuna/vim-markdown-preview'

call vundle#end()            
filetype plugin indent on   

""" key mappings """
inoremap jk <Esc>

" python environment variable
let $PYTHONPATH='/usr/lib/python3.5/site-packages'

set fileformats="unix,dox,mac"

set fileencodings="utf-8,cp1251,kio8-r,cp866"

" Enable a nice big viminfo file
set viminfo='1000,f1,:1000,/1000

set history=1000
set undolevels=1000

" Number of spaces that a <Tab> in the file counts for.
set tabstop=4		

" Number of spaces to use for each step of (auto)indent.
set shiftwidth=4	

" When on, a <Tab> in front of a line inserts blanks
" according to 'shiftwidth'. 'tabstop' is used in other.
set expandtab       

" When on, a <Tab> in front of a line inserts blanks
" according to 'shiftwidth'. 'tabstop' is used in other
" places. 
set smarttab        

" toggles paste option(switch vim in paste mod).
set pastetoggle=<F2>	

" Show (partial) command in status line.
set showcmd         

" Highlight matching parens
set showmatch       

" When there is a previous search pattern, highlight all
" its matches.
set hlsearch        

" While typing a search command, show immediately where the
" so far typed pattern matches.
set incsearch       

" Ignore case in search patterns.
set ignorecase      

" Override the 'ignorecase' option if the search pattern
" contains upper case characters.
set smartcase       

" Baskspace over everything.
set backspace=indent,eol,start     

" Copy indent from current line when starting a new line
set autoindent      

" C style indents.
set cindent         

" lazy screen redrawing when executing scripts.
set lazyredraw      

" Minimal number of screen lines to keep above and below 
" the cursor.
set scrolloff=3     

set nowrap
autocmd FileType text setlocal textwidth=80

" enable folds
set foldenable

" always show the status line
set laststatus=2    

" Always display the tabline, even if there is only one tab
set showtabline=2 

" Hide the default mode text (e.g. -- INSERT -- below the statusline)
set noshowmode 

set statusline=%t%m%r%h%w\ %10{&encoding}\ %20b,0x%B\ %10l,%v\ %10p%%

" Enable alternative keyboard layout (C-^ to switch)
set keymap=russian-jcuken
"set keymap=ukrainian-jcuken
set iminsert=0
set imsearch=0

" Easier keyboard mappings for keyboard layout switching
inoremap <C-Space> <C-^>
nnoremap <C-Space> a<C-^><Esc>

" Enable spell cheking for certain types of files
autocmd FileType gitcommit setlocal spell
autocmd FileType text      setlocal spell
autocmd FileType plaintex  setlocal spell
autocmd FileType tex       setlocal spell

" autocompletion mode(list all and complete to general on first <Tab> then full completion)
set wildmode=list:longest,full      
set wildmenu

" Syntax highlighting
syntax on                           

" filetype settings
filetype on         
filetype indent on
filetype plugin on

" completion that works in macro
set wildcharm=<Tab>                 

menu Exec.racket    :w<Cr>:!racket -u % <Cr>

map <F7> :tabp
map <F8> :tabn

map <F4> :emenu Exec.<Tab>

menu Encoding.koi8-r  :e ++enc=koi8-r<CR>
menu Encoding.cp1251  :e ++enc=cp1251<CR>
menu Encoding.cp866   :e ++enc=cp866<CR>
menu Encoding.ucs-2le :e ++enc=ucs-2le<CR>
menu Encoding.utf-8   :e ++enc=utf-8<CR>

menu SetSpell.ru  :set spl=ru spell<CR>
menu SetSpell.en  :set spl=en spell<CR>
menu SetSpell.uk  :set spl=uk spell<CR>
menu SetSpell.off :set nospell<CR>

" on/off highligh search match
map <F3> :set hlsearch! <Cr>        

if !has('gui_running')
    " 256 color mode
    set t_Co=256                    
   
    " for gruvbox colorscheme in terminal(disable when gui)
    let g:gruvbox_italic=0          

    " disable mouse capture in terminal
    set mouse=                      
else
    " No toolbar, menu or scrollbars in the GUI
    set guioptions-=m
    set guioptions-=T
    set guioptions-=l
    set guioptions-=L
    set guioptions-=r
    set guioptions-=R
    set lines=9999 columns=9999
endif

colorscheme gruvbox
set background=dark

"hi Normal guibg=NONE ctermbg=NONE
"hi NonText ctermbg=none


" make, commpiler for different systems.
if has('win32')                     
    set makeprg=nmake
    compiler msvc
else
    set makeprg=make
    compiler gcc
endif

" safely alias commads
fun! SetupCommandAlias(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfun

call SetupCommandAlias("W","w")
call SetupCommandAlias("Q","q")
call SetupCommandAlias("Wq","wq")
call SetupCommandAlias("WQ","wq")


""" Syntastic setup """
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

""" vim-gutter """
set updatetime=250

""" vim-airline """
let g:airline_powerline_fonts = 1

""" ag.vim """
let g:ag_prg="/usr/bin/ag --vimgrep"

""" camelcasemotion """
map <silent> gw <Plug>CamelCaseMotion_w
map <silent> gb <Plug>CamelCaseMotion_b
map <silent> ge <Plug>CamelCaseMotion_e
omap <silent> giw <Plug>CamelCaseMotion_iw
omap <silent> gib <Plug>CamelCaseMotion_ib
omap <silent> gie <Plug>CamelCaseMotion_ie
xmap <silent> giw <Plug>CamelCaseMotion_iw
xmap <silent> gib <Plug>CamelCaseMotion_ib
xmap <silent> gie <Plug>CamelCaseMotion_ie

""" Vim Markdown """"
let g:vim_markdown_folding_disabled = 1

""" Vim Markdown Preview """
let vim_markdown_preview_github=1
let vim_markdown_preview_use_xdg_open=1
