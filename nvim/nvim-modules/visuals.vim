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

set cul
augroup BgHighlight
  autocmd!
  autocmd WinEnter * call WindowEnterHighlight()
  autocmd WinLeave * call WindowLeaveHighlight() 
augroup END

" TODO: Combine these functions:
function! WindowEnterHighlight()
  set cul
  set colorcolumn=80,121
endfunction

function! WindowLeaveHighlight()
  set nocul
  set colorcolumn=0
endfunction

call WindowEnterHighlight()

" --- Relative line numbers ---

set nu rnu

" --- Quicker macro execution ---

set lazyredraw
