" ************ "
"              "
" Key Bindings "
"              "
" ************ "

" --- Hide search highlighting ---

nnoremap <silent> <Space> :noh<CR>

" --- Tabs / two spaces toggle ---

" Old implementation:
" set expandtab tabstop=2 shiftwidth=2 softtabstop=2
" set shiftwidth=2 softtabstop=0 noexpandtab

let g:my_tab=2

execute "set shiftwidth=".g:my_tab
execute "set softtabstop=".g:my_tab
execute "set tabstop=".g:my_tab

set expandtab

function! SetToTabs()
  execute "set shiftwidth=".g:my_tab
  set softtabstop=0
  set noexpandtab
  echo "Set to tabs."
endfunction

function! SetToSpaces()
  execute "set shiftwidth=".g:my_tab
  execute "set tabstop=".g:my_tab
  execute "set softtabstop=".g:my_tab
  set expandtab
  echo "Set to spaces."
endfunction

function! TabToggle()
  if &expandtab
    call SetToTabs()
  else
    call SetToSpaces()
  endif
endfunction

nmap <F9> mz:execute TabToggle()<CR>'z

" --- Easier buffer switching ---

nnoremap \bb :ls<cr>:b<space>

" --- Buffer-only session save / load ---

nnoremap <silent> \s :set sessionoptions=buffers<cr>:mksession!<cr>:echo "Session saved"<cr>
nnoremap <silent> \l :so Session.vim<cr>:echo "Session loaded"<cr>

" --- Stops ex mode ---

nnoremap Q <nop>

" --- Diff unsaved buffer with previously saved version ---

nnoremap <silent> \d :w !diff % -<cr>

" ---  Quick range normal mode execution ---

" Assume norm for visual mode, since range comes for free
vnoremap \Q :norm 
nnoremap \q :'m,.
"
" --- Copy current various common texts to system clipboard ---

nnoremap <silent> \c :let @+=@%<cr>:echo "Current file's relative path copied to system clipboard"<cr>
nnoremap <silent> \C :let @+=expand('%:p')<cr>:echo "Current file's full path copied to system clipboard"<cr>
nnoremap <silent> \n :let @+=expand('%:t')<cr>:echo "Current file's name copied to system clipboard"<cr>
nnoremap <silent> \N :let @+=fugitive#head()<cr>:echo "Current branch's name coped to system clipboard"<cr>

" ---  Quicker window movement ---

" NOTE: iTerm does not handle <C-h> properly in some cases - run this to work
" around if in OSX, using iTerm, and <C-h> is not working:
"
" infocmp $TERM | sed 's/kbs=^[hH]/kbs=\\177/' > $TERM.ti
" tic $TERM.ti

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" --- Open local .todo file ---

nnoremap \t :e .todo<cr>
