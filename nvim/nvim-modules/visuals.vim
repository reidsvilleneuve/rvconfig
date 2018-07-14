" *************** "
"                 "
" Visual Settings "
"                 "
" *************** "

" --- Whitespace chars ---

set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set list

" --- Search ---

set hlsearch " Highlight search terms
set incsearch " Search while typing in search query

" ---  Set visuals of active window ---

set cursorline
augroup BgHighlight
  autocmd!
  autocmd WinEnter * call WindowEnterHighlight()
  autocmd WinLeave * call WindowLeaveHighlight() 
augroup END

" TODO: Combine these functions:
function! WindowEnterHighlight()
  set cursorline
  set colorcolumn=80,120
endfunction

function! WindowLeaveHighlight()
  set nocursorline
  set colorcolumn=0
endfunction

call WindowEnterHighlight()

" --- Relative line numbers ---

set number relativenumber

" --- Quicker macro execution ---

set lazyredraw
