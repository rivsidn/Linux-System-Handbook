```vim
set rtp+=~/.vim/bundle/vundle
call vundle#rc()

Bundle 'gmarik/vundle'

Bundle 'a.vim'
Bundle 'altercation/vim-colors-solarized'
Bundle 'AutoClose'
Bundle 'cscope.vim'
Bundle 'taglist.vim'
Bundle 'surround.vim'
Bundle 'The-NERD-tree'
"markdown预览
Bundle 'iamcco/markdown-preview.vim'
"markdown标题
Bundle 'majutsushi/tagbar'
"markdown表格
Bundle 'tabular'
Bundle 'table-mode'
Bundle 'lervag/vimtex'
"Bundle 'vim-signature'
"Bundle 'vim-bookmark'
"Bundle 'ucompleteme'

"Brief help of vundle
    ":BundleList
    ":BundleInstall
    ":BundleSearch
    ":BundleClean
    ":help vundle
"End brief help

"show line number, command, status line and so on
set history=1000
set ruler
set number
set showcmd
set showmode
set laststatus=2
set cmdheight=2
set scrolloff=3

"fill space between windows
set fillchars=stl:\ ,stlnc:\ ,vert:\

"turn off annoying err sound
set noerrorbells
set novisualbell
set vb t_vb=

"turn off splash screen
set shortmess=atI

"syntax and theme
syntax on
"colorscheme molokai
set cursorline
"set cursorcolumn

"tab and indent
set smarttab
set shiftwidth=8
set tabstop=8
set autoindent
set cindent

"files,backups and encoding
set nobackup
set noswapfile
set autoread
set autowrite
set autochdir
set fileformats=unix,dos,mac
filetype plugin on
filetype indent on

"text search and replace
set showmatch
set matchtime=2
set hlsearch
set incsearch
set ignorecase
set smartcase
set magic
set lazyredraw
set nowrapscan
set iskeyword+=_,$,@,%,#,-,.

"create new file
nnoremap <Leader>e :call CreateFileUnderCursor()<CR>
function! CreateFileUnderCursor()
    " 获取光标下的文件路径
    let file_path = expand('<cfile>')
    
    " 检查文件是否已经存在
    if filereadable(file_path)
        echo "File already exists: " . file_path
    else
        " 创建新文件并编辑
        execute 'edit ' . file_path
        echo "New file created: " . file_path
    endif
endfunction

"netrw setting
let g:netrw_winsize=20

"taglist setting
let Tlist_Auto_Open=0
let Tlist_Auto_Update=1
let Tlist_Exit_OnlyWindow=1
let Tlist_File_Fold_Auto_Close=1
"let Tlist_Show_One_File=1
nnoremap <silent> <F2> :TlistToggle<CR>
nnoremap <silent> <F8> :TlistOpen<CR>
nnoremap <silent> <F4> :TlistUpdate<CR>
set tags=tags;

"cscope setting
set csprg=/usr/bin/cscope
set cst
set csto=1
set csre
set cspc=3
set cscopequickfix=s-,g-,d-,c-,t-,e-,f-,i-
nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-_>i :cs find i <C-R>=expand("<cfile>")<CR><CR>
nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>
if filereadable("cscope.out")
	cs add cscope.out
endif
if filereadable("../cscope.out")
	cs add ../cscope.out
endif
if filereadable("../../cscope.out")
	cs add ../../cscope.out
endif
if filereadable("../../../cscope.out")
	cs add ../../../cscope.out
endif
if filereadable("../../../../cscope.out")
	cs add ../../../../cscope.out
endif
if filereadable("../../../../../cscope.out")
	cs add ../../../../../cscope.out
endif

"NERDTree setting
"autocmd VimEnter * NERDTree
let NERDTreeWinPos="right"
let NERDTreeShowBookmarks=1
nnoremap <silent> <F9> :NERDTreeToggle<CR>

"LaTeX配置
let g:tex_flavor='latex'
let g:vimtex_compiler_latexmk_engines = {
    \ '_'                : '-pdf',
    \ 'pdflatex'         : '-pdf',
    \ 'dvipdfex'         : '-pdfdvi',
    \ 'lualatex'         : '-lualatex',
    \ 'xelatex'          : '-xelatex',
    \ 'context (pdftex)' : '-pdf -pdflatex=texexec',
    \ 'context (luatex)' : '-pdf -pdflatex=context',
    \ 'context (xetex)'  : '-pdf -pdflatex=''texexec --xtx''',
    \}

let g:vimtex_view_general_viewer = '/usr/bin/evince'

"table-mode setting
let g:table_mode_border=0

"tagbar setting
let g:tagbar_left=1
let g:tagbar_width=30
let g:tagbar_type_markdown = {
        \ 'ctagstype' : 'markdown',
        \ 'kinds' : [
                \ 'h:headings',
        \ ],
    \ 'sort' : 0
\ }
nnoremap tb :TagbarToggle<CR>
```

