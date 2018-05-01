" ************* "
"               "
" Misc Settings "
"               "
" ************* "

" --- Menu / Tab completion ---

set wildmode=longest:list,full
set wildmenu

" --- Expand %% to path of current file ---

" This implementation broke. TODO: Figure out why:
"cabbr <expr> %% expand('%:p:h')

cabbr %% <C-R>=expand('%:p:h')<CR>

" --- Spelling setup ---

autocmd BufRead,BufNewFile * setlocal spell spelllang=en_us

" --- Tree style netrw ---

" TODO: Figure out why this is being glitchy.
"let g:netrw_liststyle= 3

" --- Disable mouse ---

autocmd BufEnter * set mouse=

" --- Backspace normalization ---

set backspace=2
