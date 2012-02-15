" Use Vim settings, rather then Vi settings (much better!).
set nocompatible

" Set background type"
set background=dark

"color scheme"
" colorscheme elflord
colorscheme delek
" colorscheme desert 

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Enable mouse "
set mouse=a 

" showmatch: Show the matching bracket for the last ')'?
set showmatch

" highlight strings inside C comments
let c_comment_strings=1

"color syntax"
syn on
set encoding=UTF-8

"status line"
set statusline=%(%F%m%r%h%w\ [%Y]\ %{&encoding}\ %)%=%(%l,%v\ %LL\ %p%%%)
set laststatus=2

"tab config"
set ts=4
setlocal expandtab
setlocal softtabstop=4

" 4 spaces for indenting
set shiftwidth=4

"Disable autoindentation"
set noai

" Enable filetype plugins "
filetype plugin on

" Disable preview code when using omni complete"
set completeopt=menu

"----------- Pylint config ------------"

" Use pylint as python compiler "
autocmd FileType python compiler pylint

" Prevent pylint to be executed no save "
let g:pylint_onwrite = 0
let g:pylint_cwindow = 0

" If quickfix is open just close it if not run pylint and display results "
function! RunPylintOrHideQuickFix()
    if &bt == 'quickfix'
        cclose 
    else
        cclose 
        call Pylint(0)
    endif
"    redraw! " Force redraw everything to don't get a black (or blank) screen
endfunction

"------------ Mappings --------------"

"+ and - to resize splited windows"
map - <C-W>-
map = <C-W>+

" Make tab in v mode work like I think it should (keep highlighting):
vmap <tab> >gv
vmap <s-tab> <gv

" Pylint "
map <silent> <F4> :cp<CR>
map <silent> <F5> :cn<CR>
map <silent> <F6> :call RunPylintOrHideQuickFix()<CR>