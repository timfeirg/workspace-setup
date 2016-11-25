" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker:

" vim-plug auto install {
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    echo "Installing vim-plug for current user"
    curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif
" }

" vim-plug plugins {
call plug#begin('~/.vim/plugged')

" code navigation and project navigation {

" file tree, for preview rather than navigation
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle'  }

" file navigation within project
Plug 'ctrlpvim/ctrlp.vim'
" yankring inside ctrlp, as an extension
Plug 'sgur/ctrlp-extensions.vim'
" Very simple function navigator for ctrlp.vim.
Plug 'tacahiroy/ctrlp-funky'
" search history in ctrlp
Plug 'ompugao/ctrlp-history'

" split pane navigation
Plug 't9md/vim-choosewin'
Plug 'zhaocai/GoldenView.Vim'
Plug 'szw/vim-maximizer'

" close quickfix window when quit parent window
Plug 'romainl/vim-qf'

" go to anywhere on screen within 3 keystrokes
Plug 'Lokaltog/vim-easymotion'

" similar to sublime's multi cursors, though not quite there
Plug 'terryma/vim-multiple-cursors'

" }

" general vim behavior {

" git integration, :Gvdiff command is extremely useful
Plug 'tpope/vim-fugitive'

" }

" code edting helper plugin {

" aligns code
Plug 'godlygeek/tabular'

" sql format
Plug 'mbra/prettysql'

" strip whitespace
Plug 'ntpeters/vim-better-whitespace'

" edit code snippet in a separate buffer
Plug 'chrisbra/NrrwRgn'

" neocomplete is fast, but has some weird bugs, so
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --gocode-completer --tern-completer' }
" shift tab will not work with plain terminal neovim, supertab can fix this
Plug 'ervandew/supertab'
" make YouCompleteMe faster editing long folds,
" https://github.com/klen/python-mode/issues/523
Plug 'Konfekt/FastFold'
Plug 'Konfekt/FoldText'

Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'

" enhanced dot repeat
Plug 'tpope/vim-repeat'

" Simplified clipboard functionality for Vim.
Plug 'svermeulen/vim-easyclip'

" bunch of handy key-mappings
Plug 'tpope/vim-unimpaired'

" code snippets
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" surround stuff with other stuff
Plug 'tpope/vim-surround'

" auto insert close brackets
Plug 'Raimondi/delimitMate'

" nerdcommenter has a great name, but it just don't get python comments,
" besides, tcomment_vim is more actively developed
Plug 'tomtom/tcomment_vim'

" table mode, useful when drawing tables
Plug 'dhruvasagar/vim-table-mode'

" async syntax checker
Plug 'benekastah/neomake'

" }

" search enhancement {

" ag in vim
Plug 'mileszs/ack.vim'

" star key to search in visual mode, z* for hold
Plug 'haya14busa/vim-asterisk'

" highlight search when using '/'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'

" interactive search & replace
Plug 'osyo-manga/vim-over'

" }

" special file type handler {

" the famous emmet, for html
Plug 'mattn/emmet-vim'

" go
Plug 'fatih/vim-go'

" highlight csv files
Plug 'chrisbra/csv.vim'

Plug 'python-mode/python-mode', { 'branch': 'develop' }
Plug 'tmhedberg/SimpylFold'

" A solid language pack for Vim.
Plug 'sheerun/vim-polyglot', {'do': './build'}

" }

" vim UI {

" fancy simbols on the command line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'altercation/vim-colors-solarized'
" }

call plug#end()
" }

" general vim settings {

set foldnestmax=1
set clipboard=unnamed

" no mouse
set mouse=
set guicursor=

" Start an external command with a single bang
nnoremap ! :!

" auto save file on losing focus
autocmd BufLeave,FocusLost * silent! wall

" save & quit
noremap <C-q> :wqa<CR>

" don't beep
set visualbell
set noerrorbells

" don't use .swp files, git commit a lot and log your changes
set nobackup
set noswapfile

" handy sudo
cmap w!! w !sudo tee % >/dev/null

set wildignore+=*/tmp/*,*.so,*.pyc,\.ropeproject
set wildignorecase

" vim command autocomplete suggestions
set wildmenu
set wildmode=longest:full,full

" scrolling {
set scrolloff=5
set backspace=indent,eol,start
" }

" vim user interface {
highlight NonText ctermfg=0
set termencoding=utf-8
set fillchars-=vert:\|
" Open new split panes to right and bottom, which feels more natural than
" Vim’s default
set splitbelow
set splitright
set background=dark
colorscheme solarized
highlight Comment cterm=italic
" make tilde sign darker
" }

" vim key mapping {
" escape key take immediate effect
if ! has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        autocmd InsertEnter * set timeoutlen=0
        autocmd InsertLeave * set timeoutlen=1000
    augroup END
endif

" remap leader key
let mapleader=","
" ';' key will enter command mode
nnoremap ; :
vnoremap ; :
nmap j gj
nmap k gk
" }

" filetype handling {
autocmd FileType cfg set filetype=conf
autocmd BufRead,BufNewFile *.conf setf dosini
autocmd BufRead,BufNewFile *.geojson set filetype=json
autocmd BufRead,BufNewFile *.zsh-theme set filetype=zsh

autocmd FileType python setlocal nowrap nonumber
autocmd FileType go setlocal nowrap
autocmd FileType html setlocal expandtab shiftwidth=2 softtabstop=2 nowrap
autocmd FileType ruby setlocal expandtab shiftwidth=2 softtabstop=2 nowrap
autocmd FileType xml setlocal shiftwidth=2 nowrap
autocmd FileType htmldjango setlocal expandtab shiftwidth=2 softtabstop=2 nowrap
autocmd FileType javascript setlocal expandtab shiftwidth=2 softtabstop=2 nowrap
autocmd FileType css setlocal shiftwidth=2
autocmd FileType zsh setlocal shiftwidth=2
autocmd FileType sh setlocal shiftwidth=2
autocmd FileType lua setlocal expandtab shiftwidth=2 softtabstop=2 nowrap
" }
" }

" vim plugin config {

" ack.vim {
let g:ackprg = 'ag --nogroup --nocolor --column'
cnoreabbrev Ack Ack!
" }

" ultisnips {
let g:UltiSnipsExpandTrigger = "<C-l>"
let g:UltiSnipsJumpForwardTrigger = "<C-j>"
let g:UltiSnipsJumpBackwardTrigger = "<C-k>"
" }

" vim-snippets {
let g:snips_email = 'liuyifu@ricebook.com'
let g:snips_author = 'timfeirg'
let g:snips_github = 'https://github.com/timfeirg/'
" }

"  YouCompleteMe {
nnoremap <C-c>g :YcmCompleter GoTo<CR>
nnoremap K :YcmCompleter GetDoc<CR>
let g:ycm_python_binary_path = '/usr/local/bin/python3'
let g:ycm_goto_buffer_command = 'vertical-split'
let g:ycm_key_list_select_completion = ['<TAB>']
let g:ycm_key_list_previous_completion = ['<S-TAB>']
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_min_num_identifier_candidate_chars = 4
" good for writing python comments
let g:ycm_complete_in_comments = 1
" python built-in function & keywords completion
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_filetype_blacklist = {
			\ 'tagbar' : 1,
			\ 'qf' : 1,
			\ 'notes' : 1,
			\ 'unite' : 1,
			\ 'text' : 1,
			\ 'vimwiki' : 1,
			\ 'pandoc' : 1,
			\ 'infolog' : 1,
			\ 'mail' : 1
			\}
" }

" golden view {
let g:goldenview__enable_default_mapping = 0
nnoremap <nop> <Plug>GoldenViewSplit
" }

" vim-go {
autocmd FileType go set foldmethod=syntax
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_fields = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_build_constraints = 1
" }

" pymode python-mode {
" pymode is useless except for the rope features, so I disabled everything
let g:pymode_folding = 0
let g:pymode_syntax = 0
let g:pymode_rope_goto_definition_bind = '<nop>'
let g:pymode_rope_ropefolder = '../.ropeproject'
let g:pymode_rope_rename_bind = '<C-c>rr'
let g:pymode_rope_completion = 0
let g:pymode_rope_complete_on_dot = 0
let g:pymode_rope_autoimport_import_after_complete = 1

let g:pymode_lint = 0
let pymode_lint_write = 0
let g:pymode_lint_signs = 0
let g:pymode_lint_on_write = 0

let g:pymode_run = 0

let g:pymode_options_colorcolumn = 0

let g:pymode_syntax = 1
let g:pymode_syntax_print_as_function = 1
" }

" lua {
let g:lua_inspect_warnings = 0
" }

" multi cursor {
" let multiple cursors work with YouCompleteMe
function! Multiple_cursors_before()
    let g:ycm_auto_trigger = 0
endfunction

function! Multiple_cursors_after()
    let g:ycm_auto_trigger = 1
endfunction
" }

" NERDtree {
" the origin T wasn't much use, so I remap both T and t: T for Tree and t for
" tags looks intuitive to me
nnoremap T :NERDTree<cr>
let NERDTreeShowFiles=1
let NERDTreeRespectWildIgnore=1
let NERDTreeQuitOnOpen=1
let NERDTreeAutoDeleteBuffer=1
let NERDTreeMinimalUI=1
" disable some of the nerdtree commands to map T to open nerdtree
let NERDTreeMapOpenInTabSilent='<nop>'
let NERDTreeMapOpenInTab='<nop>'
" be consistent with ctrlspace, use v for open in v split
let g:NERDTreeMapOpenVSplit='v'
" }

" tcommenter {
let g:tcommentMapLeaderOp1 = '<leader>c'
" }

" airline {
let g:airline_powerline_fonts = 1
" unnecessary ?
let g:airline_exclude_preview = 1
let g:airline_section_b = ''
let g:airline_section_x = ''
let g:airline_section_y = ''
" let g:webdevicons_enable_airline_statusline = 0
" without this line, airline won't load until there's split windows
set laststatus=2
" don't show mode in the bottom line
set noshowmode
" }

" easymotion {
" the original f deal with single line navigation, and most movements are not
" within a single line, so I map f to a more powerful easymotion command
nmap f <Plug>(easymotion-s)
omap F <Plug>(easymotion-bd-w)
nmap F <Plug>(easymotion-bd-w)
vmap F <Plug>(easymotion-bd-w)
let g:EasyMotion_use_upper = 1
let g:EasyMotion_use_smartsign_us = 1
let g:EasyMotion_smartcase = 1
let g:EasyMotion_inc_highlight = 1
let g:EasyMotion_keys = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ;'
let g:EasyMotion_enter_jump_first = 1
" }

" special filetype {

" for .hql files
au BufNewFile,BufRead *.hql set filetype=hive expandtab

" for .q files
au BufNewFile,BufRead *.q set filetype=hive expandtab
" }

" table mode {
let g:table_mode_corner_corner = '-'
let g:table_mode_corner = '-'
" }

" neomake {
autocmd! BufWritePost * Neomake
let g:neomake_open_list=2
let g:neomake_list_height=3
let g:neomake_place_signs=0
let g:neomake_python_enabled_makers = ['flake8']
let g:neomake_python_flake8_maker = {
            \ 'args': ['--ignore', 'E501,E225,E203']}
" }

" identation {
set showtabline=0
set autoindent
" set nosmartindent
set showmatch
set linebreak
set nolist
set textwidth=0
set wrapmargin=0
" }

" choosewin {
" Display window label in the middle of each window
map - <Plug>(choosewin)
" }

" vim-maximizer {
nnoremap <leader>- :MaximizerToggle<CR>
" }

" ctrlp and plugins {
let g:ctrlp_mruf_case_sensitive = 0
let g:ctrlp_map = '<nop>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_tilde_homedir = 1
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'
let g:ctrlp_max_depth = 40
let g:ctrlp_max_files = 99999
let g:ctrlp_extensions = ['funky']
let g:ctrlp_custom_ignore = {
            \ 'dir':  '\v[\/]\.(git|hg|svn)$',
            \ 'file': '\v\.(log|so|pyc)$',
            \ }
" ctrl + space will launch file navigation
nnoremap <C-@> :CtrlPMixed<CR>
nnoremap <C-space> :CtrlPMixed<CR>
" show all history vim commands and enter fuzzy search
nnoremap <leader>; :CtrlPCmdline<CR>
" yankring {
let g:ctrlp_yankring_limit = 100
nnoremap <Leader>p :CtrlPYankring<CR>
" }
" funky {
" after jump, move code to the center and open fold recursively
let g:ctrlp_funky_after_jump = 'zOzt'
let g:ctrlp_funky_nerdtree_include_files = 1
let g:ctrlp_funky_sort_by_mru = 1
let g:ctrlp_funky_syntax_highlight = 1
let g:ctrlp_funky_matchtype = 'path'
let g:ctrlp_follow_symlinks = 1
" t stands for tags
nnoremap t :CtrlPFunky<Cr>
nnoremap <leader>/ :CtrlPSearchHistory<CR>
" }
" }

" vim-easyclip {
let g:EasyClipUseSubstituteDefaults = 1
let g:EasyClipUseYankDefaults = 0
" M will cut till end of line, just like D to d
nmap M m$
nnoremap gm m
"

" vim-over {
set gdefault
" this will directly enter search and replace
nnoremap <Leader>s :OverCommandLine<CR>%s/
" }

" vim asterisk {
map *   <Plug>(asterisk-*)
map #   <Plug>(asterisk-#)
map g*  <Plug>(asterisk-g*)
map g#  <Plug>(asterisk-g#)
map z*  <Plug>(asterisk-z*)
map gz* <Plug>(asterisk-gz*)
map z#  <Plug>(asterisk-z#)
map gz# <Plug>(asterisk-gz#)
" }

" vim csv {
let g:csv_highlight_column = 'y'
" }

" incsearch {
set hlsearch
set ignorecase
set smartcase
set incsearch
set showmatch
let g:incsearch#auto_nohlsearch = 1
map n <Plug>(incsearch-nohl-n)
map N <Plug>(incsearch-nohl-N)
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

map z/ <Plug>(incsearch-fuzzy-/)
map z? <Plug>(incsearch-fuzzy-?)
map zg/ <Plug>(incsearch-fuzzy-stay)
" }

" delimitMate {
let delimitMate_nesting_quotes = ['"','`']
let delimitMate_jump_expansion = 1
let delimitMate_expand_space = 1
let delimitMate_expand_cr = 1
" python doc string require this
au FileType python let b:delimitMate_expand_inside_quotes = 1
au FileType python let b:delimitMate_nesting_quotes = ['"', "'"]
" }

" }