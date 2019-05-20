"""""""""
"  Pip  "
"""""""""

if empty(glob('~/.config/pip/pip.conf'))
  silent !mkdir -p ~/.config/pip/
  silent !echo '[install]' > ~/.config/pip/pip.conf
  silent !echo 'user = yes' >> ~/.config/pip/pip.conf
  silent !echo 'no-binary = :all:' >> ~/.config/pip/pip.conf
endif

"""""""""""""""""
"  Basic setup  "
"""""""""""""""""

if empty(glob('~/.vim/setup_complete'))
  silent !pip install --upgrade pynvim
  silent !touch ~/.vim/setup_complete
endif

""""""""""""""
"  Vim Plug  "
""""""""""""""

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

if has("win64") || has("win32") || has("win16")
  call plug#begin('~/vimfiles/bundle')
else
  call plug#begin('~/.vim/bundle')
endif

""""""""""""""
"  Deoplete  "
""""""""""""""

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim',
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'Shougo/vimproc.vim', {'do': 'make'}

Plug 'Shougo/neco-syntax'

"""""""""""""
"  Haskell  "
"""""""""""""

" Plug 'bitc/vim-hdevtools'
" let g:hdevtools_stack = 1
" au FileType haskell nnoremap <buffer> <F1> :HdevtoolsType<CR>
" au FileType haskell nnoremap <buffer> <silent> <F2> :HdevtoolsInfo<CR>
" au FileType haskell nnoremap <buffer> <silent> <F3> :HdevtoolsClear<CR>

" Plug 'philopon/hassistant.vim', {'do': 'sh build.sh'}

Plug 'eagletmt/ghcmod-vim'
Plug 'eagletmt/neco-ghc'

" let g:necoghc_use_stack = 1

au FileType haskell nnoremap <silent> <leader>l :call term_sendkeys(term_list()[0], ":l Solution\<lt>CR>")<CR>
au FileType haskell nnoremap <silent> <leader>t :!stack runghc Test.hs<CR>

vnoremap <silent> <leader>x "xy :call term_sendkeys(term_list()[0], getreg("x"))<CR> 
nnoremap <silent> <leader>xx "xy :call term_sendkeys(term_list()[0], "!!\<lt>CR>")<CR> 

nnoremap <silent> h "h"
nnoremap <silent> j "j"
nnoremap <silent> k "k"
nnoremap <silent> l "l"

"""""""""""""""""""""
"  Language Client  "
"""""""""""""""""""""

Plug 'autozimu/LanguageClient-neovim', {
  \ 'branch': 'next',
  \ 'do': 'bash install.sh',
  \ }

""""""""""""
"  CSharp  "
""""""""""""

au FileType cs nnoremap <leader>t :call term_sendkeys(term_list()[0], "dotnet test\<lt>CR>")<CR>

"""""""""""""""
"  OmniSharp  "
"""""""""""""""


" Plug 'OmniSharp/omnisharp-vim'
" let g:OmniSharp_highlight_types = 1
" let g:OmniSharp_proc_debug = 1
" let g:OmniSharp_loglevel = 'debug'

" desperate attempts to make it work

" let g:OmniSharp_start_server = 0
" let g:OmniSharp_port = 2000
" let g:OmniSharp_server_use_mono = 1

"""""""""
"  ALE  "
"""""""""

Plug 'w0rp/ale'
let g:ale_linters = {
  \   'haskell': ['ghc-mod'],
  \   'cs': []
  \}

let g:ale_haskell_ghc_mod_executable = "stack"

""""""""""""""
"  NERDTree  "
""""""""""""""

Plug 'scrooloose/nerdtree'

"""""""""""""""""""""""""
"  NERDTree git plugin  "
"""""""""""""""""""""""""

" Plug 'Xuyuanp/nerdtree-git-plugin'

" let g:NERDTreeIndicatorMapCustom = {
"     \ "Modified"  : "✹",
"     \ "Staged"    : "✚",
"     \ "Untracked" : "✭",
"     \ "Renamed"   : "➜",
"     \ "Unmerged"  : "═",
"     \ "Deleted"   : "✖",
"     \ "Dirty"     : "✗",
"     \ "Clean"     : "✔︎",
"     \ 'Ignored'   : '☒',
"     \ "Unknown"   : "?"
"     \ }

"""""""""""""""""""
"  NERDCommenter  "
"""""""""""""""""""

Plug 'scrooloose/nerdcommenter'

let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'

"""""""""""""
"  Airline  "
"""""""""""""

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
" let g:airline_left_sep = ''
" let g:airline_left_alt_sep = ''
" let g:airline_right_sep = ''
" let g:airline_right_alt_sep = ''
" let g:airline_symbols.branch = ''
" let g:airline_symbols.readonly = ''
" let g:airline_symbols.linenr = ''
" let g:airline_symbols.whitespace = ''

let g:airline_powerline_fonts = 1
let g:airline_theme = 'dark'

"""""""""""
"  LaTeX  "
"""""""""""

Plug 'lervag/vimtex'
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'

"""""""""""""""
"  UltiSnips  "
"""""""""""""""

Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let g:UltiSnipsEditSplit = "vertical"
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips', 'UltiSnips']
imap  <S-Tab> <C-R>=UltiSnips#ListSnippets()<CR>

""""""""""""
"  Prolog  "
""""""""""""

Plug 'mxw/vim-prolog'

"""""""""
"  Git  "
"""""""""

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
set updatetime=1000

Plug 'ryanoasis/vim-devicons'

""""""""""""""
"  Checkbox  "
""""""""""""""

Plug 'jkramer/vim-checkbox'

"""""""""""""""
"  Bufferize  "
"""""""""""""""

Plug 'AndrewRadev/bufferize.vim'


""""""""""""""
"  Coquille  "
""""""""""""""

" Plug 'let-def/vimbufsync'
" Plug 'Larhard/coquille'
" Plug 'jvoorhis/coq.vim'

" au FileType coq nnoremap <leader>cl :CoqLaunch<CR>
" au FileType coq nnoremap <leader>cu :CoqUndo<CR>
" au FileType coq nnoremap <leader>cn :CoqNext<CR>
" au FileType coq nnoremap <leader>ct :CoqToCursor<CR>
" au FileType coq nnoremap <leader>ck :CoqKill<CR>
" au FileType coq nnoremap <leader>cp :Coq Print 
" au FileType coq nnoremap <leader>cc :Coq Check 

" au FileType coq nnoremap <F2> :CoqUndo<CR>
" au FileType coq nnoremap <F3> :CoqNext<CR>
" au FileType coq nnoremap <F4> :CoqToCursor<CR>


""""""""""""""""
"  Coq au Vim  "
""""""""""""""""

" Plug 'https://manu@framagit.org/manu/coq-au-vim.git'
" Plug 'Larhard/coq-au-vim'
Plug 'https://framagit.org/Larhard/coq-au-vim.git'
Plug 'jvoorhis/coq.vim'

au FileType coq nnoremap <leader>cs :CoqStart<CR>
au FileType coq nnoremap <leader>cq :CoqQuit<CR>
au FileType coq nnoremap <leader>cu :CoqRewind<CR>
au FileType coq nnoremap <leader>cn :CoqNext<CR>
au FileType coq nnoremap <leader>ct :CoqToCursor<CR>
au FileType coq nnoremap <leader>ck :CoqKill<CR>
au FileType coq nnoremap <leader>cp :CoqQuery Print 
au FileType coq nnoremap <leader>cc :CoqQuery Check 

au FileType coq nnoremap <F2> :CoqRewind<CR>
au FileType coq nnoremap <F3> :CoqNext<CR>
au FileType coq nnoremap <F4> :CoqToCursor<CR>

hi default CoqSent    guibg=#661100 ctermbg=darkred
hi default CoqAdded   guibg=#664400 ctermbg=brown
hi default CoqChecked guibg=#113300 ctermbg=darkblue

" :breakadd file ~/.vim/bundle/coq-au-vim/autoload/coqtop.vim
" set verbose=9
" set verbosefile=~/.vim/bundle/coq-au-vim/autoload/coqtop.vim

" Time
" R communication
" Job
" Xml
" M
" H
" F
" let g:coq_debug = "trjxmhf"
au FileType coq CoqStart
" au FileType coq CoqNext

call plug#end()

"""""""""""""
"  GHC Mod  "
"""""""""""""

let g:airline#extensions#ale#enabled = 1

""""""""""""""
"  Deoplete  "
""""""""""""""

" autocmd FileType cs call deoplete#custom#buffer_option('auto_complete', v:false)

""""""""""""""
"  Neco GHC  "
""""""""""""""

let g:deoplete#enable_at_startup = 1
" let g:neocomplete#enable_at_startup = 0

""""""""""""""""""""""""""""""
"  Language Server Protocol  "
""""""""""""""""""""""""""""""

set hidden

let g:LanguageClient_serverCommands = {
  \ 'sh': ['/usr/bin/bash-language-server', 'start'],
  \ 'python': ['/usr/bin/pyls'],
  \ }

"""""""""""
"  Other  "
"""""""""""

set autoindent
syntax on
set expandtab
set number
set tabstop=4
set shiftwidth=4
set modeline
set shell=bash
filetype plugin on

nnoremap <silent> <leader>h :syntax sync fromstart<CR>
nnoremap <silent> <leader>m :messages<CR>

"""""""""""
"  Debug  "
"""""""""""

" vim:set et sw=2 ts=2:
