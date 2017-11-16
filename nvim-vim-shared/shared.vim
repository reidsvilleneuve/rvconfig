" Keep everything here agnostic of any plugins -- machines that use
" .vimrc-light may not have any running.

" --- Snippits ---

"TODO: Remove the repeated path
nnoremap \,des :-1read ~/rvconfig/nvim-vim-shared/snippits/jasmine-describe.js<CR>f(=a(2f'i
nnoremap \,it :-1read ~/rvconfig/nvim-vim-shared/snippits/jasmine-it.js<CR>f(=a(2f'i
nnoremap \,bfe :-1read ~/rvconfig/nvim-vim-shared/snippits/jasmine-beforeEach.js<CR>f(=a(jS
