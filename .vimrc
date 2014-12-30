let g:indent_guides_guide_size=1
syntax on
set nu
set cc=100
"Set mapleader
let mapleader = ","
"Fast reloading of the .vimrc
map <silent> <leader>ss :source ~/.vimrc<cr>
"Fast editing of .vimrc
map <silent> <leader>ee :e ~/.vimrc<cr>
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set guifont=Courier_new:h14:cDEFAULT
let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_guide_size = 1


