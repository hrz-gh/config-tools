let mapleader = "\<space>"
noremap <leader><leader> :noh<CR>
noremap <leader>e :e ${VIM_RC}<CR>
noremap <C-j> 5j
noremap <C-k> 5k
noremap z; ZZ
noremap ; :

vnoremap Y "+y
vnoremap Y "+y
noremap gp "+p
noremap gy ggVG"+y
noremap gd ggVGd

noremap <up> :vertical res+5<CR>
noremap <down> :vertical res-5<CR>

noremap te :tabe<CR>
noremap tl :+tabnext<CR>
noremap th :-tabnext<CR>

noremap zk :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
noremap zj :set splitbelow<CR>:split<CR>
noremap zh :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
noremap zl :set splitright<CR>:vsplit<CR>

au! BufNewFile,BufRead *.gv setf dot
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

noremap cc :cclose<CR>
noremap co :copen<CR>
noremap <leader>h /<C-R>=expand("<cword>")<CR><CR>

if has("cscope")
    set csto=0
    set cst
    set nocsverb
    nmap <leader>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <leader>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <leader>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <leader>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    set cscopequickfix=g-,s-,c-,d-,i-,t-,e-
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    " else add database pointed to by environment
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    set csverb
endif

noremap , :call CompileRun()<CR>
func! CompileRun()
	exec "w"
    if &filetype == 'c'
		exec "!clang % -o %<"
        if v:shell_error == 0
		    exec "term ./%<"
        endif
	elseif &filetype == 'cpp'
		exec "!clang++ -std=c++11 % -Wall -o %<"
		exec "!time ./%<"
	elseif &filetype == 'sh'
		:!time zsh %
	elseif &filetype == 'python'
		set splitbelow
		:sp
		:term python3 %
    endif
endfunc

syntax on
filetype on

"display
set encoding=utf-8
set number
set relativenumber
set showmatch
set showcmd
set scrolloff=5
set wrap

"set clipboard=unnamedplus
"set autochdir
set autoindent

set ignorecase
set smartcase

set tabstop=4
set expandtab
set softtabstop=4
set shiftwidth=4
set updatetime=100
set shortmess+=c
set hidden
