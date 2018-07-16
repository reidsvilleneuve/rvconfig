" --- Shared config ---

source ~/rvconfig/nvim-vim-shared/shared.vim

" --- Modules ---

" TODO: Get config path via env var or something similar -- symbolic link
" sourcing is happening from ~/.config/init.vim, so we are hardcoding for now.
let g:RvDev_CurrentConfigType = 'full'

for file in split(glob('~/rvconfig/nvim/nvim-modules/*.vim'), '\n')
  exe 'source' file
endfor
