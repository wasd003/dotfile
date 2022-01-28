" Basic settings
set number
set mouse=a
syntax on
set cursorline
set smartindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set backspace=indent,eol,start
nmap no :noh<CR>
nmap p :set paste<CR>i

" NerdTree
map <C-y> :NERDTreeMirror<CR>
map <C-y> :NERDTreeToggle<CR>
map <C-l> :tabn<CR>
map <C-h> :tabp<CR>
map <C-n> :tabnew<CR>

" Vim Visual Multi
let g:VM_maps = {}
let g:VM_maps['Find Under']         = '<C-k>'           " replace C-n
let g:VM_maps['Find Subword Under'] = '<C-k>'           " replace visual C-n

" AirLine
let g:airline#extensions#tabline#enabled = 1

" GitGutter
set updatetime=100 " add this to make gitgutter refresh fast
highlight clear SignColumn
highlight GitGutterAdd ctermfg=green
highlight GitGutterChange ctermfg=yellow
highlight GitGutterDelete ctermfg=red

" Easy Motion
nmap <space>  <Plug>(easymotion-s2)

" gruvbox color theme
" solve gruvbox theme not found error:
"	mkdir -p ~/.vim/colors
" 	cp ~/.vim/plugged/gruvbox/colors/gruvbox.vim ~/.vim/colors/gruvbox.vim 
set bg=dark
let g:gruvbox_contrast_dark = 'medium' " option value: soft|medium|hard
let g:gruvbox_contrast_light = 'hard'
colorscheme gruvbox             
set guifont=Monaco:h17          " FontFamily and FontSize

" Coc Config
set hidden
set updatetime=100
set shortmess+=c
" use tab to trigger auto commenption
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
	  let col = col('.') - 1
	    return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" Use `pe` and `ne` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics 
nmap <silent> pe <Plug>(coc-diagnostic-prev)
nmap <silent> ne <Plug>(coc-diagnostic-next)"
" Code Navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Use H to show documentation in preview window.
nnoremap <silent> H :call <SID>show_doc()<CR>
function! <SID>show_doc()
  if (index(['vim','help'], &filetype) >= 0)
	execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
	call CocActionAsync('doHover')
  else
	execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
" Symbol renaming.
nmap <silent>rn <Plug>(coc-rename)

" CoC Plug
let g:coc_global_extensions = ['coc-json', 'coc-marketplace', 'coc-python', 'coc-vimlsp', 'coc-cmake']

" CoC Commands
" CocList
" CocList marketplace
" CocInstall
" CocConfig - open coc-settings.json


" Vim Plug
call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'dir': '~/opt/fzf'  }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'kien/ctrlp.vim'
Plug 'easymotion/vim-easymotion'
Plug 'mg979/vim-visual-multi'
Plug 'vim-airline/vim-airline'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'morhetz/gruvbox'
Plug 'MattesGroeger/vim-bookmarks'
call plug#end()

" Vim Plug Commands
" :PlugInstall
" :PlugClean             - Remove unlisted plugins
" :PlugUpgrade       - Upgrade vim-plug itself
" :PlugUpdate            - Install or update plugins
" :PlugStatus            - List plugins
