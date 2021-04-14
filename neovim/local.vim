set relativenumber
set number
set clipboard+=unnamed

" configs {{{

if filereadable('/usr/local/bin/python3')

  let g:python3_host_prog='/usr/local/bin/python3'
else 

  let g:python3_host_prog='/opt/homebrew/bin/python3'
endif

" }}}

" Set <LEADER> as ;
" let mapleader=";"

" Save & quit {{{

" noremap <silent>Q :q<CR>
noremap <silent><C-q> :qa<CR>
noremap <silent>S :w<CR

" }}}

" Keymappings {{{

inoremap jj <esc>
:nnoremap <F5> :buffers<CR>:buffer<Space>
nnoremap <silent> gn :<C-u>tabNext<CR>
nnoremap <silent> <C-q> :<C-u>:quit!<CR>
inoremap <silent> <C-q> <Esc>:<C-u>:quit!<CR>

" disable the arrow buttons
noremap <UP> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
inoremap <C-h> <C-o>h
inoremap <C-j> <C-o>j
inoremap <C-k> <C-o>k
inoremap <C-l> <C-o>l
" }}}

" Markdown {{{

autocmd FileType markdown setlocal nospell

" }}}

" Sround {{{

let g:operator#surround#blocks = {
    \   '-' : [
    \       { 'block' : ['(', ')'], 'motionwise' : ['char', 'line', 'block'], 'keys' : ['(', ')'] },
    \       { 'block' : ['[', ']'], 'motionwise' : ['char', 'line', 'block'], 'keys' : ['[', ']'] },
    \       { 'block' : ['{', '}'], 'motionwise' : ['char', 'line', 'block'], 'keys' : ['{', '}'] },
    \       { 'block' : ['<', '>'], 'motionwise' : ['char', 'line', 'block'], 'keys' : ['<', '>'] },
    \       { 'block' : ['"', '"'], 'motionwise' : ['char', 'line', 'block'], 'keys' : ['"'] },
    \       { 'block' : ["'", "'"], 'motionwise' : ['char', 'line', 'block'], 'keys' : ["'"] },
    \       { 'block' : ['`', '`'], 'motionwise' : ['char', 'line', 'block'], 'keys' : ['`'] },
    \       { 'block' : ['( ', ' )'], 'motionwise' : ['char', 'line', 'block'], 'keys' : [' (', ' )'] },
    \       { 'block' : ['{ ', ' }'], 'motionwise' : ['char', 'line', 'block'], 'keys' : [' {', ' }'] },
    \   ],
    \ }
" }}}

" Start Defx {{{

" autocmd VimEnter * :Defx
" Go to previous (last accessed) window
" autocmd VimEnter * wincmd p

" }}}

" Open Tagbar {{{

" autocmd VimEnter * TagbarToggle
nmap <F8> :TagbarToggle<CR>

" }}}

" Close NerdTree automatically {{{

function! s:CloseIfOnlyControlWinLeft()
  if winnr("$") != 1
    return
  endif
  if (exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1)
       \ || &buftype == 'quickfix'
    q
  endif
endfunction
augroup CloseIfOnlyControlWinLeft
  au!
  au BufEnter * call s:CloseIfOnlyControlWinLeft()
augroup END

" }}}

" Terminal {{{
nmap ;t :bo sp term://zsh\|resize 10<CR>i
tnoremap <Esc> <C-\><C-n>

" }}}

" Omnifunc {{{

autocmd FileType swift setlocal omnifunc=lsp#complete

" }}}

" LSP {{{

if executable('sourcekit-lsp')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'sourcekit-lsp',
        \ 'cmd': {server_info->['sourcekit-lsp']},
        \ 'whitelist': ['swift'],
        \ })
endif

" }}}

" vim-lsp {{{

let g:lsp_log_verbose = 0
let g:lsp_log_file = ""
let g:lsp_diagnostics_enabled = 1

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    nmap <buffer> lgd <plug>(lsp-definition)
    nmap <buffer> lgi <plug>(lsp-implementation)
    nmap <buffer> lpd <plug>(lsp-peek-definition)
    nmap <buffer> lca <plug>(lsp-code-action)
    nmap <buffer> lrn <plug>(lsp-rename)
    nmap <buffer> lnd <plug>(lsp-next-diagnostic)
    nmap <buffer> lpd <plug>(lsp-previous-diagnostic)
    nmap <buffer> lr <plug>(lsp-references)
    nmap <buffer> lpr <plug>(lsp-previous-reference)
    nmap <buffer> lnr <plug>(lsp-next-reference)
    nmap <buffer> lspstatus <plug>(lsp-status)
    " refer to doc to add more commands

endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" }}}

" EasyMotion {{{

let g:EasyMotion_do_mapping = 1
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_upper = 1
let g:EasyMotion_startofline = 0
let g:EasyMotion_prompt = 'Jump to 👉 '
let g:EasyMotion_keys = 'FJDKSWEOAVN'

if dein#tap('vim-easymotion')
	nmap ss <Plug>(easymotion-s2)
	nmap sd <Plug>(easymotion-s)
	" nmap sf <Plug>(easymotion-overwin-f)
	map  sb <Plug>(easymotion-linebackward)
	map  sf <Plug>(easymotion-lineforward)
	" map sl <Plug>(easymotiong:EasyMotion_do_mapping-lineforward)
	map  sj <Plug>(easymotion-j)
	map  sk <Plug>(easymotion-k)
	map  s/ <Plug>(easymotion-sn)
	omap s/ <Plug>(easymotion-tn)
	map  sn <Plug>(easymotion-next)
	map  sp <Plug>(easymotion-prev)
	map  . <Plug>(easymotion-repeat)
endif

" insearch
let g:incsearch#magic = '\v'

" You can use other keymappings like <C-l> instead of <CR> if you want to
" use these mappings as default search and sometimes want to move cursor with
" EasyMotion.
function! s:incsearch_config(...) abort
  return incsearch#util#deepextend(deepcopy({
  \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
  \   'keymap': {
  \     "\<CR>": '<Over>(easymotion)'
  \   },
  \   'is_expr': 0
  \ }), get(a:, 1, {}))
endfunction

noremap <silent><expr> /  incsearch#go(<SID>incsearch_config())
noremap <silent><expr> ?  incsearch#go(<SID>incsearch_config({'command': '?'}))
noremap <silent><expr> g/ incsearch#go(<SID>incsearch_config({'is_stay': 1}))

" incsearch.vim x fuzzy x vim-easymotion

function! s:config_easyfuzzymotion(...) abort
  return extend(copy({
  \   'converters': [incsearch#config#fuzzy#converter()],
  \   'modules': [incsearch#config#easymotion#module()],
  \   'keymap': {"\<CR>": '<Over>(easymotion)'},
  \   'is_expr': 0,
  \   'is_stay': 1
  \ }), get(a:, 1, {}))
endfunction

noremap <silent><expr> <Space>/ incsearch#go(<SID>config_easyfuzzymotion())

" }}}

" Coc {{{

" coc.nvim settings
" ---

" Don't load the defx-git plugin file, not needed
let b:defx_git_loaded = 1

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use <LEADER>h to show documentation in preview window.
nnoremap <silent> <leader>h :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>e <Plug>(coc-rename)

set updatetime=100
set shortmess+=c
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
" if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
"   set signcolumn=number
"  else
"   set signcolumn=yes
" endif

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" }}}

" airline {{{

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
" let g:airline_theme='solarized'
" " let g:airline_solarized_bg='dark'
" let g:airline#extensions#hunks#coc_git = 1
" let g:airline#extensions#branch#format = 1
let g:airline#extensions#vista#enabled = 0

" if !exists('g:airline_symbols')
"     let g:airline_symbols = {}
" endif
" 
" " unicode symbols
" let g:airline_left_sep = '»'
" let g:airline_left_sep = '▶'
" let g:airline_right_sep = '«'
" let g:airline_right_sep = '◀'
" let g:airline_symbols.crypt = '🔒'
" let g:airline_symbols.linenr = '☰'
" let g:airline_symbols.linenr = '␊'
" let g:airline_symbols.linenr = '␤'
" let g:airline_symbols.linenr = '¶'
" let g:airline_symbols.maxlinenr = ''
" let g:airline_symbols.maxlinenr = '㏑'
" let g:airline_symbols.branch = '⎇'
" let g:airline_symbols.paste = 'ρ'
" let g:airline_symbols.paste = 'Þ'
" let g:airline_symbols.paste = '∥'
" let g:airline_symbols.spell = 'Ꞩ'
" let g:airline_symbols.notexists = 'Ɇ'
" let g:airline_symbols.whitespace = 'Ξ'
" 
" " powerline symbols
" let g:airline_left_sep = ''
" let g:airline_left_alt_sep = ''
" let g:airline_right_sep = ''
" let g:airline_right_alt_sep = ''
" let g:airline_symbols.branch = ''
" let g:airline_symbols.readonly = ''
" let g:airline_symbols.linenr = '☰'
" let g:airline_symbols.maxlinenr = ''

" }}}

" coc {{{

let g:coc_global_extensions = [
	\ 'coc-marketplace',
        \ 'coc-actions',
        \ 'coc-css',
        \ 'coc-diagnostic',
        \ 'coc-flutter-tools',
        \ 'coc-gitignore',
        \ 'coc-html',
        \ 'coc-json',
        \ 'coc-lists',
        \ 'coc-prettier',
        \ 'coc-pyright',
        \ 'coc-python',
        \ 'coc-snippets',
        \ 'coc-sourcekit',
        \ 'coc-stylelint',
        \ 'coc-syntax',
        \ 'coc-tasks',
        \ 'coc-todolist',
        \ 'coc-translator',
        \ 'coc-tslint-plugin',
        \ 'coc-tsserver',
        \ 'coc-vimlsp',
        \ 'coc-vetur',
        \ 'coc-yaml',
        \ 'coc-yank',
	\ 'coc-git',
        \ 'coc-vimlsp',
        \ 'coc-sh']

" }}}

" GitGutter {{{

" let g:gitgutter_signs = 0
" let g:gitgutter_sign_allow_clobber = 0
" let g:gitgutter_map_keys = 0
" let g:gitgutter_override_sign_column_highlight = 0
" let g:gitgutter_preview_win_floating = 1
" let g:gitgutter_sign_added = '▎'
" let g:gitgutter_sign_modified = '░'
" let g:gitgutter_sign_removed = '▏'
" let g:gitgutter_sign_removed_first_line = '▔'
" let g:gitgutter_sign_modified_removed = '▒'
" autocmd BufWritePost * GitGutter
" nnoremap <LEADER>gf :GitGutterFold<CR>
" nnoremap H :GitGutterPreviewHunk<CR>
" nnoremap <LEADER>g- :GitGutterPrevHunk<CR>
" nnoremap <LEADER>g= :GitGutterNextHunk<CR

" highlight GitGutterAdd    guifg=#009900 ctermfg=2
" highlight GitGutterChange guifg=#bbbb00 ctermfg=3
" highlight GitGutterDelete guifg=#ff2222 ctermfg=1

" }}}

" Agit {{{

" nnoremap <LEADER>gl :Agit<CR>
" let g:agit_no_default_mappings = 1

" }}}

" auto-save {{

" let g:auto_save = 1 
" let g:auto_save_silent = 1

" }}}

" startify {{{

" returns all modified files of the current git repo
" `2>/dev/null` makes the command fail quietly, so that when we are not
" in a git repo, the list will be empty
function! s:gitModified()
    let files = systemlist('git ls-files -m 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

" same as above, but show untracked files, honouring .gitignore
function! s:gitUntracked()
    let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

let g:startify_lists = [
        \ { 'type': 'files',     'header': ['   MRU']            },
        \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
        \ { 'type': 'sessions',  'header': ['   Sessions']       },
        \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
        \ { 'type': function('s:gitModified'),  'header': ['   git modified']},
        \ { 'type': function('s:gitUntracked'), 'header': ['   git untracked']},
        \ { 'type': 'commands',  'header': ['   Commands']       },
        \ ]

let g:startify_custom_header =
          \ 'startify#center(startify#fortune#cowsay())'

" }}}
