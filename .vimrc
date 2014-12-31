set cc=100
"Set mapleader
let mapleader = ","
"Fast reloading of the .vimrc
map <silent> <leader>ss :source ~/.vimrc<cr>
"Fast editing of .vimrc
map <silent> <leader>ee :e ~/.vimrc<cr>
set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin
set nu!
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set guifont=Courier_new:h14:cDEFAULT
colorscheme desert 
syntax enable 
syntax on
filetype on
set ts=4
set expandtab
set tags=tags; 
set autochdir
set si 
set sw=4
set ts=4
set et
set go= "无菜单、工具栏"
if(has("win32") || has("win95") || has("win64") || has("win16"))
    let g:iswindows=1
else
    let g:iswindows=0
endif
autocmd BufEnter * lcd %:p:h

"TagList配置
let Tlist_Show_One_File=1 
let Tlist_Exit_OnlyWindow=1

"WinManager配置
let g:winManagerWindowLayout='FileExplorer|TagList' 
nmap wm :WMToggle<cr>

let g:miniBufExplMapCTabSwitchBufs=1 
let g:miniBufExplMapWindowsNavVim=1 
let g:miniBufExplMapWindowNavArrows=1

map <F12> :call Do_CsTag()<CR>

nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-@>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR> 

function LoadCscope()
	if (executable("cscope") && has("cscope"))
		let UpperPath = findfile("cscope.out", ".;")
		if (!empty(UpperPath))
			let path = strpart(UpperPath, 0, match(UpperPath, "cscope.out$") - 1)	
			if (!empty(path))
				let s:CurrentDir = getcwd()
				let direct = strpart(s:CurrentDir, 0, 2) 
				let s:FullPath = direct . path
				let s:AFullPath = globpath(s:FullPath, "cscope.out")
				let s:CscopeAddString = "cs add " . s:AFullPath . " " . s:FullPath 
				execute s:CscopeAddString 
			endif
		endif
	endif
endfunction
command LoadCscope call LoadCscope()
call LoadCscope()
au BufEnter /* call LoadCscope()
function Do_CsTag()
    let dir = getcwd()
    if filereadable("tags")
        if(g:iswindows==1)
            let tagsdeleted=delete(dir."\\"."tags")
        else
            let tagsdeleted=delete("./"."tags")
        endif
        if(tagsdeleted!=0)
            echohl WarningMsg | echo "Fail to do tags! I cannot delete the tags" | echohl None
            return
        endif
    endif
    if has("cscope")
        silent! execute "cs kill -1"
    endif
    if filereadable("cscope.files")
        if(g:iswindows==1)
            let csfilesdeleted=delete(dir."\\"."cscope.files")
        else
            let csfilesdeleted=delete("./"."cscope.files")
        endif
        if(csfilesdeleted!=0)
            echohl WarningMsg | echo "Fail to do cscope! I cannot delete the cscope.files" | echohl None
            return
        endif
    endif
    if filereadable("cscope.out")
        if(g:iswindows==1)
            let csoutdeleted=delete(dir."\\"."cscope.out")
        else
            let csoutdeleted=delete("./"."cscope.out")
        endif
        if(csoutdeleted!=0)
            echohl WarningMsg | echo "Fail to do cscope! I cannot delete the cscope.out" | echohl None
            return
        endif
    endif
    if(executable('ctags'))
        "silent! execute "!ctags -R --c-types=+p --fields=+S *"
        silent! execute "!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q ."
    endif
    if(executable('cscope') && has("cscope") )
        if(g:iswindows!=1)
            silent! execute "!find . -name '*.h' -o -name '*.c' -o -name '*.cpp' -o -name '*.java' -o -name '*.cs' > cscope.files"
        else
            silent! execute "!dir /s/b *.c,*.cpp,*.h,*.java,*.cs >> cscope.files"
        endif
        silent! execute "!cscope -b"
        execute "normal :"
        if filereadable("cscope.out")
            execute "cs add cscope.out"
        endif
    endif
endfunction


