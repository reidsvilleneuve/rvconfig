" Keep everything here agnostic of any plugins -- machines that use
" .vimrc-light may not have any running.

" --- System-specific config ---
" TODO: Check for file first to stop error messages if file is non-existent.
source ~/.system-vimrc

" --- Keybinds ---

"Quick yanks to system clipboard
nnoremap Y "+y
nnoremap YY ^"+y$
vnoremap Y "+y

" --- Snippits ---

"TODO: Remove repeated text
nnoremap \,des :-1read ~/rvconfig/nvim-vim-shared/snippits/jasmine-describe.js<CR>f(=a(2f'i
nnoremap \,it :-1read ~/rvconfig/nvim-vim-shared/snippits/jasmine-it.js<CR>f(=a(2f'i
nnoremap \,bfe :-1read ~/rvconfig/nvim-vim-shared/snippits/jasmine-beforeEach.js<CR>f(=a(o

" JavaScript
nnoremap \,fun :-1read ~/rvconfig/nvim-vim-shared/snippits/js-function.js<CR>f{=a{t(i

" --- Project vimrc ---

function! LoadProjectVimrc()
  let localVimrcPath = $PWD."/rvdev/vimrc"

  " Set ProjectVimWhitelist in .system-vimrc. It expects an array of strings
  " representing the absolute paths of whitelisted project folders.
  if exists('g:ProjectVimWhitelist')
        \&& !empty(glob(localVimrcPath))
        \&& index(g:ProjectVimWhitelist, $PWD) >= 0
    execute 'source '.localVimrcPath
    echomsg 'Project Vimrc loaded.'
  endif
endfunction

autocmd VimEnter * call LoadProjectVimrc()
