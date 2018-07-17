" Keep everything here agnostic of any plugins -- machines that use
" .vimrc-light may not have any running.

" --- Keybinds ---

" Tabs / two spaces toggle
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

nnoremap <F9> mz:execute TabToggle()<CR>'z

" Quick yanks and pastes to/from system clipboard
nnoremap Y "+y
nnoremap YY ^"+y$
vnoremap Y "+y
nnoremap \P "+P
nnoremap \p "+p
vnoremap \p "+p

" Quick edit current expanded directory
nnoremap \e :e <C-R>=expand('%:p:h')<CR>/

" Easier buffer switching
nnoremap \bb :ls<cr>:b<space>

" Bufferonly session save / load
nnoremap <silent> \s :set sessionoptions=buffers<cr>:mksession!<cr>:echo "Session saved"<cr>
nnoremap <silent> \l :so Session.vim<cr>:echo "Session loaded"<cr>

" Stops ex mode
nnoremap Q <nop>

" Diff unsaved buffer with previously saved version
nnoremap <silent> \d :w !diff % -<cr>

" Quick range normal mode execution
" Assume norm for visual mode, since range comes for free
vnoremap \Q :norm
nnoremap \q :'m,.

" Copy current various common texts to system clipboard
nnoremap <silent> \c :let @+=@%<cr>:echo "Current file's relative path copied to system clipboard"<cr>
nnoremap <silent> \C :let @+=expand('%:p')<cr>:echo "Current file's full path copied to system clipboard"<cr>
nnoremap <silent> \n :let @+=expand('%:t')<cr>:echo "Current file's name copied to system clipboard"<cr>

" Quicker window movement
" NOTE: iTerm does not handle <C-h> properly in some cases - run this to work
" around if in OSX, using iTerm, and <C-h> is not working:
"   $ infocmp $TERM | sed 's/kbs=^[hH]/kbs=\\177/' > $TERM.ti
"   $ tic $TERM.ti
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Hide search highlighting
nnoremap <silent> <Space> :noh<CR>

" Number Line Toggle
nnoremap <silent> <C-n> :set number relativenumber!<cr>
set number relativenumber

" --- Snippits ---

function! SetSnippit(mapping, file, action)
  execute "nnoremap \,".a:mapping." :-1read ~/rvconfig/nvim-vim-shared/snippits/".a:file."<CR>".a:action
endfunction

" Jasmine
call SetSnippit("des", "jasmine-describe.js", "f(=%2f'i")
call SetSnippit("it", "jasmine-it.js", "f(=%2f'i")
call SetSnippit("bfe", "jasmine-before-each.js", "f(=%o")

" JavaScript
call SetSnippit("fun", "js-function.js", "f{=a{t(i")

" --- Automatic commands ---

function! LoadProjectVimrc()
  let projectVimrcPath = $PWD."/.rvdev/vimrc"

  " Set ProjectVimrcWhitelist in your system-wide vim config file. It expects
  " an array of strings representing the absolute paths of whitelisted project
  " folders.  e.g.:
  "
  " let g:ProjectVimrcWhitelist = [
  "   \'/Users/someusername/repos/my-project',
  "   \'/Users/someusername/repos/another-codebase',
  " \]

  if exists('g:ProjectVimrcWhitelist') && !empty(glob(projectVimrcPath))
    if index(g:ProjectVimrcWhitelist, $PWD) >= 0
      execute 'source '.projectVimrcPath
      echomsg 'Project Vimrc loaded.'
    else
      echomsg 'Warning: Non-whitelisted project vimrc found in this directory.'
    endif
  endif
endfunction

" TODO: Combine these functions:
function! WindowEnterHighlight()
  set cursorline
  set colorcolumn=80,120
endfunction

function! WindowLeaveHighlight()
  set nocursorline
  set colorcolumn=0
endfunction

augroup AutoActions
  autocmd!
  autocmd BufRead,BufNewFile * setlocal spell spelllang=en_us
  autocmd BufEnter,BufNewFile,BufRead * set mouse=
  autocmd InsertEnter,InsertLeave * set cul!
  autocmd VimEnter * call LoadProjectVimrc()
  autocmd WinEnter * call WindowEnterHighlight()
  autocmd WinLeave * call WindowLeaveHighlight()
augroup END

" --- Visuals ---

set statusline=%F\ %=%l\:%c " File --> line:column
set laststatus=2 " Always show status line

" Show whitespace
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set list

" Highlights the line that the cursor is on in current window
call WindowEnterHighlight() " Defined above

" Color
set t_Co=256

" --- Misc ---

filetype plugin indent on
syntax enable

" Lets backspace act like it does in modern OS environments.
set backspace=2

" Menu / Tab completion
set wildmode=longest:list,full
set wildmenu

" Expand %% to path of current file
cabbrev %% <C-R>=expand('%:p:h')<CR>

set hlsearch " Highlight search terms
set incsearch " Search while typing in search query

" Quicker macro execution
set lazyredraw

" Indent on newline
set autoindent
