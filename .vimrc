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
nnoremap <F2> :set paste<CR>i
inoremap <F2> <Esc>:set paste<CR>i
nnoremap <c-s> :w<CR> 
inoremap <c-s> <Esc>:w<CR>
nnoremap <c-z> u 


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


" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_section_x=''
let g:airline_section_z=''
let g:airline_section_error=''
let g:airline_section_warning=''


" GitGutter
set updatetime=100 " add this to make gitgutter refresh fast
highlight clear SignColumn
highlight GitGutterAdd ctermfg=green
highlight GitGutterChange ctermfg=yellow
highlight GitGutterDelete ctermfg=red
nmap nc <Plug>(GitGutterNextHunk)
nmap pc <Plug>(GitGutterPrevHunk)


" Easy Motion
nmap <space>  <Plug>(easymotion-s2)


" Vim Commentary
autocmd FileType python,shell,coffee set commentstring=#\ %s


" Gruvbox Color Theme
" use this command to solve gruvbox theme not found error:
" mkdir -p ~/.vim/colors
" cp ~/.vim/plugged/gruvbox/colors/gruvbox.vim ~/.vim/colors/gruvbox.vim 
set bg=dark
let g:gruvbox_contrast_dark = 'medium' " option value: soft|medium|hard
let g:gruvbox_contrast_light = 'hard'
colorscheme gruvbox             
set guifont=Monaco:h17          " FontFamily and FontSize


" Coc.nvim 
set hidden
set updatetime=100
set shortmess+=c
" tab auto commenption
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
	  let col = col('.') - 1
	    return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" Use `pe` and `ne` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics 
nmap <silent> pe <Plug>(coc-diagnostic-prev)
nmap <silent> ne <Plug>(coc-diagnostic-next)"
" Symbol renaming.
nmap <silent>rn <Plug>(coc-rename)
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
" CoC Plug
let g:coc_global_extensions = ['coc-json', 'coc-marketplace', 'coc-python', 'coc-vimlsp', 'coc-cmake', 'coc-java']
" CoC Commands
" CocList
" CocList marketplace
" CocInstall
" CocConfig - open coc-settings.json


" LeaderF
let g:Lf_WindowPosition = 'popup'
" use <Up> and <Down> to navigate result just like C-k and C-j
let g:Lf_CommandMap = {'<C-K>': ['<Up>'], '<C-J>': ['<Down>']}
let g:Lf_ShowDevIcons = 0
" use ctrl + p to search file
nmap <C-p> :LeaderfFile<CR>
" use ctrl + f to search current file
nmap <C-f> :LeaderfLine<CR>
" use C-r to switch between fuzzy mode and regexp mode 


" Vim Plug
call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'dir': '~/opt/fzf'  }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'easymotion/vim-easymotion'
Plug 'mg979/vim-visual-multi'
Plug 'vim-airline/vim-airline'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'morhetz/gruvbox'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension'  }
call plug#end()
" Vim Plug Commands
" :PlugInstall
" :PlugClean             - Remove unlisted plugins
" :PlugUpgrade       - Upgrade vim-plug itself
" :PlugUpdate            - Install or update plugins
" :PlugStatus            - List plugins

