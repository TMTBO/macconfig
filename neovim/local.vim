set relativenumber

" Markdown
autocmd FileType markdown setlocal nospell

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

" Start NERDTree
" autocmd VimEnter * NERDTree
" Go to previous (last accessed) window
" autocmd VimEnter * wincmd p
" Open Tagbar
" autocmd VimEnter * TagbarToggle
nmap <F8> :TagbarToggle<CR>

" Close NerdTree automatically
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

" Terminal
nmap t<Enter> :bo sp term://zsh\|resize 10<CR>i
tnoremap <Esc> <C-\><C-n>

" Omnifunc
autocmd FileType swift setlocal omnifunc=lsp#complete

" LSP
if executable('sourcekit-lsp')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'sourcekit-lsp',
        \ 'cmd': {server_info->['sourcekit-lsp']},
        \ 'whitelist': ['swift'],
        \ })
endif

" vim-lsp

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

" keymapping

inoremap jj <esc>
:nnoremap <F5> :buffers<CR>:buffer<Space>
nnoremap <silent> gn :<C-u>tabNext<CR>
nnoremap <silent> <C-q> :<C-u>:quit!<CR>
inoremap <silent> <C-q> <Esc>:<C-u>:quit!<CR>

" EasyMotion

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
