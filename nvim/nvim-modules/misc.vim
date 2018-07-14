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
"cabbrev <expr> %% expand('%:p:h')

cabbrev %% <C-R>=expand('%:p:h')<CR>

" --- Tree style netrw ---

" TODO: Figure out why this is being glitchy.
"let g:netrw_liststyle= 3
"
" --- Backspace normalization ---

set backspace=2

" --- Automatic commands ---
"
augroup BufFileActions
  autocmd!

  " Spelling setup
  autocmd BufRead,BufNewFile * setlocal spell spelllang=en_us

  " Disable mouse
  autocmd BufEnter,BufNewFile,BufRead * set mouse=
augroup END
