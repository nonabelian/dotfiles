 " ######  Options ############################################################

set nocompatible			" Use Vim defaults (much better!)
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'christoomey/vim-tmux-navigator'

call vundle#end()            " required
filetype plugin indent on    " required

set clipboard=unnamed
set encoding=utf-8

let g:NERDTreeWinSize = 37
set wildignore+=*.pyc,__pycache__,*.swp
let NERDTreeRespectWildIgnore=1
let python_highlight_all=1
let g:airline_theme='bubblegum'
let g:airline_powerline_fonts = 1

" -----------------------------------------------------------
" 						Syntastic settings
" -----------------------------------------------------------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set statusline+=%{gutentags#statusline()}
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
"let g:syntastic_enable_signs = 0
"let g:syntastic_enable_balloons = 0
"let g:syntastic_echo_current_error = 0
let g:syntastic_enable_highlighting = 0
"let g:syntastic_debug = 32
"let g:syntastic_mode_map = {"mode": "passive"}
"let g:syntastic_python_checker = ["pyflakes"]

" -----------------------------------------------------------
" 						CtrlP settings
" -----------------------------------------------------------
let g:ctrlp_dotfiles            = 1
let g:ctrlp_show_hidden         = 1
let g:ctrlp_cmd                 = 'CtrlPMixed'       " search anything (in files, buffers and MRU files at the same time.)
let g:ctrlp_cmd                 = 'CtrlP'
let g:ctrlp_working_path_mode   = 'ra'               " search for nearest ancestor like .git, .hg, and the directory of the current file
let g:ctrlp_match_window        = 'top,order:ttb'
let g:ctrlp_max_height          = 12                 " maxiumum height of match window
let g:ctrlp_switch_buffer       = 'et'               " jump to a file if it's open already
let g:ctrlp_use_caching         = 1                  " enable caching
let g:ctrlp_clear_cache_on_exit = 0                  " speed up by not removing clearing cache evertime
let g:ctrlp_mruf_max            = 250                " number of recently opened files

if exists('g:ctrlp_user_command')
    unlet g:ctrlp_user_command
end

if exists('g:ctrlp_custom_ignore')
    unlet g:ctrlp_custom_ignore
end

if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'"
  let g:ctrlp_use_caching = 0
else
  let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
  "let g:ctrlp_user_command = 'git ls-files . --cached --exclude-standard --others'
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others']
endif

" -----------------------------------------------------------
" 						Settings
" -----------------------------------------------------------
set bs=2					" allow backspacing over everything in insert mode
set viminfo='20,\"50		" read/write a .viminfo file, don't store more
							" than 50 lines of registers
set history=50				" keep 50 lines of command line history
set ruler					" show the cursor position all the time
set incsearch   	        " show matches while searching
set errorformat=%f:%l:\ %m  " some super cool vim ideas courtesy of silas
set noerrorbells vb t_vb=   " i'd like to give him 'mad props'
set laststatus=2
set background=light
"set tags=tags;/
"set statusline=%1*%n:%f\ %=%l/%L\ \ \ \ \ \ \ \ %%%p\ \ \ \ \ \ \ \ \ %{GetTime()}

" Set 4-space tabs for everything.  Later can change to be file specific.
set tabstop=4 softtabstop=0 noexpandtab shiftwidth=4

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
  " Put this (below) in an autocmd function call:
  " source ~/.vim/syntax/dylan.vim
endif

" -----------------------------------------------------------
" 						Mappings
" -----------------------------------------------------------

map Q gq			" Don't use Ex mode, use Q for formatting
map ,q ZQ			" Map it, ZQ too dangerous
map ,z ZZ			" Easy save

" Redraw in case of screen garbage
nmap ,r :CtrlPClearCache<cr>:NERDTreeFocus<cr>R<c-w><c-p>:redraw!<CR>

map <F1> :SyntasticToggleMode <CR>
map ,n :NERDTreeToggle <CR>
map ,f :NERDTreeFind <CR>

map <C-Z> :sh <CR>		" Make suspend spawn a shell

" Syntax Checking
map ,t :SyntasticCheck pylint <CR>

" Tags!
map ,s :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
map ,i :sp <CR>:exec("tag ".expand("<cword>"))<CR>
map ,p :CtrlPTag <CR>
"map ,c :!ctags -R *<CR>

" Git!
map ,gs :Gstatus <CR>
map ,gc :Gcommit <CR>
map ,gp :Gpush <CR>
map ,gsp :execute @g <CR>		" Specific git command

"map LL :!konqueror <cWORD><CR>	" open webpage
" Mac specific : <Home> and <End>
nmap [H <Home>
nmap [F <End>
map! [H <Home>
map! [F <End>

nmap ,v :set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
imap ,v <Esc>:set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
nmap ,c :.w !pbcopy<CR><CR>
vmap ,c :w !pbcopy<CR><CR>
"vnoremap <silent> <leader>y :<CR>:let @a=@" \| execute "normal! vgvy" \| let res=system("pbcopy", @") \| let @"=@a<CR>

" some extra commands for HTML editing
nmap ,mh wbgueyei<<ESC>ea></<ESC>pa><ESC>bba
nmap ,h1 _i<h1><ESC>A</h1><ESC>
nmap ,h2 _i<h2><ESC>A</h2><ESC>
nmap ,h3 _i<h3><ESC>A</h3><ESC>
nmap ,h4 _i<h4><ESC>A</h4><ESC>
nmap ,h5 _i<h5><ESC>A</h5><ESC>
nmap ,h6 _i<h6><ESC>A</h6><ESC>
nmap ,hb wbi<b><ESC>ea</b><ESC>bb
nmap ,he wbi<em><ESC>ea</em><ESC>bb
nmap ,hi wbi<i><ESC>ea</i><ESC>bb
nmap ,hu wbi<u><ESC>ea</i><ESC>bb
nmap ,hs wbi<strong><ESC>ea</strong><ESC>bb
nmap ,ht wbi<tt><ESC>ea</tt><ESC>bb
nmap ,hx wbF<df>f<df>
nmap ,hl a<ul></ul><ESC>bb
nmap ,ho a<li></li><ESC>bb
nmap ,ha wbi<a><ESC>ea</a><ESC>bb

" -----------------------------------------------------------
" 						Functions
" -----------------------------------------------------------

function GitGPushReg()
  " Pull the project basename
  let @h = system('basename `git rev-parse --show-toplevel`')
  " Concat the command (removing trailing chars...)
  let @g = "!ssh-agent bash -c 'ssh-add /Users/dylan/.ssh/dylangschool_id_rsa; git push git@github.com:dylangschool/" . @h[:-2] . ".git'"
endfunction

call GitGPushReg()		" Store push command in @g register.

func GetTime()
        let hr = strftime('%H')
        let pmoram = "AM"
        if hr > 12
                let hr = hr - 12
                let pmoram = "PM"
        endif
        if hr == 0 | let hr = 12 | endif
        return hr . strftime(':%M') . pmoram
endfun

function FT_perl()
  r! /usr/bin/perl -e 'print "\#\!/usr/bin/perl\n\n\n"'
  1d           " delete blank line at top from previous cmd
  3
  set sm       " set brace and bracket matching
endfunction

function FT_python()
  r ~/.vim/skeleton/skel.py
  1d           " delete blank line at top from previous cmd
  9
  set sm       " set brace and bracket matching
endfunction

function FT_sh()
  r! /usr/bin/perl -e 'print "\#\!/bin/bash\n\n\n"'
  1d
  3
  set sm
endfunction

function FT_c()
  r! /usr/bin/perl -e 'print "\#include <stdio.h>\n\nint main()\n{\n\t\n\treturn 0;\n}"'
  1d
  5
endfunction

function FT_test_python()
"  a = echo expand('%:t')
"  r! /usr/bin/bash -c 'if [-f a' 
"  r! /usr/bin/perl
endfunction

function FT_star_syntax ()
  "source ~/.vim/syntax/dylan.vim
endfunction

" -----------------------------------------------------------
" 						Autocommand
" -----------------------------------------------------------

if has("autocmd")
 autocmd VimEnter * NERDTree
 autocmd VimEnter * wincmd p

 augroup common
  " Remove all cprog autocommands
  au!

  " put #!/bin/bash for .sh and #!/usr/bin/perl for .pl :)
  autocmd bufnewfile *.pl call FT_perl()
  autocmd bufnewfile *.py call FT_python()
"  autocmd BufNewFile *.py r ~/.vim/skeleton/skel.py
  autocmd bufnewfile *.sh call FT_sh()
  autocmd bufwritepre,filewritepre *.pl,*.sh !chmod +x %
  autocmd bufnewfile test.c,tmp.c,foo.c,boo.c,t.c call FT_c()
"  autocmd bufnewfile test_*.py call FT_test_py()
 augroup END

  " In text files, always limit the width of text to 78 characters
  autocmd BufRead *.txt set tw=78
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal g'\"" |
  \ endif

 augroup cprog
  au!
  " When starting to edit a file:
  "   For C and C++ files set formatting of comments and set C-indenting on.
  "   For other files switch it off.
  "   Don't change the order, it's important that the line with * comes first.
  autocmd FileType *      set formatoptions=tcql nocindent comments&
  autocmd FileType python set tabstop=4 softtabstop=4 textwidth=79 expandtab shiftwidth=4 autoindent fileformat=unix
  autocmd FileType java  set formatoptions=croql cindent comments=sr:/*,mb:*,el:*/,:// tabstop=4 softtabstop=0 expandtab shiftwidth=4
  autocmd FileType c,cpp  set formatoptions=croql cindent comments=sr:/*,mb:*,el:*/,:// tabstop=4 softtabstop=0 noexpandtab shiftwidth=4
"  autocmd FileType * call FT_star_syntax()
 augroup END

 augroup gzip
  " Remove all gzip autocommands
  au!

  " Enable editing of gzipped files
  "	  read:	set binary mode before reading the file
  "		uncompress text in buffer after reading
  "	 write:	compress file after writing
  "	append:	uncompress file, append, compress file
  autocmd BufReadPre,FileReadPre	*.gz set bin
  autocmd BufReadPost,FileReadPost	*.gz let ch_save = &ch|set ch=2
  autocmd BufReadPost,FileReadPost	*.gz '[,']!gunzip
  autocmd BufReadPost,FileReadPost	*.gz set nobin
  autocmd BufReadPost,FileReadPost	*.gz let &ch = ch_save|unlet ch_save
  autocmd BufReadPost,FileReadPost	*.gz execute ":doautocmd BufReadPost " . expand("%:r")

  autocmd BufWritePost,FileWritePost	*.gz !mv <afile> <afile>:r
  autocmd BufWritePost,FileWritePost	*.gz !gzip <afile>:r

  autocmd FileAppendPre			*.gz !gunzip <afile>
  autocmd FileAppendPre			*.gz !mv <afile>:r <afile>
  autocmd FileAppendPost		*.gz !mv <afile> <afile>:r
  autocmd FileAppendPost		*.gz !gzip <afile>:r
 augroup END
endif
if &term=="xterm"
     set t_Co=8
     set t_Sb=^[4%dm
     set t_Sf=^[3%dm
endif
