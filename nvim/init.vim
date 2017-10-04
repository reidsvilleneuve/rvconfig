" TODO: Separate into multiple files and source them.

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

  call dein#add('kburdett/vim-nuuid.git') " TEMP - Generate a UUID.

  call dein#add('blueshirts/darcula.git') " Color scheme
  call dein#add('carlitux/deoplete-ternjs.git') " Deoplete utility
  call dein#add('ConradIrwin/vim-bracketed-paste.git')
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
endfunction"}}}

" --- Airline themes ---

let g:airline_powerline_fonts = 1

" --- Darcula color ---

color darcula

" --- Number Line Toggle ---

let g:NumberToggleTrigger="<C-n>"

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

" --- Javascript ---

let g:javascript_plugin_jsdoc = 1

" ************* "
"               "
" Misc Settings "
"               "
" ************* "

" --- Whitespace chars ---

set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set list

" --- Hide search highlighting ---

nnoremap <silent> <Space> :noh<CR>

" --- Easier window navigation ---

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" --- Menu / Tab completion ---

set wildmode=longest:list,full
set wildmenu

" --- Expand %% to path of current file ---

" This implementation broke. TODO: Figure out why:
"cabbr <expr> %% expand('%:p:h')

cabbr %% <C-R>=expand('%:p:h')<CR>

" --- Tabs / two spaces toggle ---

" Old implementation:
" set expandtab tabstop=2 shiftwidth=2 softtabstop=2
" set shiftwidth=2 softtabstop=0 noexpandtab

let my_tab=2

execute "set shiftwidth=".my_tab
execute "set softtabstop=".my_tab
execute "set tabstop=".my_tab

set expandtab
"
" allow toggling between local and default mode
function! TabToggle()
  if &expandtab
    execute "set shiftwidth=".g:my_tab
    set softtabstop=0
    set noexpandtab
    echo "Set to tabs."
  else
    execute "set shiftwidth=".g:my_tab
    execute "set tabstop=".g:my_tab
    execute "set softtabstop=".g:my_tab
    set expandtab
    echo "Set to spaces."
  endif
endfunction

nmap <F9> mz:execute TabToggle()<CR>'z

" --- Highlight search terms ---

set hlsearch

" --- Search while typing in search query ---

set incsearch

" --- Easier buffer switching ---

nnoremap \b :ls<cr>:b<space>

" --- Buffer-only session save ---

nnoremap <silent> \s :set sessionoptions=buffers<cr>:mksession!<cr>:echo "Session saved"<cr>
nnoremap <silent> \l :so Session.vim<cr>:echo "Session loaded"<cr>

" --- Stops ex mode ---

nnoremap Q <nop>

" --- Diff unsaved buffer with previously saved version ---

nnoremap <silent> \d :w !diff % -<cr>

" --- Spelling setup ---

autocmd BufRead,BufNewFile * setlocal spell spelllang=en_us

" ---  Quick visual mode 'macros' ---

vnoremap \q :norm 

" ---  Set visuals of active window ---

set cul
augroup BgHighlight
  autocmd!
  autocmd WinEnter * call WindowEnterHighlight()
  autocmd WinLeave * call WindowLeaveHighlight() 
augroup END

" TODO: Combine these functions:
function! WindowEnterHighlight()
  set cul
  set colorcolumn=121
endfunction

function! WindowLeaveHighlight()
  set nocul
  set colorcolumn=0
endfunction

call WindowEnterHighlight()

" --- Tree style netrw ---

" TODO: Figure out why this is being glitchy.
"let g:netrw_liststyle= 3
"
" --- Copy current relative/full file path to system clipboard ---

nnoremap <silent> \c :let @+=@%<cr>:echo "Current file's relative path copied to system clipboard"<cr>
nnoremap <silent> \C :let @+=expand('%:p')<cr>:echo "Current file's full path copied to system clipboard"<cr>

" --- Disable mouse ---

autocmd BufEnter * set mouse=

" --- Relative line numbers ---

set rnu

" ---  Quicker window movement ---

" NOTE: iTerm does not handle <C-h> properly - run this to work around if in OSX and using iTerm:
" infocmp $TERM | sed 's/kbs=^[hH]/kbs=\\177/' > $TERM.ti
" tic $TERM.ti

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" --- Quicker macro execution ---

set lazyredraw
