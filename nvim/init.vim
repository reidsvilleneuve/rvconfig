let g:RvDev_CurrentConfigType = 'full'
source ~/rvconfig/nvim-vim-shared/shared.vim

" ********** "
"            "
" Misc Setup "
"            "
" ********** "

set inccommand=split " Preview replacements in a split

" ************ "
"              "
" Plugin Setup "
"              "
" ************ "

" --- Dein ---

" For first run, see https://github.com/Shougo/dein.vim
" This setup requires the install script there to point to ~/.nvimpkg

set runtimepath+=~/.nvimpkg/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.nvimpkg')
  call dein#begin('~/.nvimpkg')

  " Dein plugin

  call dein#add('~/.nvimpkg/repos/github.com/Shougo/dein.vim')

  " Plugins to add

  call dein#add('ConradIrwin/vim-bracketed-paste.git') " Allows for OS pasting without :set paste
  call dein#add('honza/vim-snippets.git') " Snippets (Engine below)
  call dein#add('mattn/emmet-vim.git') " Emmet integration
  call dein#add('mhartington/nvim-typescript', {'build': './install.sh'})
  call dein#add('michaeljsmith/vim-indent-object.git') " Indentation text objects
  call dein#add('NLKNguyen/papercolor-theme.git') " Colors
  call dein#add('rbgrouleff/bclose.vim.git') " Close buffer without closing window - :Bclose
  call dein#add('sheerun/vim-polyglot.git') " Multi-language syntax highlighting
  call dein#add('Shougo/context_filetype.vim.git') " Deoplete utility
  call dein#add('Shougo/denite.nvim') " Fuzzy finding
  call dein#add('Shougo/deoplete.nvim') " Autocomplete
  call dein#add('Shougo/neoinclude.vim.git') " Deoplete utility
  call dein#add('Shougo/neosnippet.vim.git') " Snippet engine
  call dein#add('tpope/vim-commentary.git') " gc* to comment out lines
  call dein#add('tpope/vim-fugitive.git') " Git integration
  call dein#add('tpope/vim-repeat.git') " Better '.' functionality
  call dein#add('tpope/vim-surround.git') " Text object surrounding
  call dein#add('w0rp/ale.git') " Multi-language linting
  call dein#add('Yggdroot/indentLine.git') " Indentation guide lines

  call dein#end()
  call dein#save_state()
endif

" Install on run
if dein#check_install()
  call dein#install()
endif

" --- Denite ---

" File_rec/git
call denite#custom#alias('source', 'file_rec/git', 'file_rec')
call denite#custom#var('file_rec/git', 'command',
\ ['git', 'ls-files', '-co', '--exclude-standard'])
nnoremap <silent> <C-p> :<C-u>Denite
\ `finddir('.git', ';') != '' ? 'file_rec/git' : 'file_rec'`<CR>

"Ag command for grep source
call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'default_opts',
  \ ['-i', '--vimgrep'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])
call denite#custom#source('grep', 'converters', ['converter_abbr_word'])
call denite#custom#source(
\ 'grep', 'matchers', ['matcher_regexp'])

"Key mappings
call denite#custom#map(
  \ 'insert',
  \ '<C-j>',
  \ '<denite:move_to_next_line>',
  \ 'noremap'
  \)
call denite#custom#map(
  \ 'insert',
  \ '<C-k>',
  \ '<denite:move_to_previous_line>',
  \ 'noremap'
  \)

" Recursive search
nnoremap \f :Denite grep:. -buffer-name=search-buffer<CR>

" Interactive recursive search with quickfix
" https://gist.github.com/dlants/8d7fadfb691b511f1376ba437a9aaea9
" Tag with <C-o> + */Space, and use with :cdo for project-wide actions
map \F :DeniteProjectDir -buffer-name=grep -default-action=quickfix grep:::!<CR>

" --- Emmet ---

let g:user_emmet_install_global = 0 "Enable only for HTML/CSS #1

augroup FileTypeActions
  autocmd!
  autocmd FileType html,css,less,html.twig EmmetInstall "Enable only for HTML/CSS/Twig #2
augroup END

" --- Deoplete ---

let g:deoplete#enable_at_startup = 1

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ deoplete#mappings#manual_complete()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" --- PaperColor Theme ---

set background=dark
colorscheme PaperColor

" --- Fugitive ---

nnoremap <silent> \N :let @+=fugitive#head()<cr>:echo "Current branch's name coped to system clipboard"<cr>

" --- Polyglot ---

" Allows us to see actual markdown text
let g:vim_markdown_conceal = 0

" --- Neosnippits ---

let g:neosnippet#disable_runtime_snippets={ '_' : 1 }
let g:neosnippet#enable_snipmate_compatibility=1
let g:neosnippet#snippets_directory=$HOME.'/.nvimpkg/repos/github.com/honza/vim-snippets/snippets'

imap <C-j> <Plug>(neosnippet_expand_or_jump)
smap <C-j> <Plug>(neosnippet_expand_or_jump)
xmap <C-j> <Plug>(neosnippet_expand_target)

if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" --- TypeScript ---

set completeopt-=preview

" --- ALE ---

nnoremap \af :ALEFix<cr>
let g:ale_lint_delay = 1000
set statusline+=\ E\:%{ale#statusline#Count(bufnr('')).total}
