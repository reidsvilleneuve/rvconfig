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

" TODO: Move newline-separated and single-line formats to separate functions
" " (This refers to the 2nd `execute` invocations in the following functions):

function! GitMessageHeader(storyPrefix)
  execute InsertStoryText(a:storyPrefix)
  " Parse story text line
" TODO: Move this single-line formatting to separate function:
  execute 's/-'.a:storyPrefix.'/, '.a:storyPrefix.'/ge'
  " Insert mode with : and space at end of line
  execute 'normal A: ' | startinsert!
endfunction

function! GitMessageBody(storyPrefix)
  execute InsertStoryText(a:storyPrefix)
  " Parse story text line
" TODO: Move this this single-line formatting to separate function:
  execute 's/-'.a:storyPrefix.'/, '.a:storyPrefix.'/ge'
  " Insert header and add new lines at top of the file
  execute "normal ggIJIRA Story: \<Esc>gg2O\<Esc>gg" | startinsert!
endfunction

function! GitMessageBodyMultipleStories(storyPrefix)
  execute InsertStoryText(a:storyPrefix)
  " Parse story text line
" TODO: Move this multi-line formatting to separate function:
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

" Buffer-only session save / load
nnoremap <silent> \s :set sessionoptions=buffers<CR>:mksession!<CR>:echo "Session saved"<CR>
nnoremap <silent> \l :so Session.vim<CR>:echo "Session loaded"<CR>

" Replaces ex mode with quick macro execution from the q register, which
" complements the ease of recording to that register via qq
nnoremap Q @q
nnoremap \Q :'m,.norm@q<CR>
nnoremap \\Q :g//norm @q<CR>
vnoremap Q :'<,'>norm@q<CR>

" Diff unsaved buffer with previously saved version
nnoremap <silent> \d :w !diff % -<CR>

" Quick range normal mode execution
" Assume norm for visual mode, since range comes for free
vnoremap \q :norm
nnoremap \q :'m,.

" Copy current various common texts to system clipboard
nnoremap <silent> \cp :let @+=@%<CR>:echo "Current file's relative path copied to system clipboard"<CR>
nnoremap <silent> \cP :let @+=expand('%:p')<CR>:echo "Current file's full path copied to system clipboard"<CR>
nnoremap <silent> \cl :let @+=@%.' line '.line('.')<CR>:echo "Current file's relative path and line number copied to system clipboard"<CR>
nnoremap <silent> \cr :let @+=expand('%:t').':'.line('.')<CR>:echo "Current file's name and line number copied to system clipboard for Chrome devtools"<CR>
nnoremap <silent> \cL :let @+=expand('%:p').' line '.line('.')<CR>:echo "Current file's full path and line number copied to system clipboard"<CR>
nnoremap <silent> \cn :let @+=expand('%:t')<CR>:echo "Current file's name copied to system clipboard"<CR>
nnoremap <silent> \ci :let @+='setBreakpoint("'.expand('%:p').'", '.line('.').')'<CR>:echo "Current full path and line number copied to system clipboard for node inspect"<CR>

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
nnoremap <silent> g<Space> :noh<CR>

" Number Line Toggle
nnoremap <silent> <C-n> :set number relativenumber!<CR>
set number relativenumber

" Open VSCode on current file
nnoremap \X :!code -g <C-r>=expand('%:p')<CR>:<C-r>=line('.')<CR>:<C-r>=col('.')<CR><CR>

" Newline-ify a ', '-separated list
nnoremap \,, :s/, /,\r/g<CR>='.:noh<CR>

" Disable Page Up / Down
nnoremap <PageUp> <nop>
nnoremap <PageDown> <nop>

" Write as superuser in case `sudo` is forgotten
cnoremap w!! w !sudo tee > /dev/null %

" Generate ctags
nnoremap \\t :!ctags -R .<CR>

" Insert / command mode movement options for small motions
" Use normal mode / ctrl + o / command-line-window (ctrl + f) otherwise.
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
cnoremap <C-h> <Left>
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
cnoremap <C-l> <Right>

" --- Snippets ---

function! SetSnippet(mapping, file, action)
  " We use !cat to prevent snippet file loading due to previous-file jumps (<C-^>):
  execute "nnoremap \\,".a:mapping." :-1read !cat ~/rvconfig/nvim-vim-shared/snippets/".a:file."<CR>".a:action
endfunction

" Jasmine
call SetSnippet("des", "jasmine-describe.js", "f(=%2f'i")
call SetSnippet("it", "jasmine-it.js", "f(=%2f'i")
call SetSnippet("bfe", "jasmine-before-each.js", "f(=%o")
call SetSnippet("ldes", "jasmine-describe-lambda.js", "f(=%f'a")
call SetSnippet("lit", "jasmine-it-lambda.js", "f(=%2f'i")
call SetSnippet("lbfe", "jasmine-before-each-lambda.js", "f(=%f(o")

" JavaScript
call SetSnippet("fun", "js-function.js", "f{=a{t(i")
call SetSnippet("cl", "js-console-log.js", "=kjf:la")
call SetSnippet("td", "js-todo-rvdev-comment.js", "==A")

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

" Search while typing in search query
set incsearch

" Quicker macro execution
set lazyredraw

" Indent on newline
set autoindent

" Cursor style
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50

" Conceal unless cursor is on same line
if has('conceal')
  set conceallevel=2 concealcursor=""
endif

" Improved diff view
if has('nvim-0.3.2') || has("patch-8.1.0360")
  set diffopt=filler,internal,algorithm:histogram,indent-heuristic
endif

" Use Syntax files for folding
set foldmethod=syntax
" Open files unfolded
set foldlevelstart=20
