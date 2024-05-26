" Removes all colour from vim
syntax off
set nohlsearch
set t_Co=0
" End of Removing colour

" Dictionary: take mode() input -> longer notation of current mode
" mode() is defined by Vim
let g:currentmode={ 'n' : 'Normal', 'no' : 'N·Operator Pending', 'v' : 'Visual', 'V' : 'V·Line', '^V' : 'V·Block', 's' : 'Select', 'S': 'S·Line', '^S' : 'S·Block', 'i' : 'Insert', 'R' : 'Replace', 'Rv' : 'V·Replace', 'c' : 'Command', 'cv' : 'Vim Ex', 'ce' : 'Ex', 'r' : 'Prompt', 'rm' : 'More', 'r?' : 'Confirm', '!' : 'Shell', 't' : 'Terminal'}

" Function: return current mode
" abort -> function will abort soon as error detectd
function! ModeCurrent() abort
    let l:modecurrent = mode()
    " use get() -> fails safely,since ^V doesn't seem to register
    " 3rd arg is used wh return of mode() == 0, which is case with ^V
    " thus, ^V fails -> returns 0 -> replaced with 'V Block'
    let l:modelist = toupper(get(g:currentmode, l:modecurrent, 'V·Block '))
    let l:current_status_mode = l:modelist
    return l:current_status_mode
endfunction

hi StatusLine term=reverse

" Makes status bar visible
set laststatus=2
set statusline+=--
set statusline+=%m	" Adds unsaved symbol
set statusline+=\ %*	" Adds whitespace
set statusline+=Vim\
set statusline+=%{ModeCurrent()}:
set statusline+=\ %f	" Adds filename/path
set statusline+=\ (%{&fileencoding?&fileencoding:&encoding}) " Adds file encoding
set statusline+=\ %*
set fillchars=stl:-	" Fills status line with  ' - '
" change to the right side
set statusline+=%=
set statusline+=\ %P	" Adds percentage
set statusline+=\ --
set statusline+=\ %l:%c
set statusline+=\ --
set fillchars=stl:-
set fillchars+=stlnc:-  " also fill inactive buffers

set autoindent
