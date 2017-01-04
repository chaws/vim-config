" *************************** Initialization **************

" ***** Manage sessions, so I don't have to open everything over and over
function! MakeSession()
    let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
    if (filewritable(b:sessiondir) != 2)
        exe 'silent !mkdir -p ' b:sessiondir
		redraw!
	endif
	let b:filename = b:sessiondir . '/session.vim'
	exe "mksession! " . b:filename
endfunction

function! LoadSession()
    let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
	let b:sessionfile = b:sessiondir . "/session.vim"
	if (filereadable(b:sessionfile))
	    exe 'source ' b:sessionfile
	else
	    echo "No session loaded."
	endif
endfunction
au VimEnter * :call LoadSession()
au VimLeave * :call MakeSession()

" ***** How can I open NERDTree automatically when vim starts up on opening a directory?
" Make NERDTree to fold/unfold with one click of a mouse:
" https://github.com/scrooloose/nerdtree/issues/531#issuecomment-174218498 
let NERDTreeMouseMode=2
" https://medium.com/@victormours/a-better-nerdtree-setup-3d3921abc0b9#.ibrmx5asj
"let NERDTreeQuitOnOpen=1
" https://github.com/scrooloose/nerdtree/issues/323
let g:NERDTreeMapOpenInTab='<2-LeftMouse>'

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd VimLeave * NERDTreeClose

" *************************** end of Initialization *******

" *************************** Basic Settings **************
" ****** Format
" Set wrap (it breaks the text [visual only] if the line is too big)
set wrap

" Highlight the current line
set cursorline

" Encoding
set encoding=UTF-8

"tab config"
set ts=4
setlocal expandtab
setlocal softtabstop=4
set shiftwidth=4

" showmatch: Show the matching bracket for the last ')'?
set showmatch

" ***** Color
" Syntax files
syntax on

" Highlight searches
set hlsearch

" ***** Other stuff
" Set line numbers and make them grey
set nu
highlight LineNr term=bold cterm=NONE ctermfg=Grey ctermbg=NONE gui=NONE guifg=Grey guibg=NONE

" Color scheme
colorscheme desert 

" Disable mouse "
set mouse=a

" Indent stuff
filetype plugin indent on
" *************************** end of Basic Settings ********

" ************************* Key Mappings *******************
" ***** Go straight to the vim command line (avoid ESC+:)
nnoremap <C-x> :
inoremap <C-x> <ESC>:
vnoremap <C-x> <ESC>:

" ***** Ctrl+S: Save
" reference: http://vim.wikia.com/wiki/Map_Ctrl-S_to_save_current_or_new_files 
" Add Ctrl-S to save in VIM. Note that some stuff was added in .bashrc
" If the current buffer has never been saved, it will have no name,
" call the file browser to save it, otherwise just save it.
command! -nargs=0 -bar Update if &modified 
                           \|    if empty(bufname('%'))
                           \|        browse confirm write
                           \|    else
                           \|        confirm write
                           \|    endif
                           \| endif
" Normal mode
nnoremap <silent> <C-s> :<C-u>Update<CR>
" Insert mode
inoremap <C-s> <C-o>:Update<CR>
" Visual mode
vmap <C-s> <esc>:w<CR>gv

" ***** Move lines up and down
" Normal mode
nnoremap <C-Up> :m .-2<CR>==
nnoremap <C-Down> :m .+1<CR>==

" Insert mode
inoremap <C-Down> <ESC>:m .+1<CR>==gi
inoremap <C-Up> <ESC>:m .-2<CR>==gi

" Visual mode
vnoremap <C-Down> :m '>+1<CR>gv=gv
vnoremap <C-Up> :m '<-2<CR>gv=gv

" ***** Switch mode by typing Ctrl
" From insert to visual
inoremap <C-v> <ESC>v
" From visual to insert
vnoremap <C-i> <ESC>i
" From normal mode to insert
nnoremap <C-i> i
nnoremap <C-h> gT

" ***** Move thru tabs
nnoremap <C-l> gt
inoremap <C-l> <ESC>gt
inoremap <C-h> <ESC>gT
vnoremap <C-l> gt
vnoremap <C-h> gT

" ***** Open tab
nnoremap <C-t> :tabe<CR> i
inoremap <C-t> <ESC>:tabe<CR> i
vnoremap <C-t> <ESC><ESC>:tabe<CR> i

" ****** Close tab
nnoremap <C-w> :q!<CR>
inoremap <C-w> <ESC>:q!<CR>
vnoremap <C-w> :q!<CR>

" ***** Find & Replace
nnoremap <C-f> /
inoremap <C-f> <ESC> /
vnoremap <C-f> /

" ***** Quit vim
nnoremap <C-e> :qa!<CR>
inoremap <C-e> <ESC>:qa!<CR>
vnoremap <C-e> :qa!<CR>

" ************************* end of Key Mappings ************

" ************************* Plugins ************************
" Run pathogen, to manage runtimepath for vim
execute pathogen#infect()
" ************************* end of Plugins *****************
