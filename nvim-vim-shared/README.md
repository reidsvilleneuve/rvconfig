This sets up functionality that is the same between the light (vim) and full
(neovim) configs. This includes the local vimrc implementation.

Set ProjectVimrcWhitelist in your system-wide vim config file. It expects an
array of strings representing the absolute paths of whitelisted project
folders.

Here is an example of a typical system vimrc (located at ~/.vimrc for vim and
~/.config/nvim/init.vim for neovim):

```
set nocompatible # If needed

let g:ProjectVimrcWhitelist = [
  \'/Users/someusername/repos/my-project',
  \'/Users/someusername/repos/another-codebase',
\]

source ~/rvconfig/vim/vimrc-light
```

Here is an example of a typical local .vimrc file:

```
if (g:RvDev_CurrentConfigType == 'light')
  echomsg 'Light Project Vimrc loaded.'
  nnoremap \\w :call GitMessageHeader("SOMEPREFIX")<CR>
  nnoremap \\q :call GitMessageBody("SOMEPREFIX")<CR>
else
  echomsg 'Full Project Vimrc loaded.'
  let g:ale_linters = {'html': []}
  let g:ale_fixers = {
    \ 'typescript': [
      \ 'prettier'
    \ ]
  \ }
endif
```
