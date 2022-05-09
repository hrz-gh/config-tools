noremap <C-j> 5j
noremap <C-k> 5k

noremap z; ZZ
noremap ; :

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


noremap , :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!clang % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'cpp'
		set splitbelow
		exec "!clang++ -std=c++11 % -Wall -o %<"
		:sp
		:res -15
		:term ./%<
	elseif &filetype == 'sh'
		:!time zsh %
	elseif &filetype == 'python'
		set splitbelow
		:sp
		:term python3 %
    endif
endfunc

filetype on

"display
set encoding=utf-8
set number
set relativenumber
set showmatch
set showcmd
set scrolloff=5
set wrap
set background=dark

"set clipboard=unnamedplus
"set autochdir

set ignorecase
set smartcase

set tabstop=4
set expandtab
set softtabstop=4
set shiftwidth=4
set updatetime=100
set shortmess+=c
set hidden

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
