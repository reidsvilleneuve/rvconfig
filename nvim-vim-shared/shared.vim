" Keep everything here agnostic of any plugins -- machines that use
" .vimrc-light may not have any running.

" --- Keybinds ---

"Quick yanks to system clipboard
nnoremap Y "+y
nnoremap YY ^"+y$
vnoremap Y "+y

" --- Quicker window movement ---
" NOTE: iTerm does not handle <C-h> properly -  run this to work around if in OSX and using iTerm:
" infocmp $TERM | sed 's/kbs=^[hH]/kbs=\\177/' > $TERM.ti
" tic $TERM.ti
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" --- Snippits ---

" TODO: Remove repeated text

" Jasmine
nnoremap \,des :-1read ~/rvconfig/nvim-vim-shared/snippits/jasmine-describe.js<CR>f(=a(2f'i
nnoremap \,it :-1read ~/rvconfig/nvim-vim-shared/snippits/jasmine-it.js<CR>f(=a(2f'i
nnoremap \,bfe :-1read ~/rvconfig/nvim-vim-shared/snippits/jasmine-beforeEach.js<CR>f(=a(o

" JavaScript
nnoremap \,fun :-1read ~/rvconfig/nvim-vim-shared/snippits/js-function.js<CR>f{=a{t(i

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
