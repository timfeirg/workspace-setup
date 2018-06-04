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
Plug 'danro/rename.vim'

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
Plug 'roman/golden-ratio'
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
" unix helpers like SudoEdit, Delete
Plug 'tpope/vim-eunuch'

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

Plug 'nixprime/cpsm', { 'do': 'PY3=ON ./install.sh' }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-go', { 'do': 'make'}
Plug 'davidhalter/jedi-vim'
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
Plug 'jiangmiao/auto-pairs'

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

" }

" special file type handler {

Plug 'valloric/matchtagalways'
Plug 'mattn/emmet-vim'

" go
Plug 'fatih/vim-go'

" highlight csv files
Plug 'chrisbra/csv.vim'

Plug 'tmhedberg/SimpylFold'

" A solid language pack for Vim.
Plug 'sheerun/vim-polyglot'
" for reStructured Text
Plug 'gu-fan/riv.vim'

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

let g:python3_host_prog='python3'

" escape key take immediate effect
if ! has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        autocmd InsertEnter * set timeoutlen=0
        autocmd InsertLeave * set timeoutlen=1000
    augroup END
endif

let mapleader=","
nnoremap ; :
vnoremap ; :
nmap j gj
nmap k gk
" de-highlight when redraw
nnoremap <leader>l :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>
" Don't lose selection when shifting sidewards
xnoremap <  <gv
xnoremap >  >gv

nnoremap <leader>s :%s/

nnoremap ! :!
" save when cursor leaves buffer
autocmd BufLeave,FocusLost * silent! wall
noremap <C-q> :wqa<CR>
" handy sudo
cmap w!! w !sudo tee % >/dev/null

set inccommand=split
set gdefault
set foldnestmax=1
set clipboard=unnamed
set autoread
set lazyredraw
set visualbell
set noerrorbells
set nobackup
set noswapfile
set mouse=
set wildignore+=*/tmp/*,*.so,*.pyc,\.ropeproject
set wildignorecase
set wildmenu
set wildmode=longest:full,full
set maxmempattern=2000

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
" hide tildes
hi! EndOfBuffer ctermbg=bg ctermfg=bg guibg=bg guifg=bg
highlight Comment cterm=italic
" make tilde sign darker
" }

" filetype handling {
set nowrap

autocmd FileType cfg set filetype=conf
autocmd BufRead,BufNewFile *.conf setf dosini
autocmd BufRead,BufNewFile *.geojson set filetype=json
autocmd BufRead,BufNewFile *.zsh-theme set filetype=zsh
autocmd BufRead,BufNewFile *.hql set filetype=hive expandtab
autocmd BufRead,BufNewFile *.q set filetype=hive expandtab

autocmd FileType python setlocal nonumber nowrap
autocmd FileType json setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType vue setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType html setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType ruby setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType xml setlocal shiftwidth=2
autocmd FileType htmldjango setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType javascript setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType css setlocal shiftwidth=2
autocmd FileType zsh setlocal shiftwidth=2
autocmd FileType sh setlocal shiftwidth=2
autocmd FileType lua setlocal expandtab shiftwidth=2 softtabstop=2
" see https://github.com/posva/vim-vue#my-syntax-highlighting-stops-working-randomly
autocmd FileType vue syntax sync fromstart
" }
" }

" vim plugin config {

" ack.vim {
let g:ackprg = 'ag --nogroup --nocolor --column'
cnoreabbrev Ack Ack!
" }

" ultisnips {
let g:UltiSnipsExpandTrigger = "<C-l>"
" }

" vim-snippets {
let g:snips_email = 'kkcocogogo@gmail.com'
let g:snips_author = 'timfeirg'
let g:snips_github = 'https://github.com/timfeirg/'
" }

" deoplete {
let g:deoplete#enable_at_startup = 1
if !exists('g:deoplete#omni#input_patterns')
    let g:deoplete#omni#input_patterns = {}
endif
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort
    return deoplete#close_popup() . "\<CR>"
endfunction
let g:deoplete#enable_smart_case = 1
let g:deoplete#sources#jedi#show_docstring = 1
" use tab / shift-tab to cycle through candidates
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
call deoplete#custom#source('_', 'matchers', ['matcher_cpsm'])
call deoplete#custom#var('buffer', 'require_same_filetype', v:false)
call deoplete#custom#option('sources', {
            \ '_': ['buffer', 'ultisnips'],
            \ 'python': ['ultisnips', 'jedi', 'buffer'],
            \ 'go': ['ultisnips', 'go', 'buffer'],
            \})
" automatically close the scratch window
" see https://gregjs.com/vim/2016/configuring-the-deoplete-asynchronous-keyword-completion-plugin-with-tern-for-vim/
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
" }

" jedi-vim {
let g:jedi#auto_vim_configuration = 0
let g:jedi#goto_command = '<C-c>g'
let g:jedi#goto_definitions_command = ''  " dynamically done for ft=python.
let g:jedi#use_tabs_not_buffers = 0  " current default is 1.
let g:jedi#rename_command = '<C-c>rr'
let g:jedi#usages_command = '<Leader>gu'
let g:jedi#completions_enabled = 0
let g:jedi#smart_auto_mappings = 1
let g:jedi#documentation_command = 'K'
let g:jedi#auto_close_doc = 1
let g:jedi#use_splits_not_buffers = 'winwidth'
" }

" vim-go {
autocmd FileType go set foldmethod=syntax
autocmd FileType go nnoremap <C-c>g :<C-u>call go#def#Jump("vsplit")<CR>
autocmd FileType go nnoremap <C-c>rr :GoRename<CR>
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_space_tab_error = 1
let g:go_highlight_trailing_whitespace_error = 1
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_string_spellcheck = 1
let g:go_highlight_format_strings = 1
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
nnoremap T :NERDTreeToggle %<cr>
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
let g:tcomment_opleader1 = '<leader>c'
" }

" airline {
let g:airline_powerline_fonts = 1
let g:airline_exclude_preview = 1
let g:airline_section_b = ''
let g:airline_section_x = ''
let g:airline_section_y = ''
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
let g:EasyMotion_skipfoldedline = 0
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
let g:neomake_go_gometalinter_args = ['--fast', '--deadline=360', '--vendor', '--enable-gc', '--exclude="should have comment or be unexported"']

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
let g:ctrlp_tilde_homedir = 1
let g:ctrlp_clear_cache_on_exit = 1
let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'
let g:ctrlp_max_depth = 40
let g:ctrlp_max_files = 99999
let g:ctrlp_extensions = ['funky']
let g:ctrlp_custom_ignore = {
            \ 'dir':  'node_modules\|DS_Store\|git\|vendor\|_book',
            \ 'file': '\v\.(log|so|pyc)$',
            \ }
nnoremap <C-@> :CtrlPMixed<CR>
nnoremap <C-space> :CtrlPMixed<CR>
" show all history vim commands and enter fuzzy search
nnoremap <leader>; :CtrlPCmdline<CR>
" yankring {
let g:ctrlp_yankring_limit = 100
nnoremap <leader>p :CtrlPYankring<CR>
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

" }
