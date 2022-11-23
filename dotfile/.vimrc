

" __     _____ __  __ ____   ____  "
" \ \   / /_ _|  \/  |  _ \ / ___| "
"  \ \ / / | || |\/| | |_) | |     "
"   \ V /  | || |  | |  _ <| |___  "
"    \_/  |___|_|  |_|_| \_\\____| "
"                                  "


" Basic Settings
syntax on
set number
set cursorline
set hlsearch
set smartindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set backspace=indent,eol,start
set guifont=Monaco:h17          " FontFamily and FontSize
set t_Co=256
set t_ut=
set foldmethod=manual 
" zfa{ to fold {}
" zd to delete folding

" Custom Commands
nmap noh :noh<CR>
nnoremap <F2> :set paste<CR>i
inoremap <F2> <Esc>:set paste<CR>i
nnoremap nop :set nopaste<CR>
inoremap nop <Esc>:set nopaste<CR>
nnoremap now :set nowrap<CR>
inoremap now <Esc>:set nowrap<CR>
nnoremap <c-s> :w<CR> 
inoremap <c-s> <Esc>:w<CR>
nnoremap <c-z> u 


" Cursor Shape
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

augroup myCmds
au!
autocmd VimEnter * silent !echo -ne "\e[2 q"
augroup END


" True Color Supports
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif


" NerdTree
map <C-y> :NERDTreeMirror<CR>
map <C-y> :NERDTreeToggle<CR>
map <C-l> :tabn<CR>
map <C-h> :tabp<CR>
map <C-n> :tabnew<CR>


" Tmux Complete
" <c-x> <c-u> 


" Vim Visual Multi
let g:VM_maps = {}
let g:VM_maps['Find Under']         = '<C-k>'           " replace C-n
let g:VM_maps['Find Subword Under'] = '<C-k>'           " replace visual C-n


" FZF for global search
nnoremap <s-f> :Ag<Space>


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


" Color Theme

" solve theme not found error:
" mkdir -p ~/.vim/colors
" cp ~/.vim/plugged/${plug}/colors/${plug}.vim ~/.vim/colors/
" (optionally) cp ~/.vim/plugged/${plug}/autoload/${plug}.vim ~/.vim/autoload/

" Theme - OneHalf
" colorscheme onehalfdark
" let g:airline_theme='onehalfdark'

" Theme - OneDark
colorscheme onedark
let g:airline_theme='onedark'

" Theme - CodeDark
" colorscheme codedark
" let g:airline_theme = 'codedark'

" Theme - Sonokai
" let g:sonokai_style = 'atlantis'
" colorscheme sonokai


" Coc.nvim 
set hidden
set updatetime=100
set shortmess+=c

" <c-t> to type tab
inoremap <c-t> <TAB> 

" <c-a> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-a> coc#refresh()
else
  inoremap <silent><expr> <c-a> coc#refresh()
endif

" <tab> to go down next completion entry
inoremap <silent><expr> <TAB> 
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

" <shift> <tab> to go up previous completion entry
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
	  let col = col('.') - 1
	    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" <CR> to select current completion entry.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" util commands
" gd: goto definition
" gr: goto reference
" gt: goto type
" gi: goto implementation
" rn: rename
" pe: previous error
" ne: next error
" ss: show symbol
" se: show error
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> rn <Plug>(coc-rename)
nmap <silent> pe <Plug>(coc-diagnostic-prev)
nmap <silent> ne <Plug>(coc-diagnostic-next)
nnoremap <silent><nowait> ss :<C-u>CocList outline<cr>
nnoremap <silent><nowait> se :<C-u>CocList diagnostics<cr>

" CoC Plug
"    cxx lsp: <sudo apt install ccls>
"    shell lsp: <sudo npm i -g bash-language-server>
"    python lsp: just install coc-pyright in fine.
"    rust lsp: rust-analyzer . open any rust file, it'll be installed automatically.
let g:coc_global_extensions = []
" let g:coc_global_extensions += ['coc-ccls'] 
let g:coc_global_extensions += ['coc-sh'] 
let g:coc_global_extensions += ['coc-pyright']
let g:coc_global_extensions += ['coc-rust-analyzer']
let g:coc_global_extensions += ['coc-vimlsp']
let g:coc_global_extensions += ['coc-marketplace']
" CoC Commands
" CocList
" CocList extensions: Check all installed extensions.
"                     Enter <Tab> in extension list to manage specific coc-plugin
" CocList marketplace: Open marketplace
" CocInstall
" CocConfig - open coc-settings.json


" LeaderF
" let g:Lf_WindowPosition = 'popup'
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
Plug 'preservim/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'easymotion/vim-easymotion'
Plug 'mg979/vim-visual-multi'
Plug 'vim-airline/vim-airline'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sonph/onehalf', { 'rtp': 'vim'  }
Plug 'joshdick/onedark.vim'
Plug 'tomasiser/vim-code-dark'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension'  }
Plug 'wellle/tmux-complete.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'Yggdroot/indentLine'
Plug 'luochen1990/rainbow'
Plug 'junegunn/fzf', { 'dir': '~/opt/fzf'  }
Plug 'junegunn/fzf.vim'
Plug 'j5shi/CommandlineComplete.vim'
call plug#end()

" Vim Plug Commands
" :PlugInstall
" :PlugClean             - Remove unlisted plugins
" :PlugUpgrade       - Upgrade vim-plug itself
" :PlugUpdate            - Install or update plugins
" :PlugStatus            - List plugins
