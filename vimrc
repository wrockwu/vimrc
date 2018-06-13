set nocompatible              " be iMproved, required
filetype off                  " required

"set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'taglist.vim'
Plugin 'molokai'
Plugin 'c.vim'
Plugin 'ctags.vim'
Plugin 'SrcExpl'
Plugin 'Valloric/YouCompleteMe'
"for Python
Plugin 'python.vim'
Plugin 'UltiSnips'
Plugin 'davidhalter/jedi'
"Plugin 'msanders/snipmate.vim'
"Plugin 'vim-syntastic/syntastic'
"Code style
"Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"YouCompleteMe Configure
let g:ycm_global_ycm_extra_conf='~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
"let g:ycm_collect_identifiers_from_tag_files = 1
"let g:SimpylFold_docstring_preview=1
let python_highlight_all=1

"Below is Vim configure
syntax enable
syntax on
"filetype plugin on

"ste backspace key
set backspace=indent,eol,start

"set foldmethod=indent
"set foldlevel=99
set incsearch
set ruler
set number
set cursorline
set cursorcolumn 
set nocp
set clipboard=unnamed
"set mouse=v
set t_Co=256
colorscheme molokai 

"set Tab equal 4
set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=79
"set noexpandtab
set expandtab
set autoindent

set fileformat=unix

set encoding=utf-8

"set nowrap
"set wrap
"set smarttab
"set match
set showmatch
set matchtime=5
"set ignorecase
"set nohlsearch
set hlsearch
set incsearch
"always show status
set laststatus=2
highlight StatusLine cterm=bold ctermfg=yellow ctermbg=blue

"Tlist setting
"let Tlist_Ctags_Cmd='/home/bwu/bin/bin/ctags'
let Tlist_Show_One_File=0
let Tlist_Sort_Type="name"
let Tlist_Use_Right_Window=1
"let Tlist_Compart_Format=1
let Tlist_Exist_OnlyWindow=1
let Tlist_File_Fold_Auto_Close=1
let Tlist_Enable_Fold_Column=1
"let Tlist_Show_Menu=1
"let Tlist_MaxSubMenu_Items=50
"let Tlist_Max_Tag_Length=20
"let Tlist_Use_SingleClick=1
let Tlist_Auto_Open=1
let Tlist_Close_On_Select=0
"let Tlist_GainFocus_On_ToggleOpen=0
"let Tlist_Process_File_Always=1
let Tlist_WinHeight=100
"let Tlist_WinWidth=40
let Tlist_WinWidth=30
let Tlist_Auto_Update=1
"let Tlist_Use_Horiz_Window=0
"let Tlist_Exit_OnlyWindow=1
nmap <F4> :Tlist<CR>

"For NERD Tree
let NERDChristmasTree=1
let NERDTreeAutoCenter=1
let NERDTreeMouseMode=2
let NERDTreeShowBookmarks=1
let NERDTreeShowFiles=1
let NERDTreeShowHidden=1
let NERDTreeShowLineNumbers=1
let NERDTreeWinPos='left'
let NERDTreeWinSize=28
nmap <F3> :NERDTreeMirror<CR>
nmap <F3> :NERDTreeToggle<CR>

"set winmanager
"let g:winManagerWindowLayout='FileExplorer|TagList'
"nmap wm :WMToggle<cr>
"let g:winManagerWidth=40

" Enable folding with the spacebar
nnoremap <space> za

"set cscope
nmap <C-]>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-]>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-]>d :cs find d <C-R>=expand("<cword>")<CR><CR> 
nmap <C-]>c :cs find c <C-R>=expand("<cword>")<CR><CR> 
nmap <C-]>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-]>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-]>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-]>i :cs find i <C-R>=expand("<cfile>")<CR><CR>

let g:tag_root_path="/home/binwu/taghome/"
let g:tag_dir=""

function! AutoLoadCTagsAndCScope()
	let max = 5
    "let dir=substitute(system("pwd"), "\n", "/", "g")
    let dir=g:tag_root_path . g:tag_dir . "/"
	let i = 0
	let break = 0
	while isdirectory(dir) && i < max
		if filereadable(dir . 'cscope.out') 
			execute 'cs add ' . dir . 'cscope.out'
			let break = 1
		endif
		if filereadable(dir . 'tags')
			execute 'set tags =' . dir . 'tags'
			let break = 1
		endif
		if break == 1
			execute 'lcd ' . dir
			break
		endif
		let dir = dir . '../'
		let i = i + 1
	endwhile
endf
nmap <F7> :call AutoLoadCTagsAndCScope()<CR>


"get current path and change $HOME to "~"
function! CurDir()
    let curdir = substitute(getcwd(), $HOME, "~", "g")
    return curdir
endfunction
set statusline=[%n]\ %f%m%r%h\ \|\ \ pwd:\ %{CurDir()}\ \|%=\|\ %l,%c\ %p%%\ \ 

"SrcExpl
" // The switch of the Source Explorer 
nmap <F2> :SrcExplToggle<CR> 
 
" // Set the height of Source Explorer window 
let g:SrcExpl_winHeight = 10 

" // Set 100 ms for refreshing the Source Explorer 
let g:SrcExpl_refreshTime = 100 

" // In order to avoid conflicts, the Source Explorer should know what plugins 
" // except itself are using buffers. And you need add their buffer names into 
" // below listaccording to the command ":buffers!" 
let g:SrcExpl_pluginList = [ 
      \ "__Tag_List__", 
      \ "_NERD_tree_" 
      \ ] 

" // Enable/Disable the local definition searching, and note that this is not 
" // guaranteed to work, the Source Explorer doesn't check the syntax for now. 
" // It only searches for a match with the keyword according to command 'gd' 
"let g:SrcExpl_searchLocalDef = 1

" // Do not let the Source Explorer update the tags file when opening 
let g:SrcExpl_isUpdateTags = 1 

" // Use 'Exuberant Ctags' with '--sort=foldcase -R .' or '-L cscope.files' to 
" // create/update a tags file 
"let g:SrcExpl_updateTagsCmd = "ctags -R --c++-kinds=+p --fields=+iaS --extra=+q --sort=foldcase ."

" // Set "<F12>" key for updating the tags file artificially 
"let g:SrcExpl_updateTagsKey = "<F12>"

" // Set "<F3>" key for displaying the previous definition in the jump list 
let g:SrcExpl_prevDefKey = "<F3>"

" // Set "<F4>" key for displaying the next definition in the jump list 
let g:SrcExpl_nextDefKey = "<F4>"
