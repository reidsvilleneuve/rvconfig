" Keep everything here agnostic of any plugins -- machines that use
" .vimrc-light may not have any running.

" --- Color ---

set t_Co=256

" --- Keybinds ---

" Quick yanks and pastes to/from system clipboard
nnoremap Y "+y
nnoremap YY ^"+y$
vnoremap Y "+y
nnoremap \P "+P
nnoremap \p "+p
vnoremap \p "+p

" Quicker window movement
" NOTE: iTerm does not handle <C-h> properly -  run this to work around if in OSX and using iTerm:
" infocmp $TERM | sed 's/kbs=^[hH]/kbs=\\177/' > $TERM.ti
" tic $TERM.ti
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

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

" --- Project vimrc ---

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

autocmd VimEnter * call LoadProjectVimrc()

" --- Status line ---
"
set statusline=%F\ %=%l\:%c " File --> line:column
set laststatus=2 " Always show status line
