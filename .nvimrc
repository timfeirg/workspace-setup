" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker:

" vim-plug auto install {
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    echo "Installing vim-plug for current user"
    curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif
" }

" vim-plug plugins {
call plug#begin('~/.nvim/plugged')

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
" resize split pane properly
" Plug 'roman/golden-ratio'
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
Plug 'shumphrey/fugitive-gitlab.vim'
" Enables :Gbrowse from fugitive.vim to open GitHub URLs.
Plug 'tpope/vim-rhubarb'
" unix helpers like SudoEdit, Delete
Plug 'tpope/vim-eunuch'

" }

" code edting helper plugin {

" sql format
Plug 'mbra/prettysql'

" strip whitespace
Plug 'ntpeters/vim-better-whitespace'

" edit code snippet in a separate buffer
Plug 'chrisbra/NrrwRgn'

" auto-complete related plugins
Plug 'neovim/nvim-lsp'
Plug 'neovim/nvim-lspconfig'
Plug 'simrat39/rust-tools.nvim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'hrsh7th/cmp-vsnip'
Plug 'rafamadriz/friendly-snippets'
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'python-mode/python-mode', { 'branch': 'develop' }
Plug 'fisadev/vim-isort'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'

" enhanced dot repeat
Plug 'tpope/vim-repeat'

" Simplified clipboard functionality for Vim.
Plug 'svermeulen/vim-easyclip'

" bunch of handy key-mappings
Plug 'tpope/vim-unimpaired'

" surround stuff with other stuff
Plug 'tpope/vim-surround'

" auto insert close brackets
Plug 'jiangmiao/auto-pairs'

" nerdcommenter has a great name, but it just don't get python comments,
" besides, tcomment_vim is more actively developed
Plug 'tomtom/tcomment_vim'

" table mode, useful when drawing tables
Plug 'dhruvasagar/vim-table-mode'

" }

" search enhancement {

" ag in vim
Plug 'mileszs/ack.vim'

" star key to search in visual mode, z* for hold
Plug 'haya14busa/vim-asterisk'

" }

" special file type handler {

Plug 'valloric/matchtagalways'
Plug 'mattn/emmet-vim'
Plug 'chrisbra/csv.vim'
Plug 'dart-lang/dart-vim-plugin'
Plug 'scrooloose/vim-slumlord'
Plug 'aklt/plantuml-syntax'

" better python folding
Plug 'tmhedberg/SimpylFold'
Plug 'Konfekt/FastFold'

" }

" vim UI {

" fancy simbols on the command line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'tjdevries/colorbuddy.nvim'
Plug 'svrana/neosolarized.nvim'
" }

call plug#end()
" }

" general vim settings {

if has('macunix')
  function! OpenURLUnderCursor()
    let s:uri = expand('<cWORD>')
    let s:uri = substitute(s:uri, '?', '\\?', '')
    let s:uri = shellescape(s:uri, 1)
    if s:uri != ''
      silent exec "!open '".s:uri."'"
      :redraw!
    endif
  endfunction
  nnoremap gx :call OpenURLUnderCursor()<CR>
endif

set t_BE=

" nobody uses exmode
nnoremap Q <Nop>

augroup ClearUndo
    autocmd!
    autocmd VimLeave * !rm -rf ~/.nvim/undodir/*
augroup END
set undofile
set undodir=~/.nvim/undodir

" let g:python3_host_prog='python3'

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
cnoreabbrev gn Gwrite \| n
noremap <C-g> :Gwq<CR>

set inccommand=split
set gdefault
set foldnestmax=1
" hate it when vim auto fold something for me, I'll decide when to fold and
" unfold, motherfucker
set nofoldenable
set clipboard=unnamed
set autoread
set lazyredraw
set visualbell
set noerrorbells
set nobackup
set nowritebackup
set noswapfile
set mouse=
set wildoptions=pum
set wildignore+=*/tmp/*,*.so,*.pyc,\.ropeproject
set wildignorecase
set wildmenu
set wildmode=longest:full,full
set maxmempattern=2000
set nonumber
set hlsearch
set ignorecase
set smartcase
set incsearch
set showmatch

" scrolling {
set scrolloff=5
set backspace=indent,eol,start
" }

" vim user interface {
highlight NonText ctermfg=0
set fillchars=eob:\ 
" Open new split panes to right and bottom, which feels more natural than
" Vim’s default
set splitbelow
set splitright
set background=dark
set termguicolors
" }

" filetype handling {
set nowrap

autocmd FileType cfg set filetype=conf
autocmd BufRead,BufNewFile *.conf set filetype=dosini
autocmd BufRead,BufNewFile *.cfg set filetype=dosini
autocmd BufRead,BufNewFile requirements*.txt set filetype=requirements
autocmd BufRead,BufNewFile *.geojson set filetype=json
autocmd BufRead,BufNewFile *.zsh-theme set filetype=zsh
autocmd BufRead,BufNewFile .envrc set filetype=sh
autocmd BufNewFile,BufRead *.sh.j2 set ft=sh
autocmd BufRead,BufNewFile *.hql set filetype=hive expandtab
autocmd BufRead,BufNewFile *.q set filetype=hive expandtab
autocmd BufNewFile,BufRead *.html.j2 set ft=html
autocmd BufNewFile,BufRead *.yml.j2 set ft=yaml
autocmd BufNewFile,BufRead *.yaml.j2 set ft=yaml
autocmd BufNewFile,BufRead *.yml.tmpl set ft=yaml
autocmd BufNewFile,BufRead *.yaml.tmpl set ft=yaml
autocmd BufNewFile,BufRead *.service.j2 set ft=systemd
autocmd BufNewFile,BufRead *.dockerfile set ft=dockerfile
autocmd BufNewFile,BufRead dockerfile.* set ft=dockerfile
autocmd BufNewFile,BufRead *ockerfile.j2 set ft=dockerfile

autocmd FileType applescript setlocal expandtab shiftwidth=4 softtabstop=4
autocmd FileType sh setlocal expandtab shiftwidth=4 softtabstop=4
autocmd FileType systemd setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType vim setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType cpp setlocal expandtab shiftwidth=4 softtabstop=4
autocmd FileType c setlocal expandtab shiftwidth=4 softtabstop=4
autocmd FileType yaml setlocal indentkeys-=<:> expandtab shiftwidth=2 softtabstop=2
autocmd FileType requirements setlocal commentstring=#\ %s
autocmd FileType dockerfile setlocal expandtab shiftwidth=4 softtabstop=4
autocmd FileType qf setlocal nonumber
autocmd FileType man setlocal nonumber wrap
autocmd FileType python setlocal nonumber nowrap
autocmd FileType Jenkinsfile setlocal expandtab shiftwidth=4 softtabstop=4
autocmd FileType json setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType vue setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType html setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType nginx setlocal expandtab shiftwidth=4 softtabstop=4
autocmd FileType markdown setlocal wrap expandtab shiftwidth=4 softtabstop=4
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
let g:ack_autoclose = 0
" using location list allows quick navigation using [l and ]l
cnoreabbrev ag LAck!
let g:ack_mappings = { "h": "h", "s": "<C-W><CR><C-W>K" }
" }

" golden-ratio {
let g:golden_ratio_exclude_nonmodifiable = 1
" }

" auto-pairs {
let g:AutoPairs = {'(':')', '[':']', '{':'}', '```':'```', '"""':'"""', "'''":"'''", "`":"`"}
" }

" }

" better-whitespace {
let g:show_spaces_that_precede_tabs = 1
" }

" nvim-lsp and completion plugins {
set completeopt=menu,menuone,noinsert
set scl=no
autocmd BufWritePre *.go lua vim.lsp.buf.format()
nnoremap <silent> gd :vsplit<CR><cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gp <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <C-c>rr <cmd>lua vim.lsp.buf.rename()<CR>

imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

" https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
" https://www.xgithub.com/2019/11/14/neovim-nvim-lsp-common-configurations-for-neovim-language-servers/
lua << EOF
require('neosolarized').setup({
    comment_italics = true,
    background_set = false,
})
local configs = require('lspconfig/configs')
local util = require('lspconfig/util')
local path = util.path
local function get_python_path(workspace)
    -- Use activated virtualenv.
    if vim.env.VIRTUAL_ENV then
        return path.join(vim.env.VIRTUAL_ENV, 'bin', 'python')
    end

    -- Find and use virtualenv in workspace directory.
    for _, pattern in ipairs({'*', '.*'}) do
        local match = vim.fn.glob(path.join(workspace, pattern, 'pyvenv.cfg'))
        if match ~= '' then
            return path.join(path.dirname(match), 'bin', 'python')
        end
    end

    -- Fallback to system Python.
    return exepath('python3') or exepath('python') or 'python'
end

local on_attach = function(client, bufnr)
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

end

require('lspconfig').pyright.setup {
    before_init = function(_, config)
    config.settings = {
        pyright = {
            useLibraryCodeForTypes = true,
            autoImportCompletions = true,
        },
        python = {
            analysis = {
                autoSearchPaths = true,
                diagnosticMode = 'workspace',
                useLibraryCodeForTypes = true,
                typeCheckingMode = 'off'
            }
        }
    }
end,
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {debounce_text_changes = 150}
}

require('lspconfig').solc.setup{}

require'lspconfig'.tsserver.setup{
  filetypes = { "javascript", "typescript", "typescriptreact", "typescript.tsx" },
  root_dir = function() return vim.loop.cwd() end
}

require('lspconfig').gopls.setup {
    cmd = {"gopls", "serve"},
    filetypes = {"go", "gomod"},
    root_dir = util.root_pattern("go.work", "go.mod", ".git"),
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
                },
            staticcheck = true,
        },
    },
}

require'nvim-treesitter.configs'.setup {
    ensure_installed = {"python", "go"},
    sync_install = false,
    auto_install = true,
    ignore_install = { "javascript", "phpdoc" },
    highlight = {
        enable = true,
        disable = { "phpdoc" },
        additional_vim_regex_highlighting = false,
    },
}

vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ""

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and
               vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(
                   col, col):match("%s") == nil
end
local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end
local cmp = require'cmp'
cmp.setup {
    preselect = false,
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end,
    },
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-y>'] = cmp.config.disable,
        ['<C-e>'] = cmp.mapping({
          i = cmp.mapping.abort(),
          c = cmp.mapping.close(),
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif vim.fn["vsnip#available"](1) == 1 then
            feedkey("<Plug>(vsnip-expand-or-jump)", "")
          elseif has_words_before() then
            cmp.complete()
          else
            fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function()
          if cmp.visible() then
            cmp.select_prev_item()
          elseif vim.fn["vsnip#jumpable"](-1) == 1 then
            feedkey("<Plug>(vsnip-jump-prev)", "")
          end
        end, { "i", "s" }),
      },
      sources = {
        { name = 'nvim_lsp' },
        { name = 'vsnip' }, -- For vsnip users.
        { name = 'buffer' },
        { name = 'path' },
      },
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
EOF

" }

" jedi-vim {
let g:jedi#auto_vim_configuration = 0
let g:jedi#goto_command = '<C-c>g'
let g:jedi#goto_definitions_command = ''  " dynamically done for ft=python.
let g:jedi#use_tabs_not_buffers = 0  " current default is 1.
let g:jedi#completions_enabled = 0
let g:jedi#smart_auto_mappings = 0
let g:jedi#documentation_command = 'K'
let g:jedi#auto_close_doc = 1
let g:jedi#use_splits_not_buffers = 'winwidth'
let g:jedi#auto_initialization = 0
" }

" dart {
let dart_html_in_string=v:true
let dart_style_guide = 2
let dart_format_on_save = 1
" }

" pymode python-mode {
" pymode is useless except for the rope features, so I disabled everything
let g:pymode_syntax_all = 0
let g:pymode_rope = 1
let g:pymode_folding = 0
let g:pymode_rope_goto_definition_bind = '<nop>'
let g:pymode_rope_organize_imports_bind = '<nop>'
let g:pymode_rope_rename_bind = '<nop>'
let g:pymode_rope_ropefolder = '../.ropeproject'
let g:pymode_rope_completion = 0
let g:pymode_rope_complete_on_dot = 0
let g:pymode_rope_autoimport_import_after_complete = 1
let g:pymode_lint = 0
let g:pymode_run = 0
let g:pymode_options_colorcolumn = 0
let g:pymode_python = 'python3'
let g:pymode_syntax = 0
let g:pymode_virtualenv = 1
" }

" isort {
let g:vim_isort_python_version = 'python3'
noremap <silent> <C-c>ro :call pymode#rope#organize_imports()<CR>:Isort<CR>
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
nnoremap T :NERDTree %<cr>
let NERDTreeShowHidden=1
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
let g:airline#extensions#languageclient#enabled = 0
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

" fugitive {
cnoreabbrev gd Gvdiff
cnoreabbrev gb Git blame
let g:fugitive_gitlab_domains = ['https://git.behye.cn']
" }

" identation {
set showtabline=0
set autoindent
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
let g:maximizer_restore_on_winleave = 1
" }

" vim-qf {
let g:qf_shorten_path = 0
" }

" ctrlp and plugins {
let g:ctrlp_mruf_case_sensitive = 0
let g:ctrlp_map = '<nop>'
let g:ctrlp_tilde_homedir = 1
let g:ctrlp_extensions = ['funky']
let g:ctrlp_custom_ignore = {
            \ 'dir':  'node_modules\|DS_Store\|vendor\|_book',
            \ 'file': '\v\.(log|so|pyc)$',
            \ }
" nnoremap <C-@> :CtrlPMixed<CR>
nnoremap <C-space> :CtrlPMixed<CR>
" show all history vim commands and enter fuzzy search
nnoremap <leader>; :CtrlPCmdline<CR>
" yankring {
let g:ctrlp_yankring_limit = 100
nnoremap <leader>p :CtrlPYankring<CR>
" }
" funky {
let g:ctrlp_funky_use_cache = 1
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

" }
