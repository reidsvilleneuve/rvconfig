" Keep everything here agnostic of any plugins -- machines that use
" .vimrc-light may not have any running.

" --- Non-keybinded functions ---

" Quick git messages

" The following three functions can be quickly implemented in project vimrc
" files via: nnoremap \\w :call GitMessageBody("SOMEPREFIX")<CR>
function! InsertStoryText(storyPrefix)
  " Copy first instance of git branch name containing story text to top
  execute '1 | /'.a:storyPrefix.'-\d/copy 0'
  " Remove non-story number text
  execute 'normal dn$N2f-D'
endfunction

function! GitMessageHeader(storyPrefix)
  execute InsertStoryText(a:storyPrefix)
  " Parse story text line
  execute 's/-'.a:storyPrefix.'/, '.a:storyPrefix.'/ge'
  " Insert mode with : and space at end of line
  execute 'normal A: ' | startinsert!
endfunction

function! GitMessageBody(storyPrefix)
  execute InsertStoryText(a:storyPrefix)
  " Parse story text line
  execute 's/-'.a:storyPrefix.'/\r'.a:storyPrefix.'/ge'
  " Insert header and add new lines at top of the file
  execute "normal ggOJIRA Stories:\<CR>\<Esc>gg2O\<Esc>gg" | startinsert!
endfunction

" --- Keybinds ---

" Tabs / two spaces toggle
let g:rvdev_tab_stops=2

execute "set shiftwidth=".g:rvdev_tab_stops
execute "set softtabstop=".g:rvdev_tab_stops
execute "set tabstop=".g:rvdev_tab_stops
set expandtab

function! SetToTabs()
  execute "set shiftwidth=".g:rvdev_tab_stops
  set softtabstop=0
  set noexpandtab
  echo "Set to tabs."
endfunction

function! SetToSpaces()
  execute "set shiftwidth=".g:rvdev_tab_stops
  execute "set tabstop=".g:rvdev_tab_stops
  execute "set softtabstop=".g:rvdev_tab_stops
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

" Quick edit file path in system clipboard
nnoremap \E :e <C-R>=expand(@+)<CR><CR>

" Easier buffer switching
nnoremap \bb :ls<CR>:b<space>

" Bufferonly session save / load
nnoremap <silent> \s :set sessionoptions=buffers<CR>:mksession!<CR>:echo "Session saved"<CR>
nnoremap <silent> \l :so Session.vim<CR>:echo "Session loaded"<CR>

" Stops ex mode
nnoremap Q <nop>

" Diff unsaved buffer with previously saved version
nnoremap <silent> \d :w !diff % -<CR>

" Quick range normal mode execution
" Assume norm for visual mode, since range comes for free
vnoremap \q :norm
nnoremap \q :'m,.

" Copy current various common texts to system clipboard
nnoremap <silent> \c :let @+=@%<CR>:echo "Current file's relative path copied to system clipboard"<CR>
nnoremap <silent> \C :let @+=expand('%:p')<CR>:echo "Current file's full path copied to system clipboard"<CR>
nnoremap <silent> \n :let @+=expand('%:t')<CR>:echo "Current file's name copied to system clipboard"<CR>

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
nnoremap <silent> <C-n> :set number relativenumber!<CR>
set number relativenumber

" Open VSCode on current file
nnoremap \X :!code -g <C-r>=expand('%:p')<CR>:<C-r>=line('.')<CR>:<C-r>=col('.')<CR><CR>

" Newline-ify a ', '-separated list
nnoremap \,, :s/, /,\r/g<CR>='.:noh<CR>

" --- Snippits ---

function! SetSnippit(mapping, file, action)
  execute "nnoremap \\,".a:mapping." :-1read ~/rvconfig/nvim-vim-shared/snippits/".a:file."<CR>".a:action
endfunction

" Jasmine
call SetSnippit("des", "jasmine-describe.js", "f(=%2f'i")
call SetSnippit("it", "jasmine-it.js", "f(=%2f'i")
call SetSnippit("bfe", "jasmine-before-each.js", "f(=%o")
call SetSnippit("ldes", "jasmine-describe-lambda.js", "f(=%f'a")
call SetSnippit("lit", "jasmine-it-lambda.js", "f(=%2f'i")
call SetSnippit("lbfe", "jasmine-before-each-lambda.js", "f(=%f(o")

" JavaScript
call SetSnippit("fun", "js-function.js", "f{=a{t(i")

" --- Automatic commands ---

function! LoadProjectVimrc()
  let projectVimrcPath = $PWD."/.rvdev/vimrc"

  " See this directory's README.md file for setup instructions

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
  autocmd InsertEnter,InsertLeave * set cul! " Remove line in insert mode
  autocmd VimEnter * call LoadProjectVimrc()
  autocmd WinEnter * call WindowEnterHighlight()
  autocmd WinLeave * call WindowLeaveHighlight()
  autocmd FileType netrw setl bufhidden=delete "Stops netrw uncloseable bug
augroup END

" --- Visuals ---

syntax on

set statusline=%F\ %=%l\:%c " File --> line:column
set laststatus=2 " Always show status line

" Show whitespace
set listchars=eol:↵,tab:>-,trail:~,extends:>,precedes:<
set list

" Highlights the line that the cursor is on in current window
call WindowEnterHighlight() " Defined above

" Color
set t_Co=256

" --- Misc ---

filetype plugin indent on

" Lets backspace act like it does in modern OS environments.
set backspace=2

" Menu / Tab completion
set wildmode=longest:list,full
set wildmenu

" Expand %% to path of current file in command mode
cabbrev %% <C-R>=expand('%:p:h')<CR>

" Highlight search terms
set hlsearch
"
" Search while typing in search query
set incsearch

" Quicker macro execution
set lazyredraw

" Indent on newline
set autoindent

" Cursor style
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
