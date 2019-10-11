let g:RvDev_CurrentConfigType = 'full'
source ~/rvconfig/nvim-vim-shared/shared.vim

" ********** "
"            "
" Misc Setup "
"            "
" ********** "

" Preview replacements in a split

set inccommand=split

" Auto import sorting for Typescript

function! RVDEV_SortTypescriptImports()
  let l:rangePrefix="'b,'n"
  " Set begin and end markers - b is beginning, n is end, per range prefix above
  execute "normal gg/mport\<CR>hmbG?^import\<CR>f{%mn"
  " Remove blank lines
  execute l:rangePrefix.'g/^$/d'
  " Set all import statements to 1-liners
  execute l:rangePrefix.'g/import {$/norm jvi{JJkJ'
  " Sort start from the first single quote
  execute l:rangePrefix."sort /'/"
  " Move local imports to the bottom of the list with a newline separator
  execute "normal 'bV/'@\<CR>kd'npO"
endfunction

nnoremap \o :call RVDEV_SortTypescriptImports()<CR>

" Persistent undo

set undodir=~/.config/nvim/undodir
set undofile

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
  call dein#add('dense-analysis/ale.git') " Multi-language linting
  call dein#add('flowtype/vim-flow.git') " Support for FB's Flow
  call dein#add('honza/vim-snippets.git') " Snippets (Engine below)
  call dein#add('kristijanhusak/vim-js-file-import', {'build': 'npm install'}) " Ctags-based Automatic import statements
  call dein#add('mattn/emmet-vim.git') " Emmet integration
  call dein#add('michaeljsmith/vim-indent-object.git') " Indentation text objects
  call dein#add('morhetz/gruvbox.git') " Color theme
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
  call dein#add('Yggdroot/indentLine.git') " Indentation guide lines
  call dein#add('zhaocai/vim-space.git') " Extra navigation options

  " Disabled for testing:
  " call dein#add('mhartington/nvim-typescript', {'build': './install.sh'})
  " call dein#add('NLKNguyen/papercolor-theme.git') " Colors
  " call dein#add('Galooshi/vim-import-js.git') " Automatic import statements
  " call dein#add('tbodt/deoplete-tabnine', {'build': './install.sh'}) " Smart autocomplete

  call dein#end()
  call dein#save_state()
endif

" Install on run
if dein#check_install()
  call dein#install()
endif

" --- Denite ---

" File_rec/git
call denite#custom#alias('source', 'file/rec', 'file_rec')
call denite#custom#var('file/rec', 'command',
\ ['git', 'ls-files', '-co', '--exclude-standard'])
nnoremap <silent> <C-p> :<C-u>Denite
\ `finddir('.git', ';') != '' ? 'file/rec' : 'file_rec'`<CR>

" Ripgrep command on grep source
call denite#custom#var('grep', 'command', ['rg', '-g', '!tags'])
call denite#custom#var('grep', 'default_opts',
\ ['--vimgrep', '--no-heading'])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])

" Commented out to test ripgrep:
" Ag command for grep source
" call denite#custom#var('grep', 'command', ['ag'])
" call denite#custom#var('grep', 'default_opts',
"   \ ['-i', '--vimgrep'])
" call denite#custom#var('grep', 'pattern_opt', [])

call denite#custom#var('grep', 'recursive_opts', [])
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
" Tag with <C-o> + */Space + tab + 'quickfix', and use with :cdo for project-wide actions
nnoremap \F :DeniteProjectDir -buffer-name=grep -default-action=quickfix grep:::!<CR>

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

" --- Gruvbox theme ---

set background=dark
let g:gruvbox_contrast_dark = 'hard'
colorscheme gruvbox

" --- Fugitive ---

nnoremap <silent> \cb :let @+=fugitive#head()<cr>:echo "Current branch's name coped to system clipboard"<cr>

" --- Polyglot ---

" Allows us to see actual markdown text. Set to 1, which is the default, as a
" test. Will revert to 0 if this becomes hard to use.
let g:vim_markdown_conceal = 1
let g:javascript_plugin_flow = 1

" --- Neosnippits ---

let g:neosnippet#disable_runtime_snippets={ '_' : 1 }
let g:neosnippet#enable_snipmate_compatibility=1
let g:neosnippet#snippets_directory=$HOME.'/.nvimpkg/repos/github.com/honza/vim-snippets/snippets'

imap <C-j> <Plug>(neosnippet_expand_or_jump)
smap <C-j> <Plug>(neosnippet_expand_or_jump)
xmap <C-j> <Plug>(neosnippet_expand_target)

" --- TypeScript ---

set completeopt-=preview

" --- ALE ---

nnoremap \af :ALEFix<cr>
" let g:ale_lint_delay = 1000
set statusline+=\ E\:%{ale#statusline#Count(bufnr('')).total}

" --- IndentLine ---

" Stop IndentLine from overwriting our concealcursor settings. This causes the
" indent lines to not be visible on the current line (and also Visual
" mode-selected lines). I find this to be worth it.
let g:indentLine_setConceal = 0

" --- Flow ---

" Disable type checking upon save:
let g:flow#enable = 0
