function! myspacevim#init() abort
" Start NERDTree
" autocmd VimEnter * NERDTree
" Go to previous (last accessed) window
" autocmd VimEnter * wincmd p
" Open Tagbar
" autocmd VimEnter * TagbarToggle
  " Key Mapping
  nmap <F8> :TagbarToggle<CR>
  nnoremap <silent> q :<C-u>:quit<CR>
  nnoremap <silent> <C-q> :<C-u>:quit!<CR>
  inoremap <silent> <C-q> <Esc>:<C-u>:quit!<CR>
  nnoremap <C-x> :x<CR>
  inoremap <C-x> <Esc>:<C-u>:x<CR>

  " Settings
  set ignorecase
  set incsearch
  set hlsearch
  set showmatch
  set autoindent
  set showcmd
  set showmode
  syntax on

  " LSP
  if executable('sourcekit-lsp')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'sourcekit-lsp',
        \ 'cmd': {server_info->['sourcekit-lsp']},
        \ 'whitelist': ['swift'],
        \ })
  endif
endfunction


