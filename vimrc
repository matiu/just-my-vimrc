"
"
" Remove ALL autocommands for the current group.

set nocompatible


filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" alternatively, pass a path where Vundle should install bundles
"let path = '~/some/path/here'
"call vundle#rc(path)

" let Vundle manage Vundle, required
Plugin 'gmarik/vundle'
Plugin 'jlanzarotta/bufexplorer'
" Plugin 'guileen/vim-node' " generates an error.

" colorschemes
Plugin 'nanotech/jellybeans.vim'
Plugin 'Lokaltog/vim-distinguished'

Plugin 'godlygeek/tabular'
Plugin 'vim-scripts/IndexedSearch'
Plugin 'scrooloose/syntastic'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'pangloss/vim-javascript'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'tomtom/tcomment_vim'
Plugin 'Raimondi/delimitMate'
Plugin 'gcmt/breeze.vim'
imap <C-c> <CR><Esc>O

Plugin 'Valloric/YouCompleteMe'
" These are the tweaks I apply to YCM's config, you don't need them but they might help.
" YCM gives you popups and splits by default that some people might not like, so these should tidy it up a bit for you.
"let g:ycm_add_preview_to_completeopt=0
"let g:ycm_confirm_extra_conf=0
"set completeopt-=preview

Plugin 'marijnh/tern_for_vim'





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
set tabstop    =4         " number of spaces that a <Tab> in the file counts for
set matchpairs+=<:>
set shiftround

set statusline=%F%m%r%h%w\ [TYPE=%Y\ %{&ff}]\ [%l/%L\ (%p%%)]  
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set ls=2

filetype on  
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

"
" Tags config
"
:set tags=./tags,tags

" GUI
"set guifont=Monospace\ 9
"set guioptions-=T "hide toolbar "

"set guifont=Andale\ Mono:h12
"hi MBEVisibleNormal guibg=yellow guifg=red
"hi MBEVisibleChanged guibg=blue guifg=red

 
function! RunFindRef()
    let word = expand("<cword>")

    echo "running...findref " . word 

    let cmd = "/usr/local/bin/ggrep  -srnw --binary-files=without-match --exclude-dir=.git --exclude-from=.gitignore " . word

    botright new
"    execute 'file find_ref_' . word 

    setlocal buftype=nofile nobuflisted noswapfile nowrap
    setlocal isfname-=:
    execute '$read !'. cmd
    execute 'm/'.word 
    setlocal nomodifiable
    1
endfunction




function! RunQuery()
    let line = substitute(substitute(getline("."),'\[.*$','',''),'^[^ ]*','','')
    let line = line[1:]


    echo "running..." . line

    let cmd = "/cinemaki/utils/test_query.pl h_" . line

    botright new
    setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
"    call setline(1, 'Bibliosoft Query    ' . line)
"    call setline(2,substitute(getline(1),'.','=','g'))

    execute '$read !'. cmd
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

autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1   
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1


au BufRead,BufNewFile *.js	set tabstop                =2      
au BufRead,BufNewFile *.js	set shiftwidth             =2     
au BufRead,BufNewFile *.haml,*rb,*jade	set tabstop    =2         " ruby's styles....
au BufRead,BufNewFile *.haml,*rb,*jade	set shiftwidth =2         " ruby's styles....


"au BufRead,BufNewFile *.tt	source ~/.vim/scripts/closetag.vim 
"au BufRead,BufNewFile *.tt	source ~/.vim/ftplugin/tt.vim

"au BufRead,BufNewFile *.html	source ~/.vim/scripts/closetag.vim 
"au BufRead,BufNewFile *.html	source ~/.vim/ftplugin/tt.vim

au BufWritePost *.tt :silent ! (cd ./deployment/; make devel > /dev/null;)& 
au BufWritePost *.pm :silent ! (/cinemaki/utils/restart.sh > /dev/null)& 
au BufWritePost *.bb :silent ! (/cinemaki/utils/restart.sh > /dev/null)& 
au BufWritePost .vimrc :source ~/.vimrc

if has("unix")
    let s:uname = system("uname")
    if s:uname == "Darwin\n"
        " options for MACOSX
        map <F2> :! /usr/local/Cellar/ctags/5.8/bin/ctags --recurse=yes --exclude=node_modules . <CR>
        map <F3> :execute "!ggrep -srnw --binary-files=without-match --exclude-dir=.git --exclude-dir=node_modules --exclude-from=.gitignore . -e " . expand("<cword>") . " " <bar> cwindow<CR>
        map <F4> :BufExplorer<CR>
        nmap <F7> :bnext<CR>
        map <F8>  :b#<CR>
        nmap <F9> :bprev<CR>
        map <F12> :bdelete<CR>
        nmap <D-}> :bnext<CR>
        nmap <D-{> :bprev<CR>
        map <D-+>  :BufExplorer<CR>
        map <D-\|>  :b#<CR>
        map <D-S-BS> :bdelete<CR>
    else  
        " options for LINUX
        map <F2> :! ctags --recurse=yes  --links=no  --exclude=node_modules  . <CR>
        map <A-P> :!cd ./deployment/;make clean po devel<CR> 
        map <A-I> :!cd ./deployment/;make devel <CR> 
        map <A-A> :!sudo /opt/local/apache2/bin/apachectl -k restart -f ./etc/apache-heavy.conf <CR>
        map <A-C> :! perl -Iperl  -c "%" <CR>
        nmap <A-}> :bnext<CR>
        nmap <A-{> :bprev<CR>
        map <A-+>  :BufExplorer<CR>
        map <A-S-BS> :bdelete<CR>
    endif
else
    " optiones para GUGA    
    " NI A GANCHO :-D
endif



" PARA TODOS...
"
" Main extras
map <silent> ,s :e ./htdocs/devel/cinefis.css<CR>
map <silent> ,j :e ./htdocs/devel/cinefis.js<CR>

vmap ,a  :Align => == ? :<CR>
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

" PERL help for Shift-K
autocmd BufEnter *.pl,*.pm,*.cgi noremap <silent> K :!echo <cWORD> <cword> <bar> perl -e '$line = <STDIN>; if ($line =~ /(\w+::\w+)/){exec("perldoc $1")} elsif($line =~ /(\w+)/){exec "perldoc -f $1 <bar><bar> perldoc $1"}'<cr><cr>


let $PERL5LIB ='./perl'    
"nmap <f1> <ESC>
"imap <f1> <ESC>

" align
"AlignCtrl =lp1P1I 

set hidden

" command-t
"let g:CommandTMaxHeight = 35
set wildignore+=*.o,*.obj,.git,*.pyc,OLD,build,android,mobil,lib,iphone

" configuration to Go To File (gf)
set path=,,.,CK/**,perl/**,tt/**,app/**,public/**

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

