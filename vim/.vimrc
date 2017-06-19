" -------------
" -- Plugins --
" -------------
"
"Pathogen
execute pathogen#infect()

"Unite
nnoremap <silent> \f :<C-u>Unite grep:. -buffer-name=search-buffer<CR>

if executable('pt')
    let g:unite_source_grep_command = 'pt'
    let g:unite_source_grep_default_opts = '--nogroup --nocolor'
    let g:unite_source_grep_recursive_opt = ''
    let g:unite_source_grep_encoding = 'utf-8'
endif

nnoremap <C-p> :Unite file_rec/git<cr>
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1

"Hardtime
"let g:hardtime_default_on = 1
"let g:hardtime_ignore_buffer_patterns = ["NERD.*"] "Disable on NERDTree buffers

"Syntastic
set laststatus=2
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set statusline+=%f
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let syntastic_mode_map = { 'passive_filetypes': ['html'] }
let g:syntastic_less_use_less_lint = 1
let g:syntastic_typescript_checkers = ['tslint']
"let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_quiet_messages = { 'regex': 'Possible strict violation' }
let g:syntastic_scala_checkers = ['scalac']

"Emmet
let g:user_emmet_install_global = 0 "Enable only for HTML/CSS #1
autocmd FileType html,css,html.twig EmmetInstall "Enable only for HTML/CSS/Twig #2

"NERDTree
map <silent> \n :NERDTreeToggle<CR>
map <silent> \m :NERDTreeFind<cr>
let g:NERDTreeWinSize=40

"Rainbow Parentheses
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" -------------------
" -- Misc settings --
" -------------------

"Vi compatibility is not important here
set nocompatible

"Syntax highlighting
syntax on

"Colors
color darcula

"Filetype-specific indent settings. TODO: .vim/indent
filetype plugin indent on

"Esc remap to jk
"inoremap jk <Esc>

"Highlight search terms
set hlsearch

"Search while typing in search query
set incsearch

"Tab settings
set tabstop=2 shiftwidth=2 smarttab expandtab

"Command line completion
set wildmenu

"Relative line numbers
set rnu

"Easier buffer switching
nnoremap \b :ls<cr>:b<space>

"Buffer-only session save
nnoremap <silent> \s :set sessionoptions=buffers<cr>:mksession!<cr>:echo "Session saved"<cr>
nnoremap <silent> \l :so Session.vim<cr>:echo "Session loaded"<cr>

"Stops ex mode
nnoremap Q <nop>

"Clear last search highlighting
nnoremap <silent> <Space> :noh<cr>

"Diff unsaved buffer with previously saved version
nnoremap <silent> \d :w !diff % -<cr>

"Show whitespace
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set list

"Spelling setup
autocmd BufRead,BufNewFile * setlocal spell spelllang=en_us

"MQ - macro for commit messages
let @q = "/MQWEBy3eggpIJIRA story: Ogg:nohA" " Main
let @w = "/MQCONTy3eggpIJIRA story: Ogg:nohA" " Secondary
let @e = "/MQ4yt-ggpIJIRA stories: 2F-xOgg:nohA" " Both / multiple - TODO: Test

"%% -> current file directory in Command mode.
cabbr <expr> %% expand('%:p:h')

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Quick visual mode 'macros'
vnoremap \q :norm 

" Stops <Esc> delay
set ttimeoutlen=50

" Set visuals of active window
set cul
augroup BgHighlight
  autocmd!
  autocmd WinEnter * call WindowEnterHighlight()
  autocmd WinLeave * call WindowLeaveHighlight() 
augroup END

function! WindowEnterHighlight()
  set cul
  set colorcolumn=121
endfunction

function! WindowLeaveHighlight()
  set nocul
  set colorcolumn=0
endfunction

" Pathogen extras
call pathogen#helptags()

" Copy current relative/full file path to system clipboard
nnoremap <silent> \c :let @*=@%<cr>:echo "Current file's relative path copied to system clipboard"<cr>
nnoremap <silent> \C :let @*=expand('%:p')<cr>:echo "Current file's full path copied to system clipboard"<cr>
