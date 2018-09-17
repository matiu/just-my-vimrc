"
"
" Remove ALL autocommands for the current group.

set nocompatible


filetype off                  " required
imap <C-c> <CR><Esc>O

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
"call vundle#rc(path)

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" 
Plugin 'jlanzarotta/bufexplorer'



" colorschemes
Plugin 'nanotech/jellybeans.vim'

" Color indent guides columns
"Plugin 'nathanaelkane/vim-indent-guides'

" To move in a HTML file.
" Plugin 'gcmt/breeze.vim'

" matches tag like <body> </body>
Plugin 'gregsexton/MatchTag'

" matches tag like <body> </body> with %
Plugin 'vim-scripts/matchit.zip'

" JAvascript 
" Plugin 'guileen/vim-node' " generates an error.
Plugin 'Quramy/vim-js-pretty-template'
Plugin 'jason0x43/vim-js-indent'

Plugin 'Valloric/YouCompleteMe'
" For typescript type searchs
"Plugin 'mhartington/vim-typings'
Plugin 'leafgarland/typescript-vim'
"let g:tsuquyomi_use_vimproc=1 
"Plugin 'Quramy/tsuquyomi'
Plugin 'prettier/vim-prettier', {
  \ 'do': 'npm install',
  \ 'for': ['javascript', 'typescript', 'css', 'scss', 'json', 'markdown'] }
"Plugin 'Shougo/vimproc.vim'
"
Plugin 'scrooloose/nerdcommenter' 
Plugin 'Shutnik/jshint2.vim'
"let jshint2_read = 1
"let jshint2_save = 1


"Plugin 'rust-lang/rust.vim'

" Control P for search
Plugin 'ctrlpvim/ctrlp.vim.git'

Plugin 'majutsushi/tagbar'

" C++
"Plugin 'bfrg/vim-cpp-modern'
"Plugin 'Mizuchi/STL-Syntax'

set runtimepath^=~/.vim/bundle/ctrlp.vim

" ctrlp ignores
let g:ctrlp_custom_ignore = '(node_modules|bower_components)$'


" YCM gives you popups and splits by default that some people might not like, so these should tidy it up a bit for you.
let g:ycm_add_preview_to_completeopt=0
let g:ycm_confirm_extra_conf=0
set completeopt-=preview


" map <silent> ,F  :call JsBeautify()<CR>




" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required


autocmd!

"-------------------------------------------------------------------------------
" Use of dictionaries
"-------------------------------------------------------------------------------
" set complete=.,b,t    " (we are very t 'tag' based!')
"-------------------------------------------------------------------------------
" Various settings
"-------------------------------------------------------------------------------
"set autochdir             " change the current working directory
set autoread              " read open files again when changed outside Vim
set autowrite             " write a modified buffer on each :next , ...
set browsedir=buffer	  " Explore the current buffer directory
set incsearch             " use incremental search
set nowrap                " do not wrap lines

set visualbell            " visual bell instead of beeping
set ignorecase
set smartcase
set scrolloff=3

set hlsearch 
set wrap 
set nolinebreak

set showmatch
set fileencodings=ucs-bom,utf-8,iso-8859-15
syntax on

" PERL  Best Practices
"set autoindent
set expandtab
set shiftwidth =4
set tabstop    =2         " number of spaces that a <Tab> in the file counts for
set matchpairs+=<:>
set shiftround

set statusline=%F%m%r%h%w\ [TYPE=%Y\ %{&ff}]\ [%l/%L\ (%p%%)]  
set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set ls=2

filetype on  
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

"
" Tags config
"
:set tags=./tags,tags

function! RunFindRef()
    let word = expand("<cword>")

    echo "running...findref " . word 

    let cmd = "/usr/local/bin/ggrep  -srnw --binary-files=without-match --exclude-dir=.git --exclude-dir=autom4te.cache --exclude-dir=doc  --exclude-dir=browser-extensions --exclude-from=.gitignore --exclude-dir=cordova --exclude-dir=coverage --exclude-dir=node_modules --exclude=*Bundle* --exclude=tags --exclude-dir=build --exclude-dir=lib " . word

    botright new
    "    execute 'file find_ref_' . word 

    setlocal buftype=nofile nobuflisted noswapfile nowrap
    setlocal isfname-=:
    execute '$read !'. cmd
    execute 'sort u'
    execute 'm/'.word 
    setlocal nomodifiable
    1
endfunction

"
" Type configs
"

"set iskeyword=a-z,A-Z,48-57,_,:,
hi link MBEVisibleChanged Error

" PERL -> moved to perl.vim en ft
"autocmd BufNewFile,BufRead *.yaml  setlocal iskeyword=48-57,_,A-Z,a-z,: 
"autocmd BufNewFile,BufRead *.css setlocal iskeyword=@,-,48-57,_,128-167,224-235
"autocmd BufNewFile,BufRead *.js setlocal iskeyword=@,-,48-57,_,128-167,224-235


" Stop fucking XML indentation
autocmd BufEnter *.html setlocal indentexpr=
autocmd BufEnter *.htm setlocal indentexpr=
autocmd BufEnter *.xml setlocal indentexpr=
autocmd BufEnter *.xsd setlocal indentexpr=
autocmd BufEnter *.tmpl setlocal indentexpr=
autocmd BufEnter *.tt setlocal indentexpr=

au BufRead,BufNewFile *.bb		set filetype=bb
au BufRead,BufNewFile *.ejs		set filetype=jst
au BufRead,BufNewFile *.sql		set filetype=mysql
au BufRead,BufNewFile *.tmpl	set filetype=html
au BufRead,BufNewFile *.tt	set filetype=tt2html
au BufRead,BufNewFile *.tt2	set filetype=tt2html
au BufRead,BufNewFile *.log	set filetype=apachelogs

au BufRead,BufNewFile *.js	set tabstop                =2      
au BufRead,BufNewFile *.js	set shiftwidth             =2     
au BufRead,BufNewFile *.haml,*rb,*jade	set tabstop    =2         " ruby's styles....
au BufRead,BufNewFile *.haml,*rb,*jade	set shiftwidth =2         " ruby's styles....

" autoformat when save
au BufWritePost .vimrc :source ~/.vimrc
" au BufWrite *.js  :call JsBeautify()

if has("unix")
    let s:uname = system("uname")
    if s:uname == "Darwin\n"
        " options for MACOSX
        map ,t :! ctags --recurse=yes  --links=no  --exclude=node_modules  . <CR>
        nmap ,y :TagbarToggle<CR>
        map <F3> :execute "!ggrep -srnw --binary-files=without-match --exclude-dir=.git --exclude-dir=node_modules --exclude-from=.gitignore . -e " . expand("<cword>") . " " <bar> cwindow<CR>
        nmap <F4> :TagbarToggle<CR>
        
        map <F12> :bdelete<CR>
        nmap <D-}> :bnext<CR>
        nmap <D-{> :bprev<CR>
        map <D-+>  :BufExplorer<CR>
        map <D-\|>  :b#<CR>
        map <D-S-BS> :bdelete<CR>
    else  
        " options for LINUX
    endif
else
    " optiones para GUGA    
    " NI A GANCHO :-D
endif



" PARA TODOS...
"
vmap ,a  :Align => == ? :<CR>
nnoremap <silent> <Leader>b :TagbarToggle<CR>

"map <silent> ,v A<CR>[% USE Dumper; Dumper.dump_html( );%]<ESC><BS><BS><BS><BS><BS>a

function! InsertConsoleLog()
    let word = expand("<cword>")
    let linenumber = line(".")

    if strlen(word)>1
        execute "normal A \<BS>\<CR>\<ESC>0Aconsole.log('[" . expand('%:t'). "." .linenumber.':'.word.":]',".word."); //TODO"
    else
        execute "normal A \<BS>\<CR>\<ESC>0Aconsole.log('[" . expand('%:t'). "." .linenumber."]'); //TODO"
    endif
endfunction
map <silent> ,v :call InsertConsoleLog()<CR>
map <silent> ,f  :call RunFindRef()<CR>
map ,p :make <CR>

" align
"AlignCtrl =lp1P1I 

set hidden

" command-t
"let g:CommandTMaxHeight = 35
set wildignore+=*.o,*.obj,.git,*.pyc,OLD,build,android,mobil,lib,iphone

set isfname-=:


" syntax highlighting
set t_Co=256
syntax on
set background=dark
colorscheme jellybeans
"colorscheme distinguished

" closetags
let g:closetag_html_style=1 

set dict=/usr/share/dict/words

"map <Left> <Nop>
"map <Right> <Nop>
"map <Up> <Nop>
"map <Down> <Nop>

execute pathogen#infect()

set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 1

"let g:syntastic_cpp_clang_tidy_args = "-- -I. -Wc++11-extensions"
"let g:syntastic_cpp_checkers = ['clang_tidy']

