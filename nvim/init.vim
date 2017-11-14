" TODO: Get config path via env var or something similar -- symbolic link
" sourcing is happening from ~/.config/init.vim, so we are hardcoding for now.

for f in split(glob('~/rvconfig/nvim/nvim-modules/*.vim'), '\n')
  exe 'source' f
endfor

" --- Shared config ---
source ~/rvconfig/nvim-vim-shared/shared.vim
