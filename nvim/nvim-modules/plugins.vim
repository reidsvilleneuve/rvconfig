" ************ "
"              "
" Plugin Setup "
"              "
" ************ "

" --- Dein ---

" For first run, see https://github.com/Shougo/dein.vim
" This setup requires the install script there to point to ~/.nvimpkg

" Required for Dein
if &compatible
  set nocompatible
endif

set runtimepath+=~/.nvimpkg/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.nvimpkg')
  call dein#begin('~/.nvimpkg')

  " Dein plugin

  call dein#add('~/.nvimpkg/repos/github.com/Shougo/dein.vim')

  " Plugins to add

  call dein#add('blueshirts/darcula.git') " Color scheme
  call dein#add('carlitux/deoplete-ternjs.git') " Deoplete utility
  call dein#add('ConradIrwin/vim-bracketed-paste.git') " Allows for OS pasting without :set paste
  call dein#add('derekwyatt/vim-scala.git') " Scala utility
  call dein#add('editorconfig/editorconfig-vim.git') " .editorconfig support
  call dein#add('HerringtonDarkholme/yats.vim.git') " Typescript highlighting
  call dein#add('jeffkreeftmeijer/vim-numbertoggle.git') " Relative <--> Abs line numbers
  call dein#add('mattn/emmet-vim.git') " Emmet integration
  call dein#add('mhartington/nvim-typescript') " Typescript improvements
  call dein#add('neomake/neomake.git') " Lint, etc.
  call dein#add('pangloss/vim-javascript.git') " Javascript indent / highlighting
  call dein#add('rbgrouleff/bclose.vim.git') " Close buffer without closing window - :Bclose
  call dein#add('Shougo/context_filetype.vim.git') " Deoplete utility
  call dein#add('Shougo/denite.nvim') " Fuzzy finding
  call dein#add('Shougo/deoplete.nvim') " Autocomplete
  call dein#add('Shougo/neoinclude.vim.git') " Deoplete utility
  call dein#add('ternjs/tern_for_vim.git') " JS improvements
  call dein#add('tomlion/vim-solidity.git') " Solidity language syntax
  call dein#add('tpope/vim-fugitive.git') " Git integration
  call dein#add('tpope/vim-repeat.git') " Better '.' functionality
  call dein#add('tpope/vim-surround.git') " Text object surrounding
  call dein#add('vim-airline/vim-airline-themes.git') " Status bar
  call dein#add('vim-airline/vim-airline.git') " Status bar

  call dein#end()
  call dein#save_state()
endif

" Required for Dein
filetype plugin indent on
syntax enable

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

" Non-git file_rec. Commented out for now.
"nnoremap <C-p> :Denite file_rec<cr>

" Recursive search. Not sure what this first one is.
"nnoremap \F :Denite -buffer-name=search%`bufnr('%')` line<CR>
nnoremap \f :Denite grep:. -buffer-name=search-buffer<CR>

" --- NeoMake ---

let g:neomake_javascript_enabled_makers = ['eslint', 'jshint']
"let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_typescript_enabled_makers = ['tslint', 'tsc']

"Tsc
let g:neomake_typescript_tsc_exe = $PWD .'/node_modules/typescript/bin/tsc'
j
" Tslint
let g:neomake_typescript_tslint_exe = $PWD .'/node_modules/tslint/bin/tslint'
" --format verbose was stopping the linter from working in one instance.
" TODO: Investigate.
let g:neomake_typescript_tslint_args = ['%:p', $PWD .'/tslint.json']
" let g:neomake_typescript_tslint_args = ['%:p', '--format verbose', $PWD .'/tslint.json']

autocmd! BufWritePost * Neomake

" --- Emmet ---

let g:user_emmet_install_global = 0 "Enable only for HTML/CSS #1
autocmd FileType html,css,less,html.twig EmmetInstall "Enable only for HTML/CSS/Twig #2

" --- Deoplete ---

let g:deoplete#enable_at_startup = 1

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ deoplete#mappings#manual_complete()

function! s:check_back_space() abort "{{{
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction "}}}

" --- Airline themes ---

let g:airline_powerline_fonts = 1

" --- Darcula color ---

color darcula

" --- Number Line Toggle ---

nnoremap <silent> <C-n> :set nu rnu!<cr>

" --- TernJS / TernJS-Deoplete ---

" Requires cli install
" - npm i -g tern

" Use deoplete.
let g:tern_request_timeout = 1
let g:tern_show_signature_in_pum = '0'  " This do disable full signature type on autocomplete

" Add extra filetypes - Not currently necessary - will uncomment if/when this is needed.
" let g:tern#filetypes = [
"                 \ 'jsx',
"                 \ 'javascript.jsx',
"                 \ 'vue',
"                 \ ]

" Use tern_for_vim.
let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]

" --- Editorconfig ---

" Requires cli install
" - OSX: brew install editorconfig
" - Ubuntu: sudo apt install editorconfig
" This may change later - we will see.

let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
let g:EditorConfig_core_mode = 'external_command'
let g:EditorConfig_verbose = 1 " TEMP - currently debugging (not working)

" --- Javascript ---

let g:javascript_plugin_jsdoc = 1
